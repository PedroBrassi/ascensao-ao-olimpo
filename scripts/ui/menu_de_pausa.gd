class_name MenuDePausa
extends Control
## Menu aberto pela ação "pausar" (Esc no teclado, Start no controle).
## Enquanto está aberto, o jogo fica congelado.

## Cena aberta pelo botão Voltar ao menu.
@export_file("*.tscn") var cena_do_menu := "res://cenas/ui/menu_principal.tscn"

# Fica verdadeiro depois que uma saída foi escolhida (reiniciar ou voltar ao
# menu). Daí em diante o menu não responde mais, até a cena ser trocada.
var _saindo := false

@onready var _continuar: Button = $Centro/Caixa/Continuar
@onready var _reiniciar: Button = $Centro/Caixa/Reiniciar
@onready var _voltar_ao_menu: Button = $Centro/Caixa/VoltarAoMenu


func _ready() -> void:
	hide()
	_continuar.pressed.connect(fechar)
	_reiniciar.pressed.connect(_ao_reiniciar)
	_voltar_ao_menu.pressed.connect(_ao_voltar_ao_menu)


func _unhandled_input(evento: InputEvent) -> void:
	if not evento.is_action_pressed("pausar"):
		return
	if _saindo:
		pass  # a tela já está escurecendo: a tecla não faz nada
	elif visible:
		fechar()
	elif not get_tree().paused:
		# Se o jogo já está pausado sem este menu, é a tela de derrota ou
		# uma transição: nesse caso a tecla não faz nada.
		abrir()
	get_viewport().set_input_as_handled()


func abrir() -> void:
	show()
	get_tree().paused = true
	_continuar.grab_focus()


func fechar() -> void:
	if _saindo:
		return
	hide()
	get_tree().paused = false


func _ao_reiniciar() -> void:
	if _saindo:
		return
	_saindo = true
	Transicao.recarregar_cena()  # a Transicao tira a pausa depois da troca


func _ao_voltar_ao_menu() -> void:
	if _saindo:
		return
	_saindo = true
	Transicao.trocar_cena(cena_do_menu)
