class_name AreaDeJogo
extends Node2D
## Raiz de uma área jogável. Diz a que fase a área pertence e passa para a
## câmera os limites dela, para a câmera não mostrar o que está fora do cenário.

## Fase a que esta área pertence, de 1 a 5. Use 0 para áreas fora das fases.
@export_range(0, 5) var fase := 0
## Número da área dentro da fase, a partir de 1. A quantidade de áreas de
## cada fase está em Progresso.AREAS_POR_FASE. Use 0 para áreas fora das fases.
@export_range(0, 9) var area := 0
## Retângulo da área, em pixels: canto superior esquerdo (x, y) e tamanho (largura, altura).
@export var limites_da_camera := Rect2i(0, 0, 2560, 720)


func _ready() -> void:
	# Fase e área preenchidas pela metade, ou com um número que a fase não
	# tem, não contam para o progresso: melhor avisar do que falhar calado.
	if (fase != 0 or area != 0) and not Progresso.area_existe(fase, area):
		push_warning("AreaDeJogo: a fase %d não tem a área %d. Esta cena não vai contar para o progresso." % [fase, area])

	var camera := get_viewport().get_camera_2d()
	if camera == null:
		push_warning("Nenhuma Camera2D ativa nesta área.")
		return
	camera.limit_left = limites_da_camera.position.x
	camera.limit_top = limites_da_camera.position.y
	camera.limit_right = limites_da_camera.end.x
	camera.limit_bottom = limites_da_camera.end.y
	camera.reset_smoothing()  # começa já enquadrada, sem deslizar até o lugar
