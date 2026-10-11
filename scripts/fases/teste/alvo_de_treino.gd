class_name AlvoDeTreino
extends Node2D
## SÓ PARA TESTE. Alvo parado, para conferir o ataque do personagem. Não é
## o inimigo-base: não se move, não ataca e não bloqueia a passagem.
##
## Tem Hurtbox e Vida, como um inimigo teria. O número em cima mostra a
## vida que resta. Ao ser atingido, o alvo dá um clarão; ao perder toda a
## vida, some, e volta inteiro depois de um tempo.

## Tempo, em segundos, até o alvo voltar depois de derrotado. 0 = não volta.
@export var tempo_para_voltar := 2.0

@onready var _vida: Vida = $Vida
@onready var _hurtbox: Hurtbox = $Hurtbox
@onready var _visual: CanvasItem = $Visual
@onready var _contador: Label = $Contador


func _ready() -> void:
	_vida.sofreu_dano.connect(_ao_sofrer_dano)
	_vida.morreu.connect(_ao_ser_derrotado)
	_mostrar_vida()


func _ao_sofrer_dano(_quantidade: int) -> void:
	_mostrar_vida()
	# Clarão rápido: fica branco e volta à cor normal.
	_visual.modulate = Color(3, 3, 3)
	create_tween().tween_property(_visual, "modulate", Color.WHITE, 0.15)


func _ao_ser_derrotado() -> void:
	hide()
	_hurtbox.set_deferred("monitorable", false)  # sumido, não pode ser atingido
	if tempo_para_voltar <= 0.0:
		return
	await get_tree().create_timer(tempo_para_voltar, false).timeout
	if not is_inside_tree():
		return
	_vida.restaurar()
	_hurtbox.set_deferred("monitorable", true)
	_mostrar_vida()
	show()


func _mostrar_vida() -> void:
	_contador.text = str(_vida.vida_atual)
