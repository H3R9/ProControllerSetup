<div align="center">

<img src="https://github.com/user-attachments/assets/9f0ede5b-db5b-40ae-a597-65acd9d760a0" width="100%" alt="ProControllerSetup Banner" />

#ProControllerSetup
### Otimização Extrema de Input Lag & Overclock de Controles

[![Windows](https://img.shields.io/badge/Platform-Windows%2010%2F11-blue?style=for-the-badge&logo=windows)](https://github.com/H3R9/ProControllerSetup)
[![PowerShell](https://img.shields.io/badge/Script-PowerShell-5391FE?style=for-the-badge&logo=powershell)](https://github.com/H3R9/ProControllerSetup)
[![License](https://img.shields.io/badge/License-Open%20Source-green?style=for-the-badge)](https://github.com/H3R9/ProControllerSetup)

</div>

---

## ⚡ Sobre o Projeto

O **ProControllerSetup** é um conjunto de ferramentas, scripts e guias projetados para transformar controles genéricos (Knup, Redragon, Ípega, etc.) em equipamentos de nível competitivo.

**O objetivo é simples:** Reduzir o Input Lag nativo de **~8ms para 1ms estável** e otimizar o Windows para priorizar o processamento de entrada.

### 🚀 Principais Funcionalidades
*   **Overclock de Polling Rate:** Força a atualização do USB para 1000Hz.
*   **Otimização de Sistema:** Script automatizado para Ajustes de Registro, Energia e USB.
*   **Modo MSI:** Ativação de *Message Signaled Interrupts* para GPU e Controladores.
*   **Input Mapping Avançado:** Configurações para "Anti-Deadzone" e curvas de resposta (Square Deadzone).

---

## 📦 Instalação e Uso

Recomendamos extrair o projeto na raiz do disco para evitar erros de caminho: `C:\ProControllerSetup`

### 🛠️ FASE 1: Otimização do Sistema (A Base)
Antes de mexer no hardware, preparamos o Windows para responder instantaneamente.

1.  Navegue até a pasta do projeto.
2.  Clique com o botão direito em `Otimizar_Windows_Maximo.ps1`.
3.  Selecione **"Executar com o PowerShell"**.
    > 📝 **Nota:** O script criará automaticamente um Ponto de Restauração antes de aplicar as mudanças.
4.  Consulte o arquivo `Guia_Modo_MSI.md` para configurar sua GPU em modo **High Priority**.
5.  **Reinicie o computador** para aplicar as alterações de Registro.

### ⚡ FASE 2: Overclock do Controle (A Transformação)
O passo mais importante para atingir 1ms de resposta.

1.  Siga o tutorial detalhado em `Guia_Overclock_Controle.md`.
2.  Utilize a ferramenta incluída na pasta `hidusbf`.
    > ⚠️ **Atenção:** Em alguns sistemas modernos, pode ser necessário desativar o **Secure Boot** na BIOS temporariamente caso o driver não seja assinado.

### 🎮 FASE 3: Mapper Profissional (Opcional, mas Recomendado)
Para desbloquear funções de controles profissionais (Anti-Deadzone, Curvas Personalizadas).

1.  Instale o **HidHide** e o **DS4Windows** seguindo o `Guia_Avancado_Input_Mapper.md`.
2.  Configure o HidHide para ocultar o dispositivo genérico e evitar conflitos (Input Duplo).

### 🎯 FASE 4: Ajuste Fino e Calibração
Ajuste a sensibilidade mecânica via software.

1.  Consulte `Calibracao_Deadzone.md`.
    *   **Rocket League:** Configure *Square Deadzone* para diagonais mais rápidas.
    *   **FPS (CoD/Valorant):** Configure curvas de precisão para mira.

---

## 📊 Verificação de Performance

Para confirmar se o overclock foi aplicado com sucesso:

1. Acesse [GamepadLoop Polling Rate Test](https://dev.b7.dk/gamepadloop/).
2. Mova os analógicos rapidamente em círculos.
3. O objetivo é obter uma taxa de **1000Hz** com baixa variação.

---

## ⚠️ Disclaimer

Este projeto envolve alterações no Registro do Windows e Overclock de portas USB. Embora testado exaustivamente para estabilidade:
*   Use por sua conta e risco.
*   Sempre mantenha o Ponto de Restauração criado pelo script.
*   O overclock de 1000Hz pode não ser estável em todas as portas USB (prefira portas traseiras USB 3.0).

---

<div align="center">

**Gostou do projeto? Deixe uma ⭐ no repositório!**

</div>
