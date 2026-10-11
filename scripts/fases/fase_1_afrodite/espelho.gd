@tool
class_name Espelho
extends Node2D
## Espelho do puzzle de luz da fase de Afrodite.
##
## Tem duas orientações lógicas, "/" e "\", e troca de uma para a outra a
## cada interação do personagem. A orientação é um valor guardado no script,
## e não a rotação do desenho: a FonteDeLuz pergunta ao espelho para onde a
## luz vai, pela função refletir().
##
## O script roda também dentro do editor (@tool), só para o desenho mostrar
## a orientação inicial escolhida no Inspetor.
##
## PROVISÓRIO: o desenho é uma linha diagonal dentro de um quadrado. Quando
## a arte chegar, cada orientação ganha a sua imagem.

## Emitido quando a orientação muda.
signal orientacao_mudou(orientacao: Orientacao)

enum Orientacao {
	BARRA,        ## "/": sobe da esquerda para a direita
	CONTRABARRA,  ## "\": desce da esquerda para a direita
}

## Grupo em que todo espelho se registra. É por ele que a luz encontra os
## espelhos da cena.
const GRUPO := "espelhos_de_luz"
## Metade do tamanho da linha provisória, em pixels.
const MEIA_FACE := 18.0

## Orientação com que o espelho começa a área.
@export var orientacao_inicial := Orientacao.BARRA:
	set(valor):
		orientacao_inicial = valor
		if Engine.is_editor_hint() and is_node_ready():
			orientacao = valor
			_atualizar_desenho()

## Orientação atual. Para mudar, use alternar() ou definir_orientacao().
var orientacao := Orientacao.BARRA

@onready var _face: Line2D = $Face


func _ready() -> void:
	orientacao = orientacao_inicial
	_atualizar_desenho()
	if Engine.is_editor_hint():
		return  # no editor só o desenho interessa
	add_to_group(GRUPO)
	var interativo: Interativo = $Interativo
	interativo.acionado.connect(_ao_ser_acionado)


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


## Recebe a direção em que a luz chega e devolve a direção em que ela sai.
## As direções são vetores de um passo: direita (1, 0), esquerda (-1, 0),
## cima (0, -1) e baixo (0, 1). O espelho reflete dos dois lados.
func refletir(direcao: Vector2) -> Vector2:
	# No Godot o eixo y cresce para baixo.
	if orientacao == Orientacao.BARRA:
		return Vector2(-direcao.y, -direcao.x)  # "/": direita vira cima, cima vira direita
	return Vector2(direcao.y, direcao.x)        # "\": direita vira baixo, cima vira esquerda


func _ao_ser_acionado(_jogador: Node2D) -> void:
	alternar()


func _atualizar_desenho() -> void:
	# "/" vai de baixo-esquerda a cima-direita; "\" faz o contrário.
	if orientacao == Orientacao.BARRA:
		_face.points = PackedVector2Array([Vector2(-MEIA_FACE, MEIA_FACE), Vector2(MEIA_FACE, -MEIA_FACE)])
	else:
		_face.points = PackedVector2Array([Vector2(-MEIA_FACE, -MEIA_FACE), Vector2(MEIA_FACE, MEIA_FACE)])
