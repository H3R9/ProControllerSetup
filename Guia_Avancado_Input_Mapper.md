# Guia Avançado: Mapper Profissional (DS4Windows + HidHide)

Para um controle Knup se comportar como um **Controle Profissional**, não basta plugar. Precisamos de um "cérebro" melhor para interpretar os botões.

Vamos usar o **DS4Windows** (Versão Ryochan7) junto com o **HidHide**.
*Por que?* Isso permite curvas de resposta, "Anti-Deadzone" e latência de processamento de <0.5ms.

## Passo 1: Instalação dos Drivers Base
Antes de tudo, instale estes dois drivers (busque no Google/GitHub):
1.  **ViGEmBus Setup**: O "coração" que cria o controle virtual.
2.  **HidHide Setup**: O "escudo" que esconde o controle genérico para jogos não ficarem confusos com duplo comando.

## Passo 2: Configurando o HidHide (Crucial)
O HidHide funciona como um segurança. Ele impede que jogos vejam o controle Genérico, mas precisamos deixar o DS4Windows ver.

1.  Abra o "HidHide Configuration Client".
2.  **Aba Applications (Lista Branca)**:
    - Clique no botão "+" (Plus).
    - Navegue até a pasta onde instalou o DS4Windows.
    - Selecione o `DS4Windows.exe`.
    - *Isso garante que o DS4Windows continue vendo o controle mesmo quando escondido.*
3.  **Aba Devices (Dispositivos)**:
    - Desconecte e reconecte seu controle Knup. Identifique qual linha aparece.
    - **Marque a caixa vermelha "Lock"** ao lado do seu controle Knup.
    - Em baixo, marque a caixa **"Enable Device Hiding"**.
    - *Efeito*: O Windows e Jogos não veem mais o Knup. Apenas o DS4Windows vê (graças ao passo anterior).

## Passo 3: DS4Windows (O Cérebro)
1.  Baixe o **DS4Windows (Ryochan7)**.
2.  Extraia e abra. Se pedir para instalar .NET, instale.
3.  Vá na aba **Settings** -> **Device Options**.
4.  Ative a opção **"DS4 Controller Support"** e, se seu controle for detectado como genérico, ative **"Generic/JoyCon" support** (pode variar dependendo de como o Knup se identifica, as vezes ele se passa por PS3).
5.  Quando o controle aparecer na aba "Controllers":
    - Crie um **New Profile**.
    - Em **"Deadzone"**: Deixe EXATAMENTE como no nosso guia de Deadzone (0.05 ou menos).
    - **Output Mode**: Selecione **"Xbox 360"** (Para compatibilidade máxima) ou **"DualShock 4"** (Para Overclock de polling nativo se o jogo suportar).

## Passo 4: O Segredo "Anti-Deadzone"
Controles baratos têm folga física (você mexe o analógico e ele não responde na hora).
1.  No Profile Editor, vá em **Axis Config** (LS e RS).
2.  Procure por **"Anti-Deadzone"**.
3.  Aumente devagar (comece com 0.10 ou 10%).
    *   *O que isso faz*: Quando você toca no analógico, o software já "pula" a folga física e envia sinal.
    *   *Teste*: Se o boneco andar sozinho, diminua. Se ainda demorar pra responder, aumente.
    *   Isso deixa a resposta **instantânea**.

**Nota**: Sempre abra o DS4Windows como **Administrador** para ele ter prioridade de CPU Realtime.
