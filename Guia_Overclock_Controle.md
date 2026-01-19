# Guia Definitivo: Overclock de Controle USB (1000Hz)
**Alvo**: Knup KP-CN700
**Objetivo**: Reduzir Input Lag de ~8ms (padrão) para **1ms (Overclock)**.

> [!WARNING]
> **Risco**: Este procedimento é seguro para a maioria dos PCs modernos, mas existe um risco mínimo de instabilidade no Windows. Siga os passos exatamente.

## Passo 1: Download da Ferramenta
Precisamos do driver "hidusbf" assinado (versão LordOfMice).
1.  Baixe o pacote **hidusbf.zip** (procure por "LordOfMice hidusbf" no GitHub ou Google).
2.  Extraia a pasta `hidusbf` para `C:\ProControllerSetup\hidusbf`.
3.  **Não** delete esta pasta depois. O driver precisa dos arquivos lá.

## Passo 2: Preparação
1.  Desconecte todos os outros controles.
2.  Conecte seu **Knup KP-CN700**.
3.  Vá para a pasta extraída `C:\ProControllerSetup\hidusbf\DRIVER`.
4.  Clique com o botão direito em `Setup.exe` e selecione **"Executar como Administrador"**.

## Passo 3: Aplicando o Overclock
Na janela do programa (USB Mouse Rate Adjuster):

1.  No menu dropdown "Mice", selecione **All**.
2.  Na lista, procure pelo seu controle. Ele deve aparecer como "USB Input Device" ou algo similar.
    - *Dica*: Se tiver dúvida, desconecte e conecte o controle para ver qual linha some e aparece.
3.  Selecione a linha do seu controle (clique nela).
4.  Marque a caixa **"Filter On Device"**.
5.  Em "Default Rate", mude para **1000**.
    - *Nota*: Não coloque 8000. Controles genéricos não aguentam e vão travar. 1000Hz é o ideal.
6.  Clique no botão **"Install Service"**.
7.  Aguarde instalar.
8.  **Desconecte o controle da porta USB e conecte novamente.** (Isso é obrigatório para aplicar).

## Passo 4: Verificação
1.  Abra o programa `Setup.exe` novamente.
2.  Olhe a coluna "bInterval". Se estiver **1**, o overclock funcionou. (1 = 1ms).
3.  Se estiver 4 ou 8, repita o processo.

## Passo 5: Teste Real
Acesse o site: [https://dev.b7.dk/gamepadloop/](https://dev.b7.dk/gamepadloop/) (Use o Edge ou Chrome).
1.  Mexa os analógicos em círculos rapidamente.
2.  Olhe a "Polling Rate". Deve estar roçando em **1000Hz** (ex: 980Hz, 1005Hz).
3.  Se estiver travado em 125Hz, o overclock não aplicou. Tente outra porta USB (preferência USB 3.0 azul).

---
**Fim do Guia de Hardware.** Siga para o Guia de Deadzone agora.
