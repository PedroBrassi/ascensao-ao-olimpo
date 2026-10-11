class_name Vida
extends Node
## Guarda os pontos de vida de quem a possui (personagem, inimigo ou chefe)
## e aplica o dano que chega pela Hurtbox.

## Emitido sempre que a vida muda, para a interface se atualizar.
signal vida_mudou(atual: int, maxima: int)
## Emitido quando um golpe tira vida.
signal sofreu_dano(quantidade: int)
## Emitido uma única vez, quando a vida chega a zero.
signal morreu

@export var vida_maxima := 3
## Tempo, em segundos, sem poder levar outro golpe depois de um dano.
@export var tempo_de_invencibilidade := 1.0
## Hurtbox de onde vêm os golpes.
@export var hurtbox: Hurtbox
## Opcional: nó visual que pisca durante a invencibilidade.
@export var visual: CanvasItem

var vida_atual := 0
var _invencivel := 0.0


func _ready() -> void:
	vida_atual = vida_maxima
	if hurtbox != null:
		hurtbox.atingida.connect(_ao_ser_atingida)


func _physics_process(delta: float) -> void:
	if _invencivel <= 0.0:
		return
	_invencivel = maxf(_invencivel - delta, 0.0)
	if visual != null:
		# Alterna visível/invisível a cada 0,1 s e termina sempre visível.
		visual.visible = _invencivel == 0.0 or fmod(_invencivel, 0.2) < 0.1


func esta_invencivel() -> bool:
	return _invencivel > 0.0


func esta_morto() -> bool:
	return vida_atual <= 0


## Tira vida. Durante a invencibilidade o dano é ignorado, a não ser que
## `ignorar_invencibilidade` venha verdadeiro (é o caso da queda no buraco).
func receber_dano(quantidade: int, ignorar_invencibilidade := false) -> void:
	if quantidade <= 0 or esta_morto():
		return
	if esta_invencivel() and not ignorar_invencibilidade:
		return
	vida_atual = maxi(vida_atual - quantidade, 0)
	vida_mudou.emit(vida_atual, vida_maxima)
	sofreu_dano.emit(quantidade)
	if vida_atual == 0:
		morreu.emit()
	else:
		_invencivel = tempo_de_invencibilidade


## Volta à vida cheia. Usado ao reaparecer ou reiniciar a área.
func restaurar() -> void:
	vida_atual = vida_maxima
	_invencivel = 0.0
	if visual != null:
		visual.visible = true
	vida_mudou.emit(vida_atual, vida_maxima)


func _ao_ser_atingida(hitbox: Hitbox) -> void:
	receber_dano(hitbox.dano)
