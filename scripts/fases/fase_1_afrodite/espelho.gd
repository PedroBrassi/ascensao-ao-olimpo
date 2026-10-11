class_name Espelho
extends Node2D
## Espelho do puzzle de luz da fase de Afrodite.
##
## Tem duas orientações lógicas, "/" e "\", e troca de uma para a outra a
## cada interação do personagem. A orientação é um valor guardado no script,
## e não a rotação do desenho: quem for calcular o caminho da luz lê a
## variável `orientacao`.
##
## PROVISÓRIO: o desenho é uma linha diagonal dentro de um quadrado. Quando
## a arte chegar, cada orientação ganha a sua imagem.

## Emitido quando a orientação muda.
signal orientacao_mudou(orientacao: Orientacao)

enum Orientacao {
	BARRA,        ## "/": sobe da esquerda para a direita
	CONTRABARRA,  ## "\": desce da esquerda para a direita
}

## Metade do tamanho da linha provisória, em pixels.
const MEIA_FACE := 18.0

## Orientação com que o espelho começa a área.
@export var orientacao_inicial := Orientacao.BARRA

## Orientação atual. Para mudar, use alternar() ou definir_orientacao().
var orientacao := Orientacao.BARRA

@onready var _face: Line2D = $Face
@onready var _interativo: Interativo = $Interativo


func _ready() -> void:
	orientacao = orientacao_inicial
	_interativo.acionado.connect(_ao_ser_acionado)
	_atualizar_desenho()


## Troca "/" por "\" e vice-versa.
func alternar() -> void:
	if orientacao == Orientacao.BARRA:
		definir_orientacao(Orientacao.CONTRABARRA)
	else:
		definir_orientacao(Orientacao.BARRA)


func definir_orientacao(nova: Orientacao) -> void:
	if nova == orientacao:
		return
	orientacao = nova
	_atualizar_desenho()
	orientacao_mudou.emit(orientacao)


func _ao_ser_acionado(_jogador: Node2D) -> void:
	alternar()


func _atualizar_desenho() -> void:
	# No Godot o eixo y cresce para baixo: "/" vai de baixo-esquerda a cima-direita.
	if orientacao == Orientacao.BARRA:
		_face.points = PackedVector2Array([Vector2(-MEIA_FACE, MEIA_FACE), Vector2(MEIA_FACE, -MEIA_FACE)])
	else:
		_face.points = PackedVector2Array([Vector2(-MEIA_FACE, -MEIA_FACE), Vector2(MEIA_FACE, MEIA_FACE)])
