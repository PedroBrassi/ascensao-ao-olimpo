class_name MenuPrincipal
extends Control
## Tela inicial do jogo, com os botões Jogar e Sair.

## Cena carregada ao apertar Jogar.
@export_file("*.tscn") var primeira_cena := "res://cenas/fases/teste/area_teste.tscn"

@onready var _jogar: Button = $Centro/Caixa/Jogar
@onready var _sair: Button = $Centro/Caixa/Sair


func _ready() -> void:
	_jogar.pressed.connect(_ao_jogar)
	_sair.pressed.connect(_ao_sair)
	_jogar.grab_focus()  # deixa navegar com as setas e confirmar com Enter


func _ao_jogar() -> void:
	Transicao.trocar_cena(primeira_cena)


func _ao_sair() -> void:
	get_tree().quit()
