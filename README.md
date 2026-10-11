# Ascensão ao Olimpo

Jogo 2D de plataforma e combate feito na Godot para o trabalho de Computação Gráfica.
O jogador supera os desafios de Afrodite, Ares, Hades, Poseidon e Zeus, em cinco fases
e dez áreas, até alcançar o topo do Olimpo.

O mundo é 2D. Personagens e inimigos são modelados e animados em 3D e entram no jogo
como sprite sheets.

## Sumário

1. [Equipe e responsabilidades](#1-equipe-e-responsabilidades)
2. [O que instalar](#2-o-que-instalar)
3. [Como baixar e abrir o projeto](#3-como-baixar-e-abrir-o-projeto)
4. [Organização das pastas](#4-organização-das-pastas)
5. [Padrão de nomes](#5-padrão-de-nomes)
6. [Como trabalhar no seu branch](#6-como-trabalhar-no-seu-branch)
7. [Regras para evitar conflitos](#7-regras-para-evitar-conflitos)
8. [Se der conflito](#8-se-der-conflito)
9. [Trello](#9-trello)
10. [Lista de controle (CHECK.md)](#10-lista-de-controle-checkmd)
11. [Configurações do projeto](#11-configurações-do-projeto)

---

## 1. Equipe e responsabilidades

| Pessoa  | Branch    | Área principal                                                        | Pastas em que mais trabalha                     |
|---------|-----------|-----------------------------------------------------------------------|-------------------------------------------------|
| Pedro   | `pedro`   | Programação, integração na engine, testes de jogabilidade, build final | `scripts/`, `cenas/`, `project.godot`           |
| Aurélio | `aurelio` | Modelos, animações, cenários, design das fases, efeitos sonoros        | `assets/sprites/`, `assets/tilesets/`, `assets/fundos/`, `assets/audio/efeitos/` |
| Julia   | `julia`   | Definições de jogo, estilo visual, wireframes, textos, músicas, créditos, teste de menus | `assets/ui/`, `assets/fontes/`, `assets/audio/musicas/` |

A divisão detalhada das tarefas está no quadro do Trello, onde cada cartão tem um responsável. A ordem em que as tarefas devem ser feitas e o que cada uma depende estão no [CHECK.md](CHECK.md).

## 2. O que instalar

- **Godot 4.7.2, versão padrão (sem .NET).** Os três devem usar exatamente a mesma versão.
  Versões diferentes regravam os arquivos do projeto de formas diferentes e geram conflitos.
  Download: https://godotengine.org/download/
- **Git.** Download: https://git-scm.com/downloads

## 3. Como baixar e abrir o projeto

Só na primeira vez:

```
git clone git@github.com:PedroBrassi/ascensao-ao-olimpo.git
cd ascensao-ao-olimpo
```

Depois abra a Godot, clique em **Importar** e selecione o arquivo `project.godot`.
Na primeira abertura a Godot cria a pasta `.godot/`, que é um cache local e não vai
para o repositório.

## 4. Organização das pastas

```
ascensao-ao-olimpo/
├── README.md            este arquivo
├── CHECK.md             tarefas de cada um e ordem de implementação
├── project.godot        configuração do projeto
├── icon.svg             ícone do jogo
├── assets/              tudo o que é arte e áudio, já pronto para o jogo
│   ├── sprites/
│   │   ├── jogador/     sprite sheets do personagem principal
│   │   ├── inimigos/    sprite sheets dos inimigos comuns
│   │   ├── chefes/      campeão de Ares, guardião de Hades e Zeus
│   │   └── objetos/     portas, alavancas, checkpoints, itens dos puzzles
│   ├── tilesets/        blocos de cenário de cada fase
│   ├── fundos/          fundos e camadas de paralaxe
│   ├── ui/              ícones, HUD, botões e telas
│   ├── fontes/          arquivos de fonte
│   └── audio/
│       ├── musicas/     menu, fases, confronto final, vitória
│       └── efeitos/     movimento, combate, interface, ambiente
├── cenas/               arquivos .tscn
│   ├── jogador/
│   ├── inimigos/
│   ├── chefes/
│   ├── objetos/         plataformas, armadilhas, portas, checkpoints
│   ├── ui/              menus, HUD, pausa, vitória, derrota
│   └── fases/
│       ├── teste/       áreas de teste, com formas simples no lugar da arte
│       ├── fase_1_afrodite/
│       ├── fase_2_ares/
│       ├── fase_3_hades/
│       ├── fase_4_poseidon/
│       └── fase_5_zeus/
└── scripts/             arquivos .gd, com as mesmas subpastas de cenas/
    ├── jogador/
    ├── inimigos/
    ├── chefes/
    ├── objetos/
    ├── ui/
    ├── fases/           scripts das áreas, como os limites da câmera
    └── sistemas/        dano e vida, transição entre telas, progressão, salvamento, áudio
```

Regras de organização:

- **Cada coisa na sua pasta.** Uma cena de inimigo vai em `cenas/inimigos/` e o script
  dela em `scripts/inimigos/`, com o mesmo nome base (`esqueleto.tscn` e `esqueleto.gd`).
- **Cada fase tem a sua pasta** em `cenas/fases/`, com uma cena por área
  (`area_1.tscn` e `area_2.tscn`).
- **Em `assets/` só entram arquivos finais**, já no formato que o jogo usa: PNG para
  imagens, OGG para música, WAV para efeitos curtos.
- **Arquivos-fonte ficam fora do repositório** (arquivos do Blender, projetos de áudio,
  rascunhos). Guardem em uma pasta compartilhada do grupo. Eles são pesados e o Git não
  consegue mesclar esse tipo de arquivo.
- **Nada solto na raiz.** Se um arquivo não se encaixa em nenhuma pasta, combinem no
  grupo antes de criar uma pasta nova.
- **Mover ou renomear arquivos só por dentro da Godot** (painel Arquivos). Pelo
  explorador do sistema as referências entre cenas, scripts e recursos se quebram.

## 5. Padrão de nomes

| O quê                  | Padrão        | Exemplo                               |
|------------------------|---------------|---------------------------------------|
| Pastas e arquivos      | `snake_case`, sem acentos e sem espaços | `fase_3_hades/`, `guardiao_hades.png` |
| Nós dentro das cenas   | `PascalCase`  | `Jogador`, `AreaDeDano`               |
| Variáveis e funções    | `snake_case`  | `velocidade_maxima`, `receber_dano()` |
| Constantes             | `MAIUSCULAS`  | `VIDAS_INICIAIS`                      |
| Sinais                 | verbo no passado | `morreu`, `checkpoint_ativado`     |
| Sprite sheets          | `personagem_animacao.png` | `jogador_corrida.png`, `zeus_ataque.png` |
| Músicas                | `musica_local.ogg` | `musica_menu.ogg`, `musica_fase_2.ogg` |
| Efeitos sonoros        | `sfx_origem_acao.wav` | `sfx_jogador_salto.wav`          |

## 6. Como trabalhar no seu branch

### Os branches

- **`main`** é a versão oficial do jogo. Ela sempre precisa abrir e rodar sem erros.
  **Ninguém faz commit direto na `main`.**
- **`pedro`, `aurelio` e `julia`** são os branches de trabalho, um por pessoa. Cada um
  só faz commit no próprio branch.
- O trabalho chega à `main` por **Pull Request** no GitHub, revisado por outra pessoa
  do grupo.

### Primeira vez: criar o seu branch

Troque `pedro` pelo seu nome:

```
git switch -c pedro
git push -u origin pedro
```

### Toda vez que for começar a trabalhar

Salve e feche as cenas abertas na Godot, depois traga para o seu branch o que já entrou
na `main`:

```
git switch pedro
git fetch origin
git merge origin/main
```

Se a Godot estiver aberta, ela vai pedir para recarregar os arquivos. Aceite.

### Enquanto trabalha

Faça commits pequenos, um por mudança que faz sentido sozinha:

```
git status
git add .
git commit -m "Adiciona salto ao jogador"
git push
```

Antes de cada commit, confira no `git status` se só entraram arquivos que você
realmente mexeu.

Mensagens de commit: em português, começando com verbo no presente, dizendo o que a
mudança faz. Exemplos:

- `Adiciona sprite sheet de corrida do jogador`
- `Corrige colisão da plataforma móvel`
- `Atualiza músicas das fases 1 e 2`

### Quando terminar um cartão

1. Atualize o seu branch com a `main` mais uma vez (os três comandos de
   "Toda vez que for começar a trabalhar").
2. Abra o jogo na Godot e confirme que roda sem erros no painel de Saída.
3. Envie o branch: `git push`.
4. No GitHub, abra um **Pull Request** com base `main` e comparação no seu branch.
   No título, use o nome do cartão do Trello. Na descrição, diga o que mudou e como testar.
5. Avise o grupo. Outra pessoa baixa o branch, testa e aprova.
6. Depois de aprovado, faça o merge pelo GitHub.
7. Avise o grupo de novo, para todos atualizarem os próprios branches.

Para testar o branch de outra pessoa:

```
git fetch origin
git switch aurelio
```

Depois de testar, volte para o seu: `git switch pedro`.

### Checklist antes de abrir o Pull Request

- [ ] O projeto abre na Godot 4.7.2 sem erros.
- [ ] O que eu fiz funciona quando rodo o jogo.
- [ ] Só entraram arquivos da minha tarefa.
- [ ] Os arquivos `.import` e `.uid` novos foram junto.
- [ ] Os nomes seguem o padrão da seção 5.
- [ ] Meu branch está atualizado com a `main`.

## 7. Regras para evitar conflitos

1. **Duas pessoas nunca editam a mesma cena (`.tscn`) ao mesmo tempo.** Antes de mexer
   em uma cena que não é sua, avise no grupo e espere a resposta.
2. **O `project.godot` é do Pedro.** Quem precisar de uma mudança nas configurações
   (entradas, camadas, resolução, autoloads) pede a ele, em vez de alterar por conta própria.
3. **Arte e áudio são substituídos, nunca editados por dois.** Imagem e som são arquivos
   binários, o Git não consegue juntar duas versões. Cada arquivo tem um dono.
4. **Para trocar um arquivo de arte, mantenha o mesmo nome.** Assim as cenas que já usam
   o arquivo continuam funcionando.
5. **Os arquivos `.import` e `.uid` vão para o repositório** junto com o arquivo a que
   pertencem. Eles guardam as configurações de importação e as referências entre recursos.
6. **A pasta `.godot/` nunca vai para o repositório.** O `.gitignore` já cuida disso.
7. **Atualize o seu branch com a `main` todo dia**, mesmo sem ter terminado nada. Quanto
   mais tempo sem atualizar, maior o conflito.
8. **Pull Requests pequenos.** Um cartão por Pull Request, sempre que possível.

## 8. Se der conflito

O conflito aparece no `git merge origin/main`, quando você e outra pessoa mudaram o
mesmo trecho.

**Em um script (`.gd`):** abra o arquivo, procure as marcas `<<<<<<<`, `=======` e
`>>>>>>>`, deixe o código como deve ficar e apague as marcas. Depois:

```
git add caminho/do/arquivo.gd
git commit
```

**Em uma cena (`.tscn`), em um asset ou no `project.godot`:** não tente juntar na mão.
Escolha uma das duas versões e refaça a outra mudança dentro da Godot.

```
git checkout --theirs caminho/do/arquivo.tscn   # fica com a versão da main
git checkout --ours caminho/do/arquivo.tscn     # fica com a sua versão
git add caminho/do/arquivo.tscn
git commit
```

Para desistir do merge e voltar ao estado anterior: `git merge --abort`.

Na dúvida, pare e chame quem mexeu no mesmo arquivo. Nunca use `git push --force`.

## 9. Trello

- Cada cartão tem um responsável e uma etiqueta de cor: azul para o Pedro, verde para
  o Aurélio, roxo para a Julia.
- Tarefas de definição (regras, controles, pontuação, estilo visual, escala dos sprites)
  são registradas na descrição do próprio cartão, para todos consultarem.
- O cartão só vai para **Concluído** depois que o Pull Request dele entrar na `main`.
  Cartões de definição vão para Concluído quando o grupo aprovar o que foi escrito.

## 10. Lista de controle (CHECK.md)

O arquivo [CHECK.md](CHECK.md), na raiz do repositório, reúne as 87 tarefas do trabalho em um lugar só. Ele tem três partes:

- **Tarefas de cada um.** As 29 tarefas de cada pessoa, com uma caixa de marcação e um código: **P** para o Pedro, **A** para o Aurélio, **J** para a Julia.
- **Ordem total de implementação.** As 87 tarefas em uma sequência única, divididas em dez etapas. Cada tarefa lista de quais outras ela depende, e nenhuma aparece antes de uma dependência dela.
- **O que pode começar agora.** As tarefas pendentes que não esperam nenhuma outra, e as que mais destravam o trabalho dos colegas.

Como usar:

- **Antes de começar uma tarefa**, procure o código dela na ordem total e confira se tudo em "Depende de" está marcado. Se não estiver, a tarefa ainda não pode ser concluída.
- **Ao escolher o que fazer**, prefira as tarefas de que mais gente depende. Elas estão na tabela do fim do arquivo.
- **Ao concluir uma tarefa**, troque `[ ]` por `[x]` nas duas partes do arquivo, no mesmo Pull Request que conclui a tarefa. Assim a marcação chega à `main` junto com o trabalho. Nas tarefas de definição, marque depois que o grupo aprovar.
- **Trello e CHECK.md têm papéis diferentes.** O Trello mostra o andamento e quem é o responsável. O CHECK.md mostra a ordem e as dependências. Os dois devem dizer a mesma coisa sobre o que está concluído.

A tabela de resumo, a contagem de cada etapa e a seção "O que pode começar agora" são um retrato da data escrita no topo do arquivo. Quem marcar tarefas atualiza também esses trechos.

## 11. Configurações do projeto

Valores provisórios, que mudam conforme as definições do grupo:

- **Resolução base:** 1280×720, até a definição da escala dos sprites.
- **Renderizador:** Compatibilidade, o mais leve e adequado para jogo 2D.
- **Cena principal:** `cenas/ui/menu_principal.tscn`. O F5 abre o menu; o F6 roda a cena que estiver aberta no editor, o que serve para testar uma área direto.
- **Autoloads:** `Transicao` (`scripts/sistemas/transicao.gd`), que escurece a tela nas trocas de cena, e `Progresso` (`scripts/sistemas/progresso.gd`), que guarda as fases liberadas e as áreas concluídas e grava tudo em `user://progresso.json`. Os dois ficam cadastrados em Projeto > Configurações do Projeto > Globais.
- **Grupo `jogador`:** o personagem pertence a esse grupo. É por ele que o HUD e as telas encontram o personagem.
- **Camadas de física:** 1 mundo, 2 jogador, 3 inimigos, 4 perigos, 5 interativos.
- **Ações de entrada** (Projeto > Configurações do Projeto > Mapa de Entrada):

| Ação             | Teclado                     | Controle   |
|------------------|-----------------------------|------------|
| `mover_esquerda` | A ou seta para a esquerda   | Direcional |
| `mover_direita`  | D ou seta para a direita    | Direcional |
| `pular`          | Espaço, W ou seta para cima | A          |
| `atacar`         | J                           | X          |
| `esquivar`       | K ou Shift                  | B          |
| `interagir`      | E                           | Y          |
| `pausar`         | Esc                         | Start      |

O jogo está sendo desenvolvido do zero. O que já existe e o que falta estão no [CHECK.md](CHECK.md).
