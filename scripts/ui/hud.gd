class_name Hud
extends CanvasLayer
## Interface durante o jogo. Por enquanto mostra só as vidas do personagem,
## com um quadrado por vida.

@export var cor_vida_cheia := Color(0.9, 0.3, 0.35)
@export var cor_vida_vazia := Color(0.25, 0.26, 0.33)
@export var tamanho_do_icone := Vector2(28, 28)

@onready var _vidas: HBoxContainer = $Vidas


func _ready() -> void:
	# O personagem está no grupo "jogador"; é assim que o HUD o encontra
	# sem precisar saber em que lugar da cena ele está.
	var jogador := get_tree().get_first_node_in_group("jogador")
	if jogador == null:
		push_warning("HUD: nenhum nó no grupo \"jogador\".")
		return
	var vida := jogador.get_node("Vida") as Vida
	vida.vida_mudou.connect(_mostrar_vidas)
	# Se a Vida ainda não rodou o _ready, o valor atual é a vida cheia.
	var atual := vida.vida_atual if vida.is_node_ready() else vida.vida_maxima
	_mostrar_vidas(atual, vida.vida_maxima)


func _mostrar_vidas(atual: int, maxima: int) -> void:
	# Cria os ícones que faltarem, um por ponto de vida máxima.
	while _vidas.get_child_count() < maxima:
		var icone := ColorRect.new()
		icone.custom_minimum_size = tamanho_do_icone
		icone.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_vidas.add_child(icone)

	for i in _vidas.get_child_count():
		var icone := _vidas.get_child(i) as ColorRect
		icone.visible = i < maxima
		icone.color = cor_vida_cheia if i < atual else cor_vida_vazia
