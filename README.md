## Mega Man - Primeiros Passos

**Resumo**

Este repositório contém um protótipo educacional intitulado "Mega Man - Primeiros Passos". Foi criado de forma improvisada durante um minicurso introdutório ao GameMaker, com foco em explicar conceitos básicos da engine para alunos iniciantes. O objetivo aqui é didático: ter código simples, claro e fácil de entender (não um jogo completo).

## Cenário de criação

O projeto nasceu em um ambiente de ensino onde a maioria dos participantes nunca havia programado antes. Para evitar frustração e garantir aprendizado, o escopo foi reduzido ao vivo, mantendo apenas mecânicas fundamentais: movimentação lateral, pulo com gravidade, colisões simples e um tiro básico.

## Público-alvo

Estudantes em seu primeiro contato com programação e com o GameMaker. Código intencionalmente procedural e concentrado nos eventos Create e Step do objeto do jogador (`oPlayer`).

## Objetivos pedagógicos

Este projeto ilustra os seguintes conceitos básicos do GameMaker:

- Objetos: tudo no jogo (jogador, solid, projétil) é um objeto.
- Sprites: associação de aparência visual (`sprite_index`) a objetos.
- Eventos: uso de `Create` (inicialização) e `Step` (lógica por frame).
- Variáveis: declarar e manter estado (velocidade, direção, timers).
- Comandos básicos: `if`, `else`, `keyboard_check()` / `keyboard_check_pressed()`.
- Colisão: detecção com `place_meeting()` e reação básica.
- Criação de instâncias: `instance_create_layer()` para criar projéteis.

## Como abrir e executar

1. Abra o GameMaker
2. Carregue o projeto `MegaMan_FirstSteps.yyp` (arquivo de projeto na raiz).
3. Execute o jogo (Run).

Controles padrão (implementados no `oPlayer`):

- Setas esquerda/direita: mover
- Barra de espaço: pular
- Tecla Z: atirar

Nota: o projeto assume que a camada de instâncias onde os projéteis são criados chama-se "Instances" (ver [`instance_create_layer(...)`](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/instance_create_layer.htm)).

## Visão geral dos arquivos importantes

- `objects/oPlayer/Create_0.gml` : inicialização das variáveis do jogador.
- `objects/oPlayer/Step_0.gml` : lógica principal: leitura de entrada, movimento, colisões, criação de tiros e troca de sprite.
- `objects/oBullet/Create_0.gml` : inicialização (variável `hsp = 0`).
- `objects/oBullet/Step_0.gml` : movimento do projétil (`x = x + hsp`).
- `objects/oBullet/Other_40.gml` : destrói a instância (provavelmente evento de colisão / ao sair de tela).
- `objects/oSolid/` : objeto sólido usado para colisões (chão e paredes). Pode não possuir GML adicional; serve como colisor.

## Análise objeto-a-objeto (extraído do código)

1. oPlayer

- Variáveis iniciais definidas no Create (nomes e propósito):

  - `movespeed = 2` : velocidade horizontal ao caminhar.
  - `hsp = 0` : velocidade horizontal atual (horizontal speed).
  - `vsp = 0` : velocidade vertical atual (vertical speed).
  - `facing = 1` : direção apontada pelo jogador (-1 = esquerda, 1 = direita).
  - `grav = 0.25` : aceleração devido à gravidade.
  - `jumpForce = 5` : impulso inicial do pulo.
  - `grounded = false` : indicador se está no chão (usado com `place_meeting`).
  - `shotTimer = 0` : timer usado para controlar animação/tempo de tiro.
  - `leftKey`, `rightKey`, `jumpKey`, `shotKey` : flags para leitura de entrada.

- Lógica do Step (comportamento):
  - Leitura de entrada: `keyboard_check(vk_left)`, `keyboard_check(vk_right)`, `keyboard_check(vk_space)` e `keyboard_check_pressed(ord("Z"))` para o tiro.
  - Checagem de chão: `grounded = place_meeting(x, y + 5, oSolid)`.
  - Movimento horizontal: define `hsp` a `-movespeed`, `movespeed` ou `0` segundo input.
  - Pulo: se `jumpKey` e `grounded` então `vsp = -jumpForce`.
  - Gravidade: `vsp += grav` e colisão vertical com `place_meeting` ajusta `vsp = 0`.
  - Colisões horizontais simples: se `place_meeting(x + hsp, y, oSolid)` então `hsp = 0`.
  - Atualização de posição: `x += hsp` e `y += vsp`.
  - Disparo: se `shotKey` e `instance_number(oBullet) < 3` cria um projétil com `instance_create_layer(x + 17 * facing, y - 8, "Instances", oBullet)` e define `_bullet.hsp = facing * 5`. Há um limite de até 2 projéteis simultâneos (condição `< 3`).
  - Atualização de `facing` com `sign(hsp)` quando `hsp != 0`.
  - Troca de sprite simples com base em estado (`sMegamanIdle`, `sMegamanWalk`, `sMegamanJump`, e variantes de tiro) e espelhamento via `image_xscale = facing`.

Observações pedagógicas sobre `oPlayer`:

- Código está todo no evento `Step` (intencional). Isso torna o fluxo fácil de seguir para iniciantes.
- Uso de `[place_meeting](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Movement_And_Collisions/Collisions/place_meeting.htm)` demonstra diretamente a ideia de colisão sem abstrações.
- O tiro é criado inline com `[instance_create_layer](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/instance_create_layer.htm)`, mostrando como instanciar objetos dinamicamente.

2. oBullet

- Create: define `hsp = 0` (velocidade horizontal do projétil).
- Step: `x = x + hsp` : movimento simples horizontal; o valor `hsp` é atribuído pelo `oPlayer` no momento de criação (por exemplo `facing * 5`).
- Outside View 0: chama `instance_destroy()`, fazendo o projétil ser removido ao sair da área de visão do jogo.

3. oSolid

- Usado como colisor para chão/paredes. O projeto trata `oSolid` como obstáculo estático. A colisão é verificada por `place_meeting(..., oSolid)`.

4. Sprites

- O projeto usa sprites nomeados como `sMegamanIdle`, `sMegamanWalk`, `sMegamanJump`, `sMegamanIdleShoot`, `sMegamanWalkShoot`, `sMegamanJumpShoot`, `sBullet` e `sSolid` para representar estados visuais. A troca de sprite é feita diretamente no `Step` do `oPlayer`.

## Filosofia do código

O código prioriza clareza e simplicidade pedagogicamente:

- Procedural e concentrado nos eventos `Create` e `Step` do `oPlayer`.
- Evita-se scripts/funções, máquinas de estado, herança de objetos ou estruturas complexas.
- Ideal para quem ainda está se habituando ao paradigma de programação e às convenções do GameMaker.

## Limitações conhecidas

- Ausência de separação de responsabilidades (toda lógica do jogador em `Step`).
- Colisão resolvida de forma simples. Edge cases como "grude nas paredes" podem ocorrer.
- Sem sistema de vida, sem inimigos, sem som, sem partículas, sem refinamento de animações.
- O limite de projéteis é feito por `instance_number(oBullet) < 3` (solução simples, mas limitada).

## Próximos passos recomendados (educacionais)

Esses caminhos servem como evolução natural para o Nível 2 do curso:

- Refatorar a lógica do jogador em scripts/funções (ex.: `playerMove()`, `playerShoot()`).
- Implementar uma máquina de estados para o jogador (idle, walk, jump, shoot) demonstrando arquitetura mais limpa.
- Adicionar inimigos simples e sistema de vida/score.
- Implementar detecção de saída da tela e reciclagem de projéteis (object pooling).
- Melhorar as animações com timings e transições mais suaves.

## Licença

Este material é educativo. Sinta-se à vontade para usar e adaptar para fins didáticos. Se desejar, adicione uma licença explícita (por exemplo MIT) ao repo.

## Contribuições

O objetivo principal é o ensino; contribuições que mantenham a simplicidade e documentação clara são bem-vindas.

## Contato

Desenvolvido por Luis Felipe Patrocinio.

- **GitHub:** https://github.com/luisfpatrocinio
