# Guia de Calibração Perfect Deadzone
**Foco**: Precisão Mecânica e Software

Os controles genéricos vêm com "Deadzone de fábrica" alta para esconder defeitos no analógico. Vamos remover isso via software.

## Parte 1: Diagnóstico (Gamepad Tester)
1.  Acesse [https://hardwaretester.com/gamepad](https://hardwaretester.com/gamepad)
2.  Mova os analógicos levemente.
3.  Veja o quanto você precisa mover para o Windows detectar (o valor mudar de 0.0000).
4.  **Anote esse valor**. Exemplo: `0.08` (Isso é 8% de zona morta física).

## Parte 2: Configuração "Square" (Rocket League)
Para Rocket League, queremos que o analógico atinja 100% da força nos cantos (diagonais) mais rápido.

**Método Steam Input (Recomendado para RL)**:
1.  Abra a Steam -> Configurações -> Controle.
2.  Ative "Entrada Steam para controles genéricos/Xbox".
3.  Vá na Biblioteca -> Clique direito no Rocket League -> Propriedades -> Controle.
4.  Clique no link "Configurador do Controle".
5.  Selecione "Editar Layout".
6.  Vá em **Joysticks**.
7.  Clique na engrenagem ao lado de "Joystick Esquerdo" (Movimento).
8.  **Deadzone Type**: Mude para "Personalizado".
    - Ajuste o Slider "Min" (Interno) para ser *ligeiramente maior* que o valor que você anotou no Passo 1 (ex: se era 0.08, coloque 0.10).
    - Ajuste o Slider "Max" (Externo) para **0.90** ou **0.95**. Isso garante que você chegue em 100% de velocidade antes de bater o analógico no plástico.
9.  **Deadzone Shape**: Mude para **Square** (Quadrado).
    - *Isso é o segredo dos Pros de RL.* Permite virar o carro mais rápido nas diagonais aéreas.

## Parte 3: Configuração para FPS (Call of Duty / XDefiant)
Para tiro, queremos precisão no centro, não velocidade.

**Método DS4Windows (Se usar driver emulado)**:
> [!TIP]
> **Atenção**: Para este método funcionar perfeitamente e liberar opções como "Anti-Deadzone", leia primeiro o arquivo `Guia_Avancado_Input_Mapper.md` que criamos.
>
1.  Abra o DS4Windows -> Edit Profile -> Axis Config.
2.  **LS (Left Stick)**: Mantenha Deadzone baixo (0.05 a 0.10).
3.  **RS (Right Stick - Mira)**:
    - **Deadzone**: O menor possível sem a mira mexer sozinha (Drift). Comece em 0.03. Se a mira andar sozinha no jogo, suba para 0.04, etc.
    - **Curve**: Mude para "Enhanced Precision" ou ajuste a curva manualmente para ser mais lenta no centro (para micro-ajustes de mira).

## Dica de Ouro
Sempre desative a "Vibração" nos jogos competitivos. O motor de vibração pode causar micro-movimentos no analógico e atrapalhar o "Aim" preciso.
