class_name Checkpoint
extends Area2D
## Ponto de retorno. Quando o personagem passa por ele, este vira o lugar
## onde o personagem reaparece depois de cair.

## Emitido uma única vez, quando o checkpoint é ativado.
signal ativado

@export var cor_inativo := Color(0.5, 0.5, 0.55)
@export var cor_ativo := Color(0.4, 0.85, 0.5)

var ativo := false

@onready var _visual: ColorRect = $Visual


func _ready() -> void:
	_visual.color = cor_inativo
	body_entered.connect(_ao_entrar)


func _ao_entrar(corpo: Node2D) -> void:
	if ativo or not corpo is Jogador:
		return
	ativo = true
	_visual.color = cor_ativo
	corpo.definir_ponto_de_retorno(global_position)
	ativado.emit()
