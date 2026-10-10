extends CanvasLayer
## Escurece a tela, troca de cena e clareia de novo.
##
## Este script é um autoload: fica carregado o jogo inteiro, fora das cenas,
## e pode ser chamado de qualquer lugar como Transicao.trocar_cena(...).

## Duração de cada metade da transição (escurecer e clarear), em segundos.
const DURACAO := 0.25

var _fundo: ColorRect
var _ocupada := false


func _ready() -> void:
	layer = 100  # por cima de tudo, inclusive do HUD
	process_mode = Node.PROCESS_MODE_ALWAYS  # continua rodando com o jogo pausado
	_fundo = ColorRect.new()
	_fundo.color = Color.BLACK
	_fundo.modulate.a = 0.0
	_fundo.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_fundo.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_fundo)


## Troca para a cena do caminho dado, com escurecimento.
func trocar_cena(caminho: String) -> void:
	await _transicionar(func() -> Error: return get_tree().change_scene_to_file(caminho))


## Recarrega a cena atual, com escurecimento.
func recarregar_cena() -> void:
	await _transicionar(func() -> Error: return get_tree().reload_current_scene())


func _transicionar(troca: Callable) -> void:
	if _ocupada:
		return
	_ocupada = true
	get_tree().paused = true  # nada se move enquanto a tela escurece
	_fundo.mouse_filter = Control.MOUSE_FILTER_STOP  # bloqueia cliques durante a troca

	await _levar_opacidade_a(1.0)
	var erro: Error = troca.call()
	if erro != OK:
		push_error("Transição: não foi possível trocar de cena (erro %d)." % erro)
	await get_tree().process_frame  # a cena nova entra no fim do quadro
	get_tree().paused = false
	await _levar_opacidade_a(0.0)

	_fundo.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_ocupada = false


func _levar_opacidade_a(valor: float) -> void:
	var tween := create_tween()
	tween.tween_property(_fundo, "modulate:a", valor, DURACAO)
	await tween.finished
