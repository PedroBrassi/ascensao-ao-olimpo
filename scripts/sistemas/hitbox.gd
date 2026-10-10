class_name Hitbox
extends Area2D
## Região que causa dano. Enquanto estiver encostada em uma Hurtbox, golpeia
## essa Hurtbox a cada quadro de física. Quem decide se o golpe conta é o
## alvo: a Vida, por exemplo, ignora golpes durante a invencibilidade.

## Quanto de vida cada golpe tira.
@export var dano := 1
## Desligue para a hitbox parar de causar dano sem sair da cena.
@export var ativa := true


func _physics_process(_delta: float) -> void:
	if not ativa:
		return
	for area in get_overlapping_areas():
		if area is Hurtbox:
			area.receber_golpe(self)
