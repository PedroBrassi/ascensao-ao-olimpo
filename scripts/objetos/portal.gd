class_name Portal
extends Area2D
## Saída da área. Quando o personagem entra, a área é registrada como
## concluída no Progresso e a próxima cena é carregada.

## Emitido uma única vez, quando o personagem atravessa o portal.
signal atravessado

## Cena carregada ao atravessar. Vazio = ainda não há próxima área.
@export_file("*.tscn") var proxima_cena := ""

var _usado := false


func _ready() -> void:
	body_entered.connect(_ao_entrar)


func _ao_entrar(corpo: Node2D) -> void:
	if _usado or not corpo is Jogador:
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
