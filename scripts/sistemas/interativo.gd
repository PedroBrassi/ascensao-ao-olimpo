class_name Interativo
extends Node2D
## Marca um objeto como algo com que o personagem pode interagir.
##
## Fica como filho do objeto, na posição a partir da qual a distância até o
## personagem é medida. Não faz nada sozinho: avisa pelo sinal `acionado`, e
## é o objeto que decide o que acontece.
##
## Quem escolhe o objeto selecionado e chama acionar() é o personagem, pelo
## nó InteracaoDoJogador.

## Emitido a cada interação do personagem com este objeto.
signal acionado(jogador: Node2D)
## Emitido quando o objeto passa a ser, ou deixa de ser, o selecionado.
signal selecao_mudou(selecionado: bool)

## Grupo em que todo Interativo se registra. É por ele que o personagem
## encontra os objetos da cena.
const GRUPO := "interativos"

## Distância máxima, em pixels, entre este nó e o personagem.
@export var alcance := 72.0
## Desligue para o objeto deixar de aceitar interação sem sair da cena.
@export var habilitado := true
## Opcional: nó mostrado só enquanto o objeto está selecionado.
@export var destaque: CanvasItem
## Opcional: nó com a indicação do comando, mostrado só enquanto o objeto
## está selecionado.
@export var dica: CanvasItem

## Verdadeiro enquanto este é o objeto que o personagem vai acionar.
var selecionado := false


func _ready() -> void:
	add_to_group(GRUPO)
	_mostrar_selecao()


## Diz se o objeto pode ser acionado por alguém que está no ponto dado.
func esta_ao_alcance_de(ponto: Vector2) -> bool:
	return habilitado and is_visible_in_tree() and global_position.distance_to(ponto) <= alcance


## Chamado pelo personagem quando a seleção muda.
func definir_selecao(valor: bool) -> void:
	if selecionado == valor:
		return
	selecionado = valor
	_mostrar_selecao()
	selecao_mudou.emit(selecionado)


## Chamado pelo personagem quando o botão de interação é apertado.
func acionar(jogador: Node2D) -> void:
	if not habilitado:
		return
	acionado.emit(jogador)


func _mostrar_selecao() -> void:
	if destaque != null:
		destaque.visible = selecionado
	if dica != null:
		dica.visible = selecionado
