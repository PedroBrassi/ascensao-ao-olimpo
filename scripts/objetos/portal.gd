class_name Portal
extends Area2D
## Saída da área. Quando o personagem entra, a área é concluída e a próxima
## cena é carregada.

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
	if proxima_cena.is_empty():
		push_warning("Portal sem próxima cena definida.")
		return
	# A troca é adiada para o fim do quadro: a cena atual não pode ser
	# removida no meio do processamento da física.
	get_tree().change_scene_to_file.call_deferred(proxima_cena)
