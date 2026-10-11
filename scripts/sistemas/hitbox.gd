class_name Hitbox
extends Area2D
## Região que causa dano. Enquanto estiver ativa e encostada em uma Hurtbox,
## golpeia essa Hurtbox. Quem decide se o golpe conta é o alvo: a Vida, por
## exemplo, ignora golpes durante a invencibilidade.
##
## Há dois modos:
## - contínuo (padrão): golpeia a cada quadro de física. Serve para perigos
##   que ficam parados, como espinhos; o intervalo entre os danos é a
##   invencibilidade do alvo.
## - golpe único: cada Hurtbox recebe um golpe só a cada vez que a hitbox é
##   ativada. Serve para ataques: um golpe pode acertar vários alvos, mas
##   cada alvo uma vez.

## Quanto de vida cada golpe tira.
@export var dano := 1
## Desligue para a hitbox parar de causar dano sem sair da cena. No modo de
## golpe único, ligar de novo começa um golpe novo.
@export var ativa := true:
	set(valor):
		if valor and not ativa:
			_ja_atingidas.clear()
		ativa = valor
## Ligue para cada Hurtbox receber um golpe só por ativação.
@export var golpe_unico := false

var _ja_atingidas: Array[Hurtbox] = []


func _physics_process(_delta: float) -> void:
	if not ativa:
		return
	for area in get_overlapping_areas():
		var alvo := area as Hurtbox
		if alvo == null:
			continue
		if golpe_unico:
			if alvo in _ja_atingidas:
				continue
			_ja_atingidas.append(alvo)
		alvo.receber_golpe(self)
