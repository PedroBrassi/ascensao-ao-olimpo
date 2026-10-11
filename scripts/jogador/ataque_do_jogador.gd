class_name AtaqueDoJogador
extends Node2D
## Parte do personagem que cuida do ataque: um golpe corpo a corpo, curto,
## para o lado em que ele está olhando.
##
## O golpe usa uma Hitbox no modo de golpe único: enquanto dura, acerta cada
## inimigo ao alcance uma vez. O lado do golpe é decidido quando ele começa
## e não muda se o personagem virar no meio.
##
## Com o jogo pausado (pausa, derrota ou escurecimento da tela) este nó não
## roda, então não há ataque nesses momentos.
##
## PROVISÓRIO: o golpe aparece como um retângulo claro na frente do
## personagem. A animação e o som entram depois, pelos sinais.

## Emitido quando um golpe começa. Vem com o lado: 1 direita, -1 esquerda.
signal atacou(lado: int)
## Emitido quando o golpe termina.
signal terminou

## Quanto de vida cada golpe tira.
@export var dano := 1
## Tempo em que a região do golpe fica ativa, em segundos.
@export var duracao := 0.15
## Tempo mínimo entre o começo de um golpe e o começo do seguinte.
@export var intervalo := 0.35
## Distância do meio do personagem ao meio da região do golpe, em pixels.
@export var distancia := 38.0
## Desligue para o personagem deixar de atacar por um tempo.
@export var habilitado := true

## Verdadeiro do começo ao fim do golpe.
var atacando := false
## Lado do golpe atual ou do último: 1 direita, -1 esquerda.
var lado := 1

## Folga para comparar tempos somados quadro a quadro.
const FOLGA := 0.001

var _tempo_restante := 0.0
var _espera := 0.0
var _ativar_no_proximo_quadro := false

@onready var _hitbox: Hitbox = $Hitbox
@onready var _efeito: CanvasItem = $Hitbox/Efeito


func _ready() -> void:
	_hitbox.dano = dano
	_hitbox.golpe_unico = true
	_encerrar()


func _physics_process(delta: float) -> void:
	_espera = maxf(_espera - delta, 0.0)
	if _ativar_no_proximo_quadro:
		# A região mudou de lugar no quadro passado. Só agora a física sabe
		# quem está encostado nela, então só agora ela pode causar dano.
		_ativar_no_proximo_quadro = false
		_hitbox.ativa = true  # ligar começa um golpe novo: a lista de atingidos zera
	elif atacando:
		_tempo_restante -= delta
		if _tempo_restante <= FOLGA:
			_encerrar()
			terminou.emit()
	# just_pressed só vale no quadro em que o botão desce: segurar não repete.
	if Input.is_action_just_pressed("atacar") and pode_atacar():
		_comecar()


## Diz se um golpe pode começar agora.
func pode_atacar() -> bool:
	return habilitado and not atacando and _espera <= FOLGA


func _comecar() -> void:
	var jogador := get_parent() as Jogador
	lado = jogador.olhando_para if jogador != null else 1
	_hitbox.position.x = distancia * lado
	_hitbox.dano = dano
	atacando = true
	_tempo_restante = duracao
	_espera = intervalo
	_ativar_no_proximo_quadro = true
	_efeito.visible = true
	atacou.emit(lado)


func _encerrar() -> void:
	atacando = false
	_ativar_no_proximo_quadro = false
	_hitbox.ativa = false
	_efeito.visible = false
