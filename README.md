# Ascensão ao Olimpo

Jogo 2D de plataforma e combate feito na Godot para o trabalho de Computação Gráfica.
O jogador supera os desafios dos deuses em cinco fases até derrotar Zeus.

## Como abrir

1. Baixe a **Godot 4.7.2 (versão padrão, sem .NET)** em https://godotengine.org/download/
   Todos do grupo devem usar a mesma versão.
2. Abra a Godot, clique em **Importar** e selecione o arquivo `project.godot` desta pasta.

## Ações de entrada já mapeadas (provisórias, ainda sem código)

| Ação      | Teclado                         | Controle        |
|-----------|---------------------------------|-----------------|
| Mover     | A / D ou setas                  | Direcional      |
| Pular     | Espaço, W ou seta para cima     | A               |
| Atacar    | J                               | X               |
| Esquivar  | K ou Shift                      | B               |
| Interagir | E                               | Y               |
| Pausar    | Esc                             | Start           |

As ações estão em Projeto > Configurações do Projeto > Mapa de Entrada.
O projeto ainda não tem cenas nem scripts: o jogo será desenvolvido do zero.

## Estrutura de pastas

```
assets/      arte e áudio prontos para o jogo
  sprites/   jogador, inimigos, chefes, objetos (sprite sheets)
  tilesets/  fundos/  ui/  fontes/
  audio/     musicas, efeitos
cenas/       arquivos .tscn
  jogador/   inimigos/  chefes/  objetos/  ui/
  fases/     uma pasta por fase (fase_1_afrodite ... fase_5_zeus)
scripts/     arquivos .gd, espelhando as pastas de cenas/
  sistemas/  vidas, checkpoints, progressão, salvamento
```

## Convenções

- Arquivos e pastas em `snake_case`, sem acentos e sem espaços.
- Nós das cenas em `PascalCase`.
- Resolução base de 1280×720 (provisória até a definição da escala dos sprites).
- Camadas de física: 1 mundo, 2 jogador, 3 inimigos, 4 perigos, 5 interativos.
- Os arquivos `.uid` e `.import` fazem parte do projeto e devem ir para o repositório.
