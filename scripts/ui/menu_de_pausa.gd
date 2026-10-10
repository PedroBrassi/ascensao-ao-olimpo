class_name MenuDePausa
extends Control
## Menu aberto pela ação "pausar" (Esc no teclado, Start no controle).
## Enquanto está aberto, o jogo fica congelado.

@onready var _continuar: Button = $Centro/Caixa/Continuar
@onready var _reiniciar: Button = $Centro/Caixa/Reiniciar


func _ready() -> void:
	hide()
	_continuar.pressed.connect(fechar)
	_reiniciar.pressed.connect(_ao_reiniciar)


func _unhandled_input(evento: InputEvent) -> void:
	if not evento.is_action_pressed("pausar"):
		return
	if visible:
		fechar()
	elif not get_tree().paused:
		# Se o jogo já está pausado sem este menu, é a tela de derrota:
		# nesse caso a tecla não faz nada.
		abrir()
	get_viewport().set_input_as_handled()


func abrir() -> void:
	show()
	get_tree().paused = true
	_continuar.grab_focus()


func fechar() -> void:
	hide()
	get_tree().paused = false


func _ao_reiniciar() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
