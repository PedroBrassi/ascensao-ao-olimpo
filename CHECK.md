# CHECK — Ascensão ao Olimpo

Lista de controle do trabalho: as tarefas de cada pessoa e a ordem em que tudo deve ser feito, com o que cada tarefa depende.

Situação em 11/10/2026, tirada do quadro do Trello. Para atualizar, troque `[ ]` por `[x]` na tarefa concluída, nas duas partes do arquivo.

## Mudança de planejamento (11/10/2026)

O plano original era de cinco fases com duas áreas cada, dez no total. O jogo mantém as cinco fases, mas a quantidade de áreas passou a ser de cada fase: **Afrodite tem cinco áreas**, e Ares, Hades, Poseidon e Zeus terão a quantidade que seus desafios pedirem. Até serem definidas, o jogo considera duas áreas para cada uma dessas quatro.

Dez cartões do Trello falavam em duas ou dez áreas e foram renomeados em 11/10/2026: J5, J13, A17, A18, A19, A20, A21, A22, P25 e P28. Os nomes das tarefas abaixo já são os títulos novos.

## Como ler

- `[x]` concluída. `[ ]` pendente.
- Cada tarefa tem um código: **P** para o Pedro, **A** para o Aurélio, **J** para a Julia. O código é o mesmo nas duas partes.
- **Depende de** lista as tarefas que precisam estar prontas antes. Uma tarefa sem dependência pendente pode começar agora.
- **Parcial** indica o que já foi feito de uma tarefa ainda aberta.

## Resumo

| Pessoa | Concluídas | Parciais | Pendentes | Total |
|---|---|---|---|---|
| Pedro | 8 | 9 | 12 | 29 |
| Aurélio | 0 | 0 | 29 | 29 |
| Julia | 0 | 1 | 28 | 29 |
| **Total** | **8** | **10** | **69** | **87** |

Três tarefas aparecem duas vezes no Trello, em cartões repetidos: P15, P16 e J21. Aqui cada uma conta uma vez.

---

# Parte 1 — Tarefas de cada um

## Pedro

**Programação**

- [x] **P1** Criar e configurar o projeto na Godot
- [ ] **P2** Configurar resolução, tela e entradas do jogador *(parcial: resolução e teclas provisórias já estão no projeto; falta fechar com as definições)*
- [x] **P3** Organizar cenas, scripts, recursos e pastas
- [x] **P4** Programar movimentação, corrida, salto, queda e aterrissagem
- [ ] **P5** Programar esquiva, ataque e recebimento de dano
- [ ] **P6** Programar interação com objetos e integrar animações *(parcial: feitos o sistema de interação e o espelho de Afrodite; faltam os demais objetos e as animações)*
- [x] **P7** Criar colisões, hitboxes e hurtboxes
- [ ] **P8** Programar inimigos principais, chefes e padrões de Zeus
- [ ] **P9** Criar inimigo-base e comportamentos de patrulha, perseguição e ataque
- [x] **P10** Programar três vidas, checkpoints e reaparecimento
- [ ] **P11** Programar vitória, derrota, pontuação e contadores se aprovados *(parcial: feita a tela de derrota; faltam vitória, pontuação e contadores)*
- [x] **P12** Programar conclusão de áreas, liberação de fases e reinício
- [ ] **P13** Programar plataformas, armadilhas, portas e mecanismos *(parcial: feita a porta acionada por puzzle; faltam plataformas, armadilhas e os outros mecanismos)*
- [ ] **P14** Programar puzzles, água, raios e perigos ambientais *(parcial: feito o puzzle de luz de Afrodite, com porta e saída; faltam os puzzles e perigos das outras fases)*
- [x] **P15** Programar câmera 2D e limites das áreas
- [ ] **P16** Programar menus, HUD, pausa, configurações, transições e áudio *(parcial: feitos menu principal, HUD das vidas, pausa e transição; faltam configurações e áudio)*
- [ ] **P17** Criar salvamento, seleção de fase, exportação e versão executável *(parcial: feitos o salvamento do progresso e a tela de seleção de fase; faltam a exportação e o executável)*
- [ ] **P18** Criar sistema de vida, dano e barra de chefe *(parcial: feitos vida, dano e invencibilidade; falta a barra de chefe)*

**Parte 2 — Produção técnica**

- [ ] **P19** Sistemas — controles, combate, inimigos, puzzles, vidas, checkpoints, progressão e salvamento
- [ ] **P20** Entrega técnica — configurar exportação e gerar versão executável

**Integração e testes**

- [x] **P21** Criar repositório e configurar controle de versões
- [ ] **P22** Definir responsáveis, prioridades, prazos e status das tarefas *(parcial: responsáveis já definidos nos cartões; faltam prioridades e prazos)*
- [ ] **P23** Importar sprites, configurar animações e revisar escala
- [ ] **P24** Importar tilesets, fundos, objetos, músicas e efeitos sonoros
- [ ] **P25** Montar e integrar as áreas na engine
- [ ] **P26** Conectar interface, programação, arte e áudio
- [ ] **P27** Testar movimentação, combate, vidas, checkpoints, inimigos e puzzles
- [ ] **P28** Testar as áreas, dificuldade, desempenho e carregamento
- [ ] **P29** Corrigir erros, validar a build final e preparar o pacote de entrega

## Aurélio

**Arte**

- [ ] **A1** Modelar e rigar o personagem principal em 3D
- [ ] **A2** Modelar e rigar três inimigos comuns reutilizáveis
- [ ] **A3** Modelar o campeão de Ares, o guardião de Hades e Zeus
- [ ] **A4** Criar retratos ou aparições de Afrodite, Ares, Hades e Poseidon
- [ ] **A5** Criar tilesets e fundos das cinco fases
- [ ] **A6** Criar camadas de paralaxe, plataformas, pisos e limites visuais
- [ ] **A7** Criar portas, portais, checkpoints, alavancas e mecanismos
- [ ] **A8** Criar objetos específicos dos puzzles e desafios de cada fase
- [ ] **A9** Criar materiais e texturas dos modelos 3D e dos cenários 2D
- [ ] **A10** Animar o personagem principal
- [ ] **A11** Animar inimigos comuns, chefes e Zeus
- [ ] **A12** Renderizar animações com transparência e montar sprite sheets
- [ ] **A13** Criar efeitos visuais, ícones das três vidas, HUD, menus e telas

**Design**

- [ ] **A14** Confirmar regras, mecânica principal e controles
- [ ] **A15** Definir comportamento de inimigos e chefes
- [ ] **A16** Definir o funcionamento dos puzzles
- [ ] **A17** Planejar as cinco áreas da fase de Afrodite
- [ ] **A18** Planejar as áreas da fase de Ares (quantidade a definir)
- [ ] **A19** Planejar as áreas da fase de Hades (quantidade a definir)
- [ ] **A20** Planejar as áreas da fase de Poseidon (quantidade a definir)
- [ ] **A21** Planejar as áreas da fase de Zeus (quantidade a definir)
- [ ] **A22** Criar esboços e blockouts das áreas
- [ ] **A23** Planejar tutorial, posicionamento de perigos, inimigos e checkpoints

**Parte 2 — Produção técnica**

- [ ] **A24** Pipeline — modelar, rigar e animar em 3D; renderizar e exportar como sprite sheets
- [ ] **A25** Modelos — personagem principal, inimigos comuns, chefes e elementos necessários
- [ ] **A26** Animações — parado, corrida, salto, queda, ataque, dano, derrota e ações especiais

**Áudio**

- [ ] **A27** Produzir sons de movimento, salto, combate, dano e derrota
- [ ] **A28** Produzir sons de interação, puzzles, interface e ambientes
- [ ] **A29** Produzir sons de chefes, água, fogo e raios; normalizar volumes e mixagem

## Julia

**Parte 1 — Jogabilidade**

- [ ] **J1** O que o jogador faz? — Explora áreas 2D, enfrenta inimigos, desvia de perigos e resolve puzzles
- [ ] **J2** Qual é o objetivo? — Provar seu valor aos deuses e chegar ao topo do Olimpo
- [ ] **J3** Como vence? — Concluindo as áreas, superando os desafios e derrotando Zeus
- [ ] **J4** Mecânica principal — movimentação lateral, combate, esquiva, exploração e interação
- [ ] **J5** Como será uma fase? — Áreas em quantidade própria de cada fase, com desafios crescentes, checkpoint e encerramento próprio
- [ ] **J6** Fase 1 — Afrodite: introdução, exploração e puzzles com espelhos e símbolos
- [ ] **J7** Fase 2 — Ares: arena, combate e campeão de Ares
- [ ] **J8** Fase 3 — Hades: submundo, perigos e guardião
- [ ] **J9** Fase 4 — Poseidon: água, ruínas e mecanismos
- [ ] **J10** Fase 5 — Zeus: Olimpo, raios e confronto final

**Parte 2 — Produção técnica**

- [ ] **J11** Engine — utilizar Godot
- [ ] **J12** Formato visual — mundo 2D com personagens e inimigos produzidos em 3D
- [ ] **J13** Estrutura — cinco fases, com quantidade de áreas própria de cada fase
- [ ] **J14** Sons — música, movimento, combate, interface, ambientes, chefes e vitória
- [ ] **J15** Interface — menu principal, HUD, pausa, configurações, transições, vitória e derrota

**Arte**

- [ ] **J16** Definir o estilo visual geral e a paleta de cores
- [ ] **J17** Criar referências visuais das cinco fases
- [ ] **J18** Definir escala e resolução dos sprites

**Design**

- [ ] **J19** Definir pontuação, vitória e derrota
- [ ] **J20** Definir progressão de dificuldade e duração das fases
- [ ] **J21** Criar wireframes do HUD, menu principal, pausa, vitória e derrota
- [ ] **J22** Escrever introdução, textos das fases, falas, transições, encerramento e créditos

**Áudio**

- [ ] **J23** Selecionar ou produzir música do menu
- [ ] **J24** Selecionar ou produzir músicas das cinco fases
- [ ] **J25** Selecionar ou produzir música do confronto final e vinheta de vitória

**Integração e testes**

- [ ] **J26** Definir padrão de nomes e estrutura de pastas *(parcial: proposta escrita no README; falta a Julia revisar e confirmar)*
- [ ] **J27** Registrar fontes, licenças e créditos dos recursos externos
- [ ] **J28** Definir formato de entrega dos arquivos de arte e áudio
- [ ] **J29** Testar menus, HUD, áudio, transições, vitória e derrota

---

# Parte 2 — Ordem total de implementação

As 87 tarefas em uma única sequência. A regra da ordem é: nenhuma tarefa aparece antes de uma tarefa da qual ela depende. Dentro de uma etapa, tarefas que não dependem uma da outra podem ser feitas ao mesmo tempo, por pessoas diferentes.

Uma recomendação para as Etapas 5 a 8: fazer primeiro a fase de Afrodite de ponta a ponta (planejada, com arte, som e jogável) e só depois repetir para as outras quatro. Assim o grupo tem algo entregável cedo e descobre os problemas do processo em uma fase só.

## Etapa 0 — Fundação do projeto

Nada aqui depende de outra tarefa. Tudo o que vem depois se apoia nestas. Concluídas: 3 de 7.

1. [x] **P21** Criar repositório e configurar controle de versões — Pedro
   - Depende de: nada
2. [x] **P1** Criar e configurar o projeto na Godot — Pedro
   - Depende de: P21 ✓
3. [x] **P3** Organizar cenas, scripts, recursos e pastas — Pedro
   - Depende de: P1 ✓
4. [ ] **J11** Engine — utilizar Godot — Julia
   - Depende de: nada
   - Nota: já decidido na prática, o projeto está em Godot; falta só confirmar no cartão
5. [ ] **J26** Definir padrão de nomes e estrutura de pastas — Julia
   - Depende de: nada
   - Parcial: proposta escrita no README; falta a Julia revisar e confirmar
6. [ ] **J28** Definir formato de entrega dos arquivos de arte e áudio — Julia
   - Depende de: nada
7. [ ] **P22** Definir responsáveis, prioridades, prazos e status das tarefas — Pedro
   - Depende de: nada
   - Parcial: responsáveis já definidos nos cartões; faltam prioridades e prazos

## Etapa 1 — Definições do jogo

São decisões, não produção. Não dependem de código nem de arte e destravam quase todas as outras tarefas, então vêm primeiro. Concluídas: 0 de 25.

8. [ ] **J1** O que o jogador faz? — Explora áreas 2D, enfrenta inimigos, desvia de perigos e resolve puzzles — Julia
   - Depende de: nada
9. [ ] **J2** Qual é o objetivo? — Provar seu valor aos deuses e chegar ao topo do Olimpo — Julia
   - Depende de: nada
10. [ ] **J3** Como vence? — Concluindo as áreas, superando os desafios e derrotando Zeus — Julia
   - Depende de: nada
11. [ ] **J4** Mecânica principal — movimentação lateral, combate, esquiva, exploração e interação — Julia
   - Depende de: nada
12. [ ] **J5** Como será uma fase? — Áreas em quantidade própria de cada fase, com desafios crescentes, checkpoint e encerramento próprio — Julia
   - Depende de: nada
13. [ ] **J12** Formato visual — mundo 2D com personagens e inimigos produzidos em 3D — Julia
   - Depende de: nada
14. [ ] **J13** Estrutura — cinco fases, com quantidade de áreas própria de cada fase — Julia
   - Depende de: nada
15. [ ] **J14** Sons — música, movimento, combate, interface, ambientes, chefes e vitória — Julia
   - Depende de: nada
16. [ ] **J15** Interface — menu principal, HUD, pausa, configurações, transições, vitória e derrota — Julia
   - Depende de: nada
17. [ ] **J16** Definir o estilo visual geral e a paleta de cores — Julia
   - Depende de: nada
18. [ ] **A14** Confirmar regras, mecânica principal e controles — Aurélio
   - Depende de: J4
19. [ ] **J19** Definir pontuação, vitória e derrota — Julia
   - Depende de: J3
20. [ ] **J20** Definir progressão de dificuldade e duração das fases — Julia
   - Depende de: J5, J13
21. [ ] **J6** Fase 1 — Afrodite: introdução, exploração e puzzles com espelhos e símbolos — Julia
   - Depende de: J5
22. [ ] **J7** Fase 2 — Ares: arena, combate e campeão de Ares — Julia
   - Depende de: J5
23. [ ] **J8** Fase 3 — Hades: submundo, perigos e guardião — Julia
   - Depende de: J5
24. [ ] **J9** Fase 4 — Poseidon: água, ruínas e mecanismos — Julia
   - Depende de: J5
25. [ ] **J10** Fase 5 — Zeus: Olimpo, raios e confronto final — Julia
   - Depende de: J5
26. [ ] **J18** Definir escala e resolução dos sprites — Julia
   - Depende de: J12, J16
27. [ ] **J17** Criar referências visuais das cinco fases — Julia
   - Depende de: J16, J6, J7, J8, J9, J10
28. [ ] **J21** Criar wireframes do HUD, menu principal, pausa, vitória e derrota — Julia
   - Depende de: J15
29. [ ] **A15** Definir comportamento de inimigos e chefes — Aurélio
   - Depende de: A14, J6, J7, J8, J9, J10
30. [ ] **A16** Definir o funcionamento dos puzzles — Aurélio
   - Depende de: A14, J6, J7, J8, J9, J10
31. [ ] **A24** Pipeline — modelar, rigar e animar em 3D; renderizar e exportar como sprite sheets — Aurélio
   - Depende de: J12, J18, J28
32. [ ] **P2** Configurar resolução, tela e entradas do jogador — Pedro
   - Depende de: A14, J18
   - Parcial: resolução e teclas provisórias já estão no projeto; falta fechar com as definições

## Etapa 2 — Base jogável

Só programação, com formas simples no lugar da arte. Já está na `main`. Concluídas: 4 de 4.

33. [x] **P4** Programar movimentação, corrida, salto, queda e aterrissagem — Pedro
   - Depende de: P1 ✓
34. [x] **P7** Criar colisões, hitboxes e hurtboxes — Pedro
   - Depende de: P4 ✓
35. [x] **P15** Programar câmera 2D e limites das áreas — Pedro
   - Depende de: P4 ✓
36. [x] **P10** Programar três vidas, checkpoints e reaparecimento — Pedro
   - Depende de: P7 ✓

## Etapa 3 — Combate e inimigos

Depende das regras, dos controles e do comportamento dos inimigos, definidos na Etapa 1. Concluídas: 0 de 4.

37. [ ] **P5** Programar esquiva, ataque e recebimento de dano — Pedro
   - Depende de: A14, P7 ✓
38. [ ] **P9** Criar inimigo-base e comportamentos de patrulha, perseguição e ataque — Pedro
   - Depende de: A15, P5
39. [ ] **P8** Programar inimigos principais, chefes e padrões de Zeus — Pedro
   - Depende de: A15, P9
40. [ ] **P18** Criar sistema de vida, dano e barra de chefe — Pedro
   - Depende de: P7 ✓, P8
   - Parcial: feitos vida, dano e invencibilidade; falta a barra de chefe

## Etapa 4 — Objetos, mecanismos e puzzles

Depende do funcionamento dos puzzles. Pode andar em paralelo com a Etapa 3. Concluídas: 0 de 3.

41. [ ] **P6** Programar interação com objetos e integrar animações — Pedro
   - Depende de: A14
   - Parcial: feitos o sistema de interação e o espelho de Afrodite; faltam os demais objetos e as animações
   - Nota: a integração das animações só fecha depois de P23
42. [ ] **P13** Programar plataformas, armadilhas, portas e mecanismos — Pedro
   - Depende de: A16, P6
   - Parcial: feita a porta acionada por puzzle; faltam plataformas, armadilhas e os outros mecanismos
43. [ ] **P14** Programar puzzles, água, raios e perigos ambientais — Pedro
   - Depende de: A16, P13
   - Parcial: feito o puzzle de luz de Afrodite, com porta e saída; faltam os puzzles e perigos das outras fases

## Etapa 5 — Planejamento das áreas

Trabalho de design do Aurélio. Pode andar em paralelo com as Etapas 3 e 4. Concluídas: 0 de 7.

44. [ ] **A17** Planejar as cinco áreas da fase de Afrodite — Aurélio
   - Depende de: J6, A15, A16, J20
45. [ ] **A18** Planejar as áreas da fase de Ares (quantidade a definir) — Aurélio
   - Depende de: J7, A15, A16, J20
46. [ ] **A19** Planejar as áreas da fase de Hades (quantidade a definir) — Aurélio
   - Depende de: J8, A15, A16, J20
47. [ ] **A20** Planejar as áreas da fase de Poseidon (quantidade a definir) — Aurélio
   - Depende de: J9, A15, A16, J20
48. [ ] **A21** Planejar as áreas da fase de Zeus (quantidade a definir) — Aurélio
   - Depende de: J10, A15, A16, J20
49. [ ] **A23** Planejar tutorial, posicionamento de perigos, inimigos e checkpoints — Aurélio
   - Depende de: A17, A15
50. [ ] **A22** Criar esboços e blockouts das áreas — Aurélio
   - Depende de: A17, A18, A19, A20, A21, A23

## Etapa 6 — Produção de arte

Depende do estilo visual, da escala dos sprites e do pipeline. Pode andar em paralelo com as Etapas 3 a 5. Concluídas: 0 de 15.

51. [ ] **A25** Modelos — personagem principal, inimigos comuns, chefes e elementos necessários — Aurélio
   - Depende de: J16, A15
52. [ ] **A26** Animações — parado, corrida, salto, queda, ataque, dano, derrota e ações especiais — Aurélio
   - Depende de: A14, A15
53. [ ] **A1** Modelar e rigar o personagem principal em 3D — Aurélio
   - Depende de: A24, A25, J16, J18
54. [ ] **A2** Modelar e rigar três inimigos comuns reutilizáveis — Aurélio
   - Depende de: A24, A25, J16
55. [ ] **A3** Modelar o campeão de Ares, o guardião de Hades e Zeus — Aurélio
   - Depende de: A24, A25, J16
56. [ ] **A9** Criar materiais e texturas dos modelos 3D e dos cenários 2D — Aurélio
   - Depende de: A1, A2, A3, J16
57. [ ] **A10** Animar o personagem principal — Aurélio
   - Depende de: A1, A26
58. [ ] **A11** Animar inimigos comuns, chefes e Zeus — Aurélio
   - Depende de: A2, A3, A26
59. [ ] **A12** Renderizar animações com transparência e montar sprite sheets — Aurélio
   - Depende de: A9, A10, A11, J18, J28
60. [ ] **A4** Criar retratos ou aparições de Afrodite, Ares, Hades e Poseidon — Aurélio
   - Depende de: J16, J17
61. [ ] **A5** Criar tilesets e fundos das cinco fases — Aurélio
   - Depende de: J17, A22
62. [ ] **A6** Criar camadas de paralaxe, plataformas, pisos e limites visuais — Aurélio
   - Depende de: A5
63. [ ] **A7** Criar portas, portais, checkpoints, alavancas e mecanismos — Aurélio
   - Depende de: A16, J16
64. [ ] **A8** Criar objetos específicos dos puzzles e desafios de cada fase — Aurélio
   - Depende de: A16, A22
65. [ ] **A13** Criar efeitos visuais, ícones das três vidas, HUD, menus e telas — Aurélio
   - Depende de: J21, J16

## Etapa 7 — Textos e áudio

Depende das definições de som e de formato de entrega. Pode andar em paralelo com a Etapa 6. Concluídas: 0 de 8.

66. [ ] **J22** Escrever introdução, textos das fases, falas, transições, encerramento e créditos — Julia
   - Depende de: J3, J6, J7, J8, J9, J10
67. [ ] **J23** Selecionar ou produzir música do menu — Julia
   - Depende de: J14, J28
68. [ ] **J24** Selecionar ou produzir músicas das cinco fases — Julia
   - Depende de: J14, J28
69. [ ] **J25** Selecionar ou produzir música do confronto final e vinheta de vitória — Julia
   - Depende de: J14, J28
70. [ ] **A27** Produzir sons de movimento, salto, combate, dano e derrota — Aurélio
   - Depende de: J14, J28
71. [ ] **A28** Produzir sons de interação, puzzles, interface e ambientes — Aurélio
   - Depende de: J14, J28
72. [ ] **A29** Produzir sons de chefes, água, fogo e raios; normalizar volumes e mixagem — Aurélio
   - Depende de: A27, A28, J23, J24, J25
   - Nota: a mixagem final precisa de todas as músicas e efeitos prontos
73. [ ] **J27** Registrar fontes, licenças e créditos dos recursos externos — Julia
   - Depende de: J23, J24, J25
   - Nota: tarefa contínua: registrar cada recurso externo no momento em que ele entra no projeto

## Etapa 8 — Integração na engine

É onde programação, arte e áudio se encontram. Só começa quando os arquivos finais existem. Concluídas: 1 de 9.

74. [ ] **P23** Importar sprites, configurar animações e revisar escala — Pedro
   - Depende de: A12, J18
75. [ ] **P24** Importar tilesets, fundos, objetos, músicas e efeitos sonoros — Pedro
   - Depende de: A5, A6, A7, A8, A29
76. [x] **P12** Programar conclusão de áreas, liberação de fases e reinício — Pedro
   - Depende de: P10 ✓
77. [ ] **P17** Criar salvamento, seleção de fase, exportação e versão executável — Pedro
   - Depende de: P12 ✓
   - Parcial: feitos o salvamento do progresso e a tela de seleção de fase; faltam a exportação e o executável
   - Nota: a parte de exportação e executável é a mesma de P20
78. [ ] **P25** Montar e integrar as áreas na engine — Pedro
   - Depende de: A22, P24, P8, P14
   - Nota: existem os esqueletos das cinco áreas de Afrodite, só com chão e portal, e nenhuma área está montada
79. [ ] **P26** Conectar interface, programação, arte e áudio — Pedro
   - Depende de: P23, P24, A13, A4, J22
80. [ ] **P16** Programar menus, HUD, pausa, configurações, transições e áudio — Pedro
   - Depende de: J21, A13, P24
   - Parcial: feitos menu principal, HUD das vidas, pausa e transição; faltam configurações e áudio
81. [ ] **P11** Programar vitória, derrota, pontuação e contadores se aprovados — Pedro
   - Depende de: J19, P8, P25
   - Parcial: feita a tela de derrota; faltam vitória, pontuação e contadores
82. [ ] **P19** Sistemas — controles, combate, inimigos, puzzles, vidas, checkpoints, progressão e salvamento — Pedro
   - Depende de: P5, P9, P14, P12 ✓, P17
   - Nota: cartão-resumo: fecha quando todos os sistemas listados estiverem prontos

## Etapa 9 — Testes e entrega

Fecha o trabalho. Depende de praticamente tudo o que veio antes. Concluídas: 0 de 5.

83. [ ] **P27** Testar movimentação, combate, vidas, checkpoints, inimigos e puzzles — Pedro
   - Depende de: P5, P8, P14, P10 ✓
84. [ ] **J29** Testar menus, HUD, áudio, transições, vitória e derrota — Julia
   - Depende de: P16, P11, P26
85. [ ] **P28** Testar as áreas, dificuldade, desempenho e carregamento — Pedro
   - Depende de: P25, J20
86. [ ] **P20** Entrega técnica — configurar exportação e gerar versão executável — Pedro
   - Depende de: P17
87. [ ] **P29** Corrigir erros, validar a build final e preparar o pacote de entrega — Pedro
   - Depende de: P27, P28, J29, P20, J27

---

# O que pode começar agora

Tarefas pendentes cujas dependências já estão todas concluídas, na ordem da Parte 2.

**Pedro:** P22, P17.

**Aurélio:** nenhuma; todas as pendentes esperam outra tarefa.

**Julia:** J11, J26, J28, J1, J2, J3, J4, J5, J12, J13, J14, J15, J16.

## Tarefas que mais destravam as outras

Quantas tarefas pendentes dependem de cada uma, direta ou indiretamente. Vale começar por estas.

| Tarefa | Responsável | Tarefas que esperam por ela |
|---|---|---|
| **J5** Como será uma fase? — Áreas em quantidade própria de cada fase, com desafios crescentes, checkpoint e encerramento próprio | Julia | 47 |
| **J4** Mecânica principal — movimentação lateral, combate, esquiva, exploração e interação | Julia | 42 |
| **A14** Confirmar regras, mecânica principal e controles | Aurélio | 41 |
| **J6** Fase 1 — Afrodite: introdução, exploração e puzzles com espelhos e símbolos | Julia | 41 |
| **J7** Fase 2 — Ares: arena, combate e campeão de Ares | Julia | 41 |
| **J8** Fase 3 — Hades: submundo, perigos e guardião | Julia | 41 |
| **J9** Fase 4 — Poseidon: água, ruínas e mecanismos | Julia | 41 |
| **J10** Fase 5 — Zeus: Olimpo, raios e confronto final | Julia | 41 |
