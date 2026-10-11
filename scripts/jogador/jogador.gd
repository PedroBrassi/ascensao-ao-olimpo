class_name Jogador
extends CharacterBody2D
## Personagem principal: movimentação (andar, pular, cair e aterrissar),
## ponto de retorno e reação à perda das vidas.
##
## A origem do nó fica nos pés do personagem. Os valores abaixo aparecem no
## Inspetor e podem ser ajustados sem mexer no código.

## Emitido no quadro em que o personagem toca o chão depois de estar no ar.
signal aterrissou
## Emitido no quadro em que o personagem sai do chão por um salto.
signal pulou

@export_group("Movimento")
## Velocidade horizontal máxima, em pixels por segundo.
@export var velocidade_maxima := 320.0
## Quão rápido ganha velocidade no chão.
@export var aceleracao := 2200.0
## Quão rápido para no chão ao soltar a direção.
@export var atrito := 2600.0
## Controle horizontal enquanto está no ar (menor que no chão).
@export var aceleracao_no_ar := 1400.0

@export_group("Salto")
## Velocidade inicial do salto. Altura aproximada = velocidade² / (2 × gravidade).
@export var velocidade_do_salto := 680.0
## Gravidade enquanto sobe.
@export var gravidade := 1700.0
## Gravidade enquanto cai (maior, para a queda não parecer flutuante).
@export var gravidade_na_queda := 2400.0
## Limite da velocidade de queda.
@export var velocidade_maxima_de_queda := 1100.0
## Fração da velocidade mantida ao soltar o botão no meio da subida (salto curto).
@export_range(0.0, 1.0) var corte_do_salto := 0.45
## Tempo após sair de uma borda em que ainda dá para pular.
@export var tempo_coyote := 0.1
## Tempo em que um salto apertado antes de tocar o chão fica guardado.
@export var tempo_buffer_do_salto := 0.12

## 1 quando olha para a direita, -1 para a esquerda.
var olhando_para := 1
## Lugar onde o personagem reaparece depois de cair. Começa na posição
## inicial e muda a cada checkpoint ativado.
var ponto_de_retorno := Vector2.ZERO

var _coyote := 0.0
var _buffer_do_salto := 0.0
var _estava_no_chao := false
var _quadro_da_ultima_queda := -1

@onready var _visual: Node2D = $Visual
@onready var _vida: Vida = $Vida
@onready var _camera: Camera2D = $Camera


func _ready() -> void:
	ponto_de_retorno = global_position


func _physics_process(delta: float) -> void:
	var direcao := Input.get_axis("mover_esquerda", "mover_direita")

	_aplicar_gravidade(delta)
	_mover_na_horizontal(direcao, delta)
	_tratar_salto(delta)
	move_and_slide()
	_atualizar_estado_do_chao()
	_atualizar_direcao(direcao)


## Chamado pelo Checkpoint quando o personagem passa por ele.
func definir_ponto_de_retorno(posicao: Vector2) -> void:
	ponto_de_retorno = posicao


## Chamado pela ZonaDeQueda: perde uma vida e, se ainda restar alguma,
## volta ao ponto de retorno. A queda tira vida mesmo durante a
## invencibilidade. Se era a última vida, o personagem não reaparece e a
## tela de derrota assume.
func cair() -> void:
	# Duas zonas de queda encostadas avisariam no mesmo quadro: conta uma só.
	var quadro := Engine.get_physics_frames()
	if quadro == _quadro_da_ultima_queda:
		return
	_quadro_da_ultima_queda = quadro

	_vida.receber_dano(1, true)
	if not _vida.esta_morto():
		reaparecer()


func reaparecer() -> void:
	global_position = ponto_de_retorno
	velocity = Vector2.ZERO
	_camera.reset_smoothing()  # a câmera pula direto, sem deslizar pela área


func _aplicar_gravidade(delta: float) -> void:
	if is_on_floor():
		return
	var g := gravidade if velocity.y < 0.0 else gravidade_na_queda
	velocity.y = minf(velocity.y + g * delta, velocidade_maxima_de_queda)


func _mover_na_horizontal(direcao: float, delta: float) -> void:
	var alvo := direcao * velocidade_maxima
	var taxa := aceleracao_no_ar
	if is_on_floor():
		taxa = aceleracao if direcao != 0.0 else atrito
	velocity.x = move_toward(velocity.x, alvo, taxa * delta)


func _tratar_salto(delta: float) -> void:
	_coyote = tempo_coyote if is_on_floor() else maxf(_coyote - delta, 0.0)
	_buffer_do_salto = maxf(_buffer_do_salto - delta, 0.0)
	if Input.is_action_just_pressed("pular"):
		_buffer_do_salto = tempo_buffer_do_salto

	if _buffer_do_salto > 0.0 and _coyote > 0.0:
		velocity.y = -velocidade_do_salto
		_buffer_do_salto = 0.0
		_coyote = 0.0
		pulou.emit()
	elif Input.is_action_just_released("pular") and velocity.y < 0.0:
		velocity.y *= corte_do_salto


func _atualizar_estado_do_chao() -> void:
	var no_chao := is_on_floor()
	if no_chao and not _estava_no_chao:
		aterrissou.emit()
	_estava_no_chao = no_chao


func _atualizar_direcao(direcao: float) -> void:
	if direcao == 0.0:
		return
	olhando_para = 1 if direcao > 0.0 else -1
	_visual.scale.x = olhando_para
