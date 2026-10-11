class_name SelecaoDeFase
extends Control
## Tela de seleção de fase. Tem um botão por fase, e só dá para entrar nas
## fases já liberadas (quem sabe disso é o autoload Progresso).
##
## Os nomes das fases são o texto dos botões Fase1 a Fase5 na cena. Este
## script só acrescenta o aviso de bloqueada ou em construção.

## Primeira cena de cada fase, na ordem das fases. Deixe vazio enquanto a
## fase não existir: o botão dela fica apagado, com o aviso "em construção".
@export_file("*.tscn") var cenas_das_fases: Array[String] = [
	"res://cenas/fases/teste/area_teste.tscn",  # provisório: as áreas de teste fazem o papel da fase 1
	"",
	"",
	"",
	"",
]
## Cena aberta pelo botão Voltar.
@export_file("*.tscn") var cena_do_menu := "res://cenas/ui/menu_principal.tscn"

@onready var _voltar: Button = $Centro/Caixa/Voltar


func _ready() -> void:
	var primeiro_disponivel: Button = null
	for fase in range(1, Progresso.TOTAL_DE_FASES + 1):
		var botao: Button = get_node("Centro/Caixa/Fase%d" % fase)
		var cena := _cena_da_fase(fase)
		if not Progresso.fase_esta_liberada(fase):
			_apagar(botao, "bloqueada")
		elif cena.is_empty():
			_apagar(botao, "em construção")
		else:
			botao.pressed.connect(_ao_escolher.bind(cena))
			if primeiro_disponivel == null:
				primeiro_disponivel = botao

	_voltar.pressed.connect(_ao_voltar)
	# Deixa navegar com as setas e confirmar com Enter.
	if primeiro_disponivel != null:
		primeiro_disponivel.grab_focus()
	else:
		_voltar.grab_focus()


func _cena_da_fase(fase: int) -> String:
	if fase > cenas_das_fases.size():
		return ""
	return cenas_das_fases[fase - 1]


func _apagar(botao: Button, aviso: String) -> void:
	botao.text += " (%s)" % aviso
	botao.disabled = true
	botao.focus_mode = Control.FOCUS_NONE  # as setas pulam os botões apagados


func _ao_escolher(cena: String) -> void:
	Transicao.trocar_cena(cena)


func _ao_voltar() -> void:
	Transicao.trocar_cena(cena_do_menu)
