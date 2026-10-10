class_name AreaDeJogo
extends Node2D
## Raiz de uma área jogável. Passa para a câmera os limites desta área, para
## ela não mostrar o que está fora do cenário.

## Retângulo da área, em pixels: canto superior esquerdo (x, y) e tamanho (largura, altura).
@export var limites_da_camera := Rect2i(0, 0, 2560, 720)


func _ready() -> void:
	var camera := get_viewport().get_camera_2d()
	if camera == null:
		push_warning("Nenhuma Camera2D ativa nesta área.")
		return
	camera.limit_left = limites_da_camera.position.x
	camera.limit_top = limites_da_camera.position.y
	camera.limit_right = limites_da_camera.end.x
	camera.limit_bottom = limites_da_camera.end.y
	camera.reset_smoothing()  # começa já enquadrada, sem deslizar até o lugar
