class_name TelaDeDerrota
extends Control
## Tela mostrada quando o personagem perde as três vidas. Pausa o jogo e
## oferece tentar a área de novo.

@onready var _botao: Button = $Centro/Caixa/TentarDeNovo


func _ready() -> void:
	hide()
	_botao.pressed.connect(_ao_tentar_de_novo)
	var jogador := get_tree().get_first_node_in_group("jogador")
	if jogador == null:
		push_warning("Tela de derrota: nenhum nó no grupo \"jogador\".")
		return
	(jogador.get_node("Vida") as Vida).morreu.connect(_mostrar)


func _mostrar() -> void:
	show()
	get_tree().paused = true
	_botao.grab_focus()  # deixa confirmar com Enter, Espaço ou o controle


func _ao_tentar_de_novo() -> void:
	Transicao.recarregar_cena()  # escurece, recarrega a área e tira a pausa
