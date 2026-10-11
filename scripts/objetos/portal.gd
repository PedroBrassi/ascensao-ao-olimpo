class_name Portal
extends Area2D
## Saída da área. Quando o personagem entra, a área é registrada como
## concluída no Progresso e a próxima cena é carregada.
##
## O portal pode depender de acionadores, como o receptor de um puzzle:
## nesse caso ele só funciona enquanto todos estiverem ativos, e volta a
## ficar bloqueado se algum desligar. Sem acionadores, está sempre liberado.

## Emitido uma única vez, quando o personagem atravessa o portal.
signal atravessado
## Emitido quando o portal é liberado ou bloqueado.
signal liberacao_mudou(liberado: bool)

## Cena carregada ao atravessar. Vazio = ainda não há próxima área.
@export_file("*.tscn") var proxima_cena := ""
## Acionadores de que o portal depende (ver scripts/sistemas/acionadores.gd).
## Lista vazia = portal sempre liberado.
@export var acionadores: Array[Node] = []

## Verdadeiro enquanto o portal pode ser atravessado. Só leitura.
var liberado := true

var _usado := false

@onready var _visual: CanvasItem = $Visual
@onready var _tranca: CanvasItem = get_node_or_null("Tranca")


func _ready() -> void:
	body_entered.connect(_ao_entrar)
	Acionadores.conectar(acionadores, _ao_mudar_acionador)
	liberado = Acionadores.todos_ativos(acionadores)
	_atualizar_desenho()


func _ao_mudar_acionador(_ativo: bool) -> void:
	var novo := Acionadores.todos_ativos(acionadores)
	if novo == liberado:
		return
	liberado = novo
	_atualizar_desenho()
	liberacao_mudou.emit(liberado)
	if liberado:
		# Quem já estava parado dentro do portal atravessa na hora.
		for corpo in get_overlapping_bodies():
			_ao_entrar(corpo)


func _ao_entrar(corpo: Node2D) -> void:
	if _usado or not liberado or not corpo is Jogador:
		return
	_usado = true
	atravessado.emit()

	# A raiz da cena atual sabe a que fase e área ela corresponde.
	var cena := get_tree().current_scene
	if cena is AreaDeJogo:
		Progresso.concluir_area(cena.fase, cena.area)

	if proxima_cena.is_empty():
		push_warning("Portal sem próxima cena definida.")
		return
	Transicao.trocar_cena(proxima_cena)


func _atualizar_desenho() -> void:
	# PROVISÓRIO: bloqueado, o portal fica apagado e com barras na frente.
	_visual.modulate.a = 1.0 if liberado else 0.35
	if _tranca != null:
		_tranca.visible = not liberado
