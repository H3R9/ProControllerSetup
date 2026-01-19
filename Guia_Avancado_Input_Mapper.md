# Guia Avançado: Mapper Profissional (DS4Windows + HidHide)

Para um controle Knup se comportar como um **Controle Profissional**, não basta plugar. Precisamos de um "cérebro" melhor para interpretar os botões.

Vamos usar o **DS4Windows** (Versão Ryochan7) junto com o **HidHide**.
*Por que?* Isso permite curvas de resposta, "Anti-Deadzone" e latência de processamento de <0.5ms.

## Passo 1: Instalação dos Drivers Base
Antes de tudo, instale estes dois drivers (busque no Google/GitHub):
1.  **ViGEmBus Setup**: O "coração" que cria o controle virtual.
2.  **HidHide Setup**: O "escudo" que esconde o controle genérico para jogos não ficarem confusos com duplo comando.

## Passo 2: Configurando o HidHide (Crucial)
1.  Abra o "HidHide Configuration Client".
2.  Vá na aba **Devices**.
3.  Desconecte e reconecte seu controle Knup. Identifique qual linha aparece.
4.  **Marque a caixa vermelha "Lock"** ao lado do seu controle Knup.
5.  Em baixo, marque a caixa **"Enable Device Hiding"**.
    *   *Efeito*: Agora o Windows "não vê" mais o controle genérico. Isso evita Input Lag duplo.

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
