class_name EsquivaDoJogador
extends Node
## Parte do personagem que cuida da esquiva: um deslocamento rápido e curto,
## para o lado em que ele está olhando quando a esquiva começa.
##
## Este nó decide quando a esquiva pode começar e quando termina. Quem move
## o personagem durante ela é o próprio Jogador, que consulta este nó.
##
## Durante a esquiva o personagem:
## - anda na horizontal, sem gravidade, e para em paredes;
## - não leva dano de golpes nem de perigos, como os espinhos;
## - continua perdendo vida se entrar em uma zona de queda;
## - não ataca nem interage.
##
## No ar a esquiva pode ser usada uma vez, até o personagem tocar o chão de
## novo. Vale também para quem caiu de uma borda sem pular.
##
## PROVISÓRIO: durante a esquiva o personagem fica meio transparente. A
## animação e o som entram depois, pelos sinais.

## Emitido quando a esquiva começa. Vem com o lado: 1 direita, -1 esquerda.
signal comecou(lado: int)
## Emitido quando a esquiva termina, por qualquer motivo.
signal terminou

## Folga para comparar tempos somados quadro a quadro.
const FOLGA := 0.001

## Distância percorrida quando nada atrapalha, em pixels.
@export var distancia := 160.0
## Tempo que a esquiva dura, em segundos.
@export var duracao := 0.2
## Tempo mínimo entre o começo de uma esquiva e o começo da seguinte.
@export var intervalo := 0.6
## Desligue para o personagem deixar de esquivar por um tempo.
@export var habilitada := true

## Verdadeiro do começo ao fim da esquiva.
var esquivando := false
## Lado da esquiva atual ou da última: 1 direita, -1 esquerda.
var lado := 1

var _tempo_restante := 0.0
var _espera := 0.0
var _disponivel_no_ar := true
var _tirar_imunidade_no_proximo_quadro := false
# O que estava ligado antes da esquiva, para devolver igual no fim.
var _ataque_estava_habilitado := true
var _interacao_estava_habilitada := true

@onready var _jogador: Jogador = get_parent()
@onready var _vida: Vida = $"../Vida"
@onready var _visual: CanvasItem = $"../Visual"
@onready var _ataque: AtaqueDoJogador = get_node_or_null("../Ataque")
@onready var _interacao: InteracaoDoJogador = get_node_or_null("../Interacao")


func _ready() -> void:
	_vida.morreu.connect(cancelar)


func _physics_process(delta: float) -> void:
	_espera = maxf(_espera - delta, 0.0)
	if _tirar_imunidade_no_proximo_quadro:
		_tirar_imunidade_no_proximo_quadro = false
		_vida.imune = false
	if _jogador.is_on_floor():
		_disponivel_no_ar = true  # tocou o chão: a esquiva no ar volta a valer

	if esquivando:
		_tempo_restante -= delta
		if _tempo_restante <= FOLGA:
			encerrar()
	# just_pressed só vale no quadro em que o botão desce: segurar não repete.
	elif Input.is_action_just_pressed("esquivar") and pode_esquivar():
		_comecar()


## Velocidade horizontal durante a esquiva, em pixels por segundo.
func velocidade() -> float:
	return distancia / maxf(duracao, 0.01)


## Diz se uma esquiva pode começar agora.
func pode_esquivar() -> bool:
	if not habilitada or esquivando or _espera > FOLGA or _vida.esta_morto():
		return false
	if _ataque != null and _ataque.atacando:
		return false  # a esquiva não interrompe um golpe em andamento
	return _jogador.is_on_floor() or _disponivel_no_ar


## Termina a esquiva normalmente. O personagem segue na velocidade de
## caminhada se o jogador estiver segurando o mesmo lado; senão, para.
func encerrar() -> void:
	if not esquivando:
		return
	var direcao := Input.get_axis("mover_esquerda", "mover_direita")
	var segue_andando := direcao != 0.0 and signf(direcao) == float(lado)
	var velocidade_final := _jogador.velocidade_maxima * lado if segue_andando else 0.0
	_finalizar(Vector2(velocidade_final, 0.0))
	# A imunidade dura um quadro a mais. No quadro em que a esquiva acaba, a
	# física ainda acha que o personagem está onde estava no quadro anterior,
	# e um perigo que ele acabou de atravessar ainda o acertaria.
	_vida.imune = true
	_tirar_imunidade_no_proximo_quadro = true


## Interrompe a esquiva e zera a velocidade. Usado no reaparecimento e na
## morte. Não faz nada se não houver esquiva em andamento.
func cancelar() -> void:
	if not esquivando:
		return
	_finalizar(Vector2.ZERO)


func _comecar() -> void:
	lado = _jogador.olhando_para
	esquivando = true
	_tempo_restante = duracao
	_espera = intervalo
	if not _jogador.is_on_floor():
		_disponivel_no_ar = false

	_vida.imune = true
	_tirar_imunidade_no_proximo_quadro = false
	if _ataque != null:
		_ataque_estava_habilitado = _ataque.habilitado
		_ataque.habilitado = false
	if _interacao != null:
		_interacao_estava_habilitada = _interacao.habilitada
		_interacao.habilitada = false
	_visual.modulate.a = 0.5
	comecou.emit(lado)


func _finalizar(velocidade_final: Vector2) -> void:
	esquivando = false
	_jogador.velocity = velocidade_final
	_vida.imune = false
	_tirar_imunidade_no_proximo_quadro = false
	if _ataque != null:
		_ataque.habilitado = _ataque_estava_habilitado
	if _interacao != null:
		_interacao.habilitada = _interacao_estava_habilitada
	_visual.modulate.a = 1.0
	terminou.emit()
