class_name ZonaDeQueda
extends Area2D
## Região abaixo do cenário. O personagem que cai nela perde uma vida e
## volta ao último checkpoint.


func _ready() -> void:
	body_entered.connect(_ao_entrar)


func _ao_entrar(corpo: Node2D) -> void:
	if corpo is Jogador:
		corpo.cair()
