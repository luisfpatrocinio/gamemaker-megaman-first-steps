# Mega Man - Primeiros Passos

Um projeto GameMaker super básico para ensinar os fundamentos da engine a iniciantes absolutos.

Desenvolvido por **Luis Felipe Patrocinio** ([@luisfpatrocinio](https://github.com/luisfpatrocinio))

---

## Sobre o Projeto

Este projeto foi criado durante um minicurso de GameMaker para um público que nunca havia programado. O objetivo não é ser um jogo completo, mas sim um **material de estudo claro e direto**.

O código é intencionalmente simples, concentrando toda a lógica do jogador nos eventos `Create` e `Step` para facilitar o acompanhamento.

## Mecânicas Implementadas

*   **Movimentação:** Andar para esquerda e direita.
*   **Pulo:** Pulo simples com gravidade.
*   **Colisão:** Colisão básica com objetos sólidos (chão e paredes).
*   **Tiro:** Disparo de projéteis com um limite de 3 na tela.

## Como Rodar o Projeto

1.  Abra o **GameMaker**.
2.  Carregue o arquivo de projeto `MegaMan_FirstSteps.yyp`.
3.  Execute o jogo (pressionando `F5` ou o botão de Run).

### Controles

*   **Setas Esquerda/Direita:** Mover
*   **Barra de Espaço:** Pular
*   **Tecla Z:** Atirar

## O que você vai aprender aqui?

Este código foi feito para ilustrar os seguintes conceitos fundamentais do GameMaker:

- **Objetos:** A base de tudo no jogo (`oPlayer`, `oBullet`, `oSolid`).
- **Eventos:** O uso do `Create` (para preparar variáveis) e `Step` (para a lógica contínua).
- **Variáveis:** Como guardar e usar informações como velocidade (`hsp`, `vsp`) e direção (`facing`).
- **Input do Jogador:** Ler o teclado com `keyboard_check()` e `keyboard_check_pressed()`.
- **Colisão Simples:** Detectar obstáculos com `place_meeting()`.
- **Criação de Instâncias:** Criar novos objetos (o tiro) durante o jogo com `instance_create_layer()`.

## Estrutura do Projeto

Para entender o código, foque nestes objetos:

*   `objects/oPlayer`: Contém toda a lógica de controle, movimento, pulo e tiro do jogador.
*   `objects/oBullet`: Objeto simples que representa o projétil. Sua única tarefa é se mover para frente.
*   `objects/oSolid`: Objeto invisível usado como chão e paredes para a colisão.

## Desafios para evoluir (Próximos Passos)

Depois de entender como este projeto funciona, tente você mesmo:

1.  **Adicionar Sons:** Faça o Mega Man emitir sons ao pular e atirar.
2.  **Criar um Inimigo:** Crie um novo objeto inimigo que se move de um lado para o outro.
3.  **Implementar Dano:** Faça o projétil destruir o inimigo ao colidir com ele.
4.  **Refatorar o Código:** Tente criar **Funções** (Scripts) para organizar a lógica do `oPlayer`, como `PlayerMove()` e `PlayerShoot()`.

## Licença

Este projeto está sob a licença MIT. Sinta-se à vontade para usar, modificar e distribuir para fins educacionais. Veja o arquivo `LICENSE` para mais detalhes.