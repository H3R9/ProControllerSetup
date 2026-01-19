# Guia: Modo MSI (Message Signaled Interrupts)
**Objetivo**: Diminuir a latência de comunicação entre a CPU e seus dispositivos (Placa de Vídeo e USB).

O modo MSI é mais eficiente que o antigo modo IRQ (Interrupção baseada em linha). Isso elimina gargalos onde o controle tem que "esperar na fila" para ser processado pela CPU.

## Passo 1: Ferramenta Real
Não vamos fazer isso na mão pelo registro (muito risco de erro).
1.  Busque no Google por **"MSI Utility v3"** (Geralmente hospedado em sites de tech ou fóruns como Guru3D).
2.  Baixe e **Execute como Administrador**.

## Passo 2: Configurando a GPU
1.  Procure sua Placa de Vídeo na lista (Ex: NVIDIA GeForce RTX 3060 / AMD Radeon...).
2.  Olhe a caixa **"MSI"**.
    - Se estiver desmarcada: **Marque-a**.
    - Se já estiver marcada: Deixe como está.
3.  Em "Interrupt Priority", mude de "Undefined" para **"High"**.

## Passo 3: Configurando o Controle (USB)
Este passo é delicado. Só faça se tiver certeza.
1.  Procure por linhas que dizem **"USB xHCI Compliant Host Controller"** ou similar.
    - Estes são seus controladores USB.
2.  Marque a caixa **"MSI"** neles também.
3.  **NÃO mude a prioridade para High neles**, deixe em "Undefined" ou "Normal". Mudar USB para High pode causar conflito com o áudio ou mouse. O importante é o *Modo MSI* estar ativo.

## Passo 4: Aplicar e Reiniciar
1.  Clique em **Apply** no canto superior direito.
2.  Feche o programa.
3.  **Reinicie o PC**.

## Como saber se funcionou?
Se o PC reiniciar e tudo estiver funcionando (Vídeo, Mouse, Controle), sucesso! Você eliminou milissegundos valiosos de latência de interrupção.
Se algo parou de funcionar (ex: som picotando), abra o utilitário novamente e desfaça a alteração naquele dispositivo específico.
