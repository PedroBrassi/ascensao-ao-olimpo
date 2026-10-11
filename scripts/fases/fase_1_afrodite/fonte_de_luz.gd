@tool
class_name FonteDeLuz
extends Node2D
## Fonte do puzzle de luz da fase de Afrodite. Emite um feixe reto em uma
## das quatro direções e calcula, a cada quadro de física, o caminho dele:
##
## - a luz anda só na horizontal e na vertical;
## - um Espelho no caminho muda a direção, conforme a orientação dele;
## - um ReceptorDeLuz no caminho recebe a luz, e o feixe termina nele;
## - paredes e obstáculos do mundo (corpos na camada de bloqueio) param o feixe;
## - o personagem não bloqueia a luz.
##
## Espelhos e receptores são encontrados pela posição do centro deles: o
## centro precisa estar na linha do feixe, com uma pequena tolerância. Por
## isso as peças do puzzle devem ser alinhadas pelos centros.
##
## O script roda também dentro do editor (@tool), só para a seta mostrar a
## direção escolhida no Inspetor. O feixe só existe com o jogo rodando.
##
## PROVISÓRIO: a fonte é um quadrado com uma seta, e o feixe é uma linha.
## A linha tem um contorno mais escuro (nó Feixe/Contorno, opcional) para
## aparecer também sobre fundos claros.

## Emitido quando o caminho do feixe muda.
signal feixe_mudou

enum Direcao { DIREITA, BAIXO, ESQUERDA, CIMA }

const VETORES := [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

## Direção em que a luz sai da fonte.
@export var direcao := Direcao.DIREITA:
	set(valor):
		direcao = valor
		if is_node_ready():
			_atualizar_seta()
## Desligue para a fonte parar de emitir luz.
@export var ligada := true
## Quantas vezes o feixe pode ser refletido. Impede um caminho sem fim
## quando os espelhos formam um circuito fechado.
@export_range(0, 64) var max_reflexoes := 16
## Distância que o feixe percorre quando não encontra nada, em pixels.
@export var alcance_maximo := 4000.0
## Distância máxima entre a linha do feixe e o centro de um espelho ou
## receptor para a luz acertá-lo, em pixels.
@export var tolerancia_de_alinhamento := 12.0
## Camadas de física que bloqueiam a luz. O padrão é só a camada 1, mundo.
@export_flags_2d_physics var camadas_que_bloqueiam := 1

## Pontos por onde o feixe passa, em coordenadas globais: começa na fonte e
## termina onde a luz para. Vazio com a fonte desligada.
var pontos_do_feixe := PackedVector2Array()
## Receptor em que o feixe termina, ou nulo.
var receptor_atingido: ReceptorDeLuz = null
## Quantas reflexões o feixe atual sofreu.
var reflexoes := 0

@onready var _seta: Node2D = $Seta
@onready var _feixe: Line2D = $Feixe
@onready var _contorno := get_node_or_null("Feixe/Contorno") as Line2D


func _ready() -> void:
	_atualizar_seta()
	_desenhar_feixe(PackedVector2Array())
	if Engine.is_editor_hint():
		set_physics_process(false)  # no editor só a seta interessa


func _physics_process(_delta: float) -> void:
	var novos := PackedVector2Array()
	receptor_atingido = null
	reflexoes = 0
	if ligada:
		novos = _tracar()
	if receptor_atingido != null:
		receptor_atingido.iluminar()
	if novos != pontos_do_feixe:
		pontos_do_feixe = novos
		_desenhar_feixe(pontos_do_feixe)
		feixe_mudou.emit()


## Segue a luz da fonte até ela parar e devolve os pontos do caminho.
func _tracar() -> PackedVector2Array:
	var pontos := PackedVector2Array([global_position])
	var origem := global_position
	var sentido: Vector2 = VETORES[direcao]
	var peca_atual: Node2D = null  # espelho de onde a luz acabou de sair
	var espaco := get_world_2d().direct_space_state

	while true:
		var peca := _proxima_peca(origem, sentido, peca_atual)
		var fim := origem + sentido * alcance_maximo
		if peca != null:
			fim = peca.global_position

		# Uma parede antes da peça, ou antes do fim do alcance, para a luz.
		var consulta := PhysicsRayQueryParameters2D.create(origem, fim, camadas_que_bloqueiam)
		var batida := espaco.intersect_ray(consulta)
		if not batida.is_empty():
			pontos.append(batida.position)
			break

		pontos.append(fim)
		if peca == null:
			break
		if peca is ReceptorDeLuz:
			receptor_atingido = peca
			break
		if reflexoes >= max_reflexoes:
			break
		reflexoes += 1
		sentido = (peca as Espelho).refletir(sentido)
		origem = peca.global_position
		peca_atual = peca
	return pontos


## Procura o espelho ou receptor mais próximo que esteja na linha do feixe,
## à frente da origem. Devolve nulo se não houver nenhum.
func _proxima_peca(origem: Vector2, sentido: Vector2, ignorar: Node2D) -> Node2D:
	var lateral := Vector2(-sentido.y, sentido.x)
	var mais_proxima: Node2D = null
	var menor_distancia := alcance_maximo
	for grupo in [Espelho.GRUPO, ReceptorDeLuz.GRUPO]:
		for no in get_tree().get_nodes_in_group(grupo):
			var peca := no as Node2D
			if peca == null or peca == ignorar or not peca.is_visible_in_tree():
				continue
			var ate_a_peca := peca.global_position - origem
			var a_frente := ate_a_peca.dot(sentido)
			var desvio := absf(ate_a_peca.dot(lateral))
			if a_frente <= 1.0 or desvio > tolerancia_de_alinhamento:
				continue
			if a_frente < menor_distancia:
				menor_distancia = a_frente
				mais_proxima = peca
	return mais_proxima


func _desenhar_feixe(pontos: PackedVector2Array) -> void:
	_feixe.points = pontos
	if _contorno != null:
		_contorno.points = pontos


func _atualizar_seta() -> void:
	_seta.rotation = (VETORES[direcao] as Vector2).angle()
