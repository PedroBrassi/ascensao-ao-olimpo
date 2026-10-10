class_name Hurtbox
extends Area2D
## Região do corpo que pode ser atingida. Não faz nada sozinha: só avisa,
## pelo sinal, que uma Hitbox encostou nela.

## Emitido a cada golpe recebido. Quem escuta decide se o golpe conta.
signal atingida(hitbox: Hitbox)


## Chamado pela Hitbox que está encostada nesta Hurtbox.
func receber_golpe(hitbox: Hitbox) -> void:
	atingida.emit(hitbox)
