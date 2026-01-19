<#
.SYNOPSIS
    Script de Otimização Extrema para Windows 11 (Foco: Menor Input Lag e Latência)
    Cuidado: Este script altera configurações profundas do sistema.
    RECOMENDADO: CRIAR PONTO DE RESTAURAÇÃO ANTES DE EXECUTAR.
#>

Write-Host "INICIANDO OTIMIZAÇÃO MÁXIMA - AGENTE ANTIGRAVITY" -ForegroundColor Cyan
Write-Host "Por favor, execute este script como ADMINISTRADOR." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# 1. PLANO DE ENERGIA: DESEMPENHO MÁXIMO
Write-Host "[1/5] Ativando Plano de Energia 'Desempenho Máximo'..." -ForegroundColor Green
try {
    # Tenta duplicar o perfil de Desempenho Máximo oculto
    $powerPlan = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    if ($powerPlan) {
        $planGuid = $powerPlan.Split(" ")[3]
        powercfg -setactive $planGuid
        Write-Host "Plano 'Desempenho Máximo' ativado com sucesso!" -ForegroundColor Green
    }
    else {
        Write-Host "Plano já existe ou falha ao criar. Setando 'Alto Desempenho' padrão." -ForegroundColor Yellow
        powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    }
}
catch {
    Write-Host "Erro ao configurar energia." -ForegroundColor Red
}

# 2. OTIMIZAÇÃO USB (Desativar economia de energia)
Write-Host "[2/5] Desativando Suspensão Seletiva USB..." -ForegroundColor Green
# Desabilita suspensão USB na bateria e na tomada
powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b94341631144 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b94341631144 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /setactive scheme_current

# 3. TWEAKS DE REGISTRO (LATÊNCIA E PRIORIDADE)
Write-Host "[3/5] Aplicando Tweaks de Registro (Regedit)..." -ForegroundColor Green

$regPathSystemProfile = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
$regPathGames = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
$regPathPriority = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"


# SystemResponsiveness -> 0 (Focar 100% no foreground app)
Set-ItemProperty -Path $regPathSystemProfile -Name "SystemResponsiveness" -Value 0 -Type DWord -Force
Write-Host "SystemResponsiveness setado para 0."

# NetworkThrottlingIndex -> FFFFFFFF (Desativar limitação de rede para jogos)
Set-ItemProperty -Path $regPathSystemProfile -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Type DWord -Force
Write-Host "Network Throttling Desativado."

# TWEAKS DE REDE (TCP NoDelay / AckFrequency)
# Reduz o 'ping' de processamento de pacotes para jogos online
$regPathTCP = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
$interfaces = Get-ChildItem $regPathTCP
foreach ($interface in $interfaces) {
    try {
        New-ItemProperty -Path $interface.PSPath -Name "TcpAckFrequency" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $interface.PSPath -Name "TCPNoDelay" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
    }
    catch {}
}
Write-Host "TCP NoDelay e AckFrequency aplicados em todas as interfaces."

# Win32PrioritySeparation -> 26 (Hex) (Otimizar resposta de processos)
Set-ItemProperty -Path $regPathPriority -Name "Win32PrioritySeparation" -Value 0x26 -Type DWord -Force
Write-Host "Win32PrioritySeparation ajustado para 26 (Hex)."

# Games Priority (GPU e CPU)
if (!(Test-Path $regPathGames)) { New-Item -Path $regPathGames -Force | Out-Null }
Set-ItemProperty -Path $regPathGames -Name "GPU Priority" -Value 8 -Type DWord -Force
Set-ItemProperty -Path $regPathGames -Name "Priority" -Value 6 -Type DWord -Force
Set-ItemProperty -Path $regPathGames -Name "Scheduling Category" -Value "High" -Type String -Force
Set-ItemProperty -Path $regPathGames -Name "SFIO Priority" -Value "High" -Type String -Force
Write-Host "Prioridade de Jogos maxed out (GPU=8, Priority=6)."

# 4. DESATIVAR POWER THROTTLING GLOBAL
Write-Host "[4/5] Desativando Power Throttling..." -ForegroundColor Green
$regPathPower = "HKLM:\SYSTEM\CurrentControlSet\Control\Power"
if (!(Test-Path $regPathPower)) { New-Item -Path $regPathPower -Force | Out-Null }
New-Item -Path $regPathPower -Name "PowerThrottling" -Force | Out-Null
Set-ItemProperty -Path "$regPathPower\PowerThrottling" -Name "PowerThrottlingOff" -Value 1 -Type DWord -Force
Write-Host "Power Throttling Desativado."

# 5. MENUS MAIS RÁPIDOS
Write-Host "[5/5] Acelerando menus do Windows..." -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Type String -Force

Write-Host "---------------------------------------------------" -ForegroundColor Cyan
Write-Host "OTIMIZAÇÃO CONCLUÍDA!" -ForegroundColor Cyan
Write-Host "Reinicie o PC para que todas as alterações tenham efeito." -ForegroundColor Yellow
Write-Host "Para reverter, use o Ponto de Restauração criado anteriormente." -ForegroundColor Yellow
Write-Host "---------------------------------------------------" -ForegroundColor Cyan
Start-Sleep -Seconds 5
