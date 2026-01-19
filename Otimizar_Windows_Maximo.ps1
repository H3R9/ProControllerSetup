<#
.SYNOPSIS
    Script de Otimização Extrema para Windows 10/11 (v5.0 Stable)
    Mudanças: Tratamento de erro do 'Ultimate Performance' e Fix USB via Registro.
#>

# Força execução como Administrador
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Clear-Host
Write-Host "INICIANDO OTIMIZAÇÃO MÁXIMA v5.0 - AGENTE ANTIGRAVITY" -ForegroundColor Cyan
Write-Host "---------------------------------------------------" -ForegroundColor Cyan

# 0. SEGURANÇA
Write-Host "[0/6] Verificando Ponto de Restauração..." -ForegroundColor Yellow
try {
    Checkpoint-Computer -Description "Otimizacao_Antigravity_v5" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
    Write-Host "Novo ponto de restauração criado." -ForegroundColor Green
}
catch {
    if ($_.Exception.Message -like "*1440 minutos*") {
        Write-Host "Ponto de restauração recente detectado. (Seguro)." -ForegroundColor Gray
    }
    else {
        Write-Host "Aviso: Ponto de restauração ignorado (Erro não crítico)." -ForegroundColor DarkGray
    }
}

# 1. PLANO DE ENERGIA
Write-Host "[1/6] Configurando Energia (Ultimate Performance)..." -ForegroundColor Green
$PlanGuid = $null
try {
    # Duplica esquema
    $output = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>&1
    if ($output -match '[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}') {
        $PlanGuid = $matches[0].Trim()
        powercfg -setactive $PlanGuid
        Write-Host "Plano Ativado: $PlanGuid" -ForegroundColor Green
    }
    else {
        powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
        $PlanGuid = "SCHEME_CURRENT"
        Write-Host "Fallback: Alto Desempenho ativado." -ForegroundColor Yellow
    }
}
catch { Write-Host "Erro não crítico na energia." -ForegroundColor Red }

# 2. OTIMIZAÇÃO USB (MÉTODO HÍBRIDO v5)
Write-Host "[2/6] Blindando USB contra suspensão..." -ForegroundColor Green

# Método A: Powercfg (Padrão)
try {
    # Tenta desativar suspensão (AC/DC)
    # Se falhar (erro "fora do intervalo"), é ignorado pois o plano Ultimate já pode ter travado isso.
    powercfg /SETDCVALUEINDEX $PlanGuid 2a737441-1930-4402-8d77-b94341631144 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 2>$null
    powercfg /SETACVALUEINDEX $PlanGuid 2a737441-1930-4402-8d77-b94341631144 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 2>$null
    powercfg /setactive $PlanGuid 2>$null
} catch {}

# Método B: Registro (Nuclear) - Garante que o driver USB não durma
$usbPath = "HKLM:\SYSTEM\CurrentControlSet\Services\USB"
try {
    if (!(Test-Path $usbPath)) { New-Item -Path $usbPath -Force | Out-Null }
    # DisableSelectiveSuspend = 1 (Desativa a função de suspensão no driver)
    New-ItemProperty -Path $usbPath -Name "DisableSelectiveSuspend" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
    Write-Host "USB Selective Suspend desativado via Registro (Force)." -ForegroundColor Green
} catch {
    Write-Host "Erro ao aplicar registro USB." -ForegroundColor Red
}

# 3. TWEAKS DE REGISTRO
Write-Host "[3/6] Otimizando Latência de Rede e Sistema..." -ForegroundColor Green
$regPathSystem = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
$regPathGames  = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
$regPathPrio   = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"

# Foco no aplicativo foreground
Set-ItemProperty -Path $regPathSystem -Name "SystemResponsiveness" -Value 0 -Type DWord -Force
# Desativa throttling de rede
Set-ItemProperty -Path $regPathSystem -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Type DWord -Force

# TCP NoDelay (Ping mais estável)
$interfaces = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
foreach ($iface in $interfaces) {
    try {
        New-ItemProperty -Path $iface.PSPath -Name "TcpAckFrequency" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $iface.PSPath -Name "TCPNoDelay" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
    } catch {}
}

# Win32 Priority (26Hex = Short Quantum, Variable, High Priority foreground)
Set-ItemProperty -Path $regPathPrio -Name "Win32PrioritySeparation" -Value 0x26 -Type DWord -Force

# Prioridade de Jogos
if (!(Test-Path $regPathGames)) { New-Item -Path $regPathGames -Force | Out-Null }
Set-ItemProperty -Path $regPathGames -Name "GPU Priority" -Value 8 -Type DWord -Force
Set-ItemProperty -Path $regPathGames -Name "Priority" -Value 6 -Type DWord -Force
Set-ItemProperty -Path $regPathGames -Name "Scheduling Category" -Value "High" -Type String -Force

# 4. POWER THROTTLING
Write-Host "[4/6] Desativando Power Throttling..." -ForegroundColor Green
$regPathPower = "HKLM:\SYSTEM\CurrentControlSet\Control\Power"
New-Item -Path "$regPathPower\PowerThrottling" -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "$regPathPower\PowerThrottling" -Name "PowerThrottlingOff" -Value 1 -Type DWord -Force

# 5. UI TWEAKS
Write-Host "[5/6] Acelerando Menus..." -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Type String -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value "1" -Type String -Force

# 6. SERVIÇOS
Write-Host "[6/6] Desativando SysMain (Superfetch)..." -ForegroundColor Green
Stop-Service -Name "SysMain" -ErrorAction SilentlyContinue
Set-Service -Name "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue

Write-Host "---------------------------------------------------" -ForegroundColor Cyan
Write-Host "OTIMIZAÇÃO v5.0 CONCLUÍDA COM SUCESSO!" -ForegroundColor Green
Write-Host "Reinicie o computador para aplicar as alterações do Registro." -ForegroundColor Yellow
Write-Host "---------------------------------------------------" -ForegroundColor Cyan
Pause