class_name Porta
extends StaticBody2D
## Porta que bloqueia a passagem enquanto está fechada.
##
## Com acionadores na lista, a porta fica aberta enquanto todos estiverem
## ativos e fecha quando algum desliga. Sem acionadores, ela obedece só a
## abrir() e fechar().
##
## Fechada, a porta é parede: segura o personagem e também a luz do puzzle.
## Ela nunca fecha em cima do personagem: se ele estiver no vão, a porta
## espera ele sair.
##
## PROVISÓRIO: a porta é um retângulo, que some quando ela abre. O batente,
## em cima, continua visível para marcar onde a porta fica.

## Emitido quando a porta termina de abrir.
signal abriu
## Emitido quando a porta termina de fechar.
signal fechou

## Acionadores que controlam a porta (ver scripts/sistemas/acionadores.gd).
@export var acionadores: Array[Node] = []
## Estado inicial, usado só quando a lista de acionadores está vazia.
@export var aberta_no_inicio := false

## Verdadeiro enquanto a passagem está livre. Só leitura.
var aberta := false

var _deve_estar_aberta := false

@onready var _colisao: CollisionShape2D = $Colisao
@onready var _folha: CanvasItem = $Folha
@onready var _vao: Area2D = $Vao


func _ready() -> void:
	Acionadores.conectar(acionadores, _ao_mudar_acionador)
	_vao.body_exited.connect(_ao_sair_do_vao)
	if acionadores.is_empty():
		_deve_estar_aberta = aberta_no_inicio
	else:
		_deve_estar_aberta = Acionadores.todos_ativos(acionadores)
	aberta = _deve_estar_aberta
	_aplicar()


func abrir() -> void:
	definir_aberta(true)


func fechar() -> void:
	definir_aberta(false)


func definir_aberta(valor: bool) -> void:
	_deve_estar_aberta = valor
	_atualizar()


func _ao_mudar_acionador(_ativo: bool) -> void:
	definir_aberta(Acionadores.todos_ativos(acionadores))


func _ao_sair_do_vao(_corpo: Node2D) -> void:
	_atualizar()  # se a porta estava esperando para fechar, fecha agora


func _atualizar() -> void:
	if _deve_estar_aberta == aberta:
		return
	if not _deve_estar_aberta and _ha_personagem_no_vao():
		return  # não fecha em cima do personagem
	aberta = _deve_estar_aberta
	_aplicar()
	if aberta:
		abriu.emit()
	else:
		fechou.emit()


func _ha_personagem_no_vao() -> bool:
	for corpo in _vao.get_overlapping_bodies():
		if corpo is Jogador:
			return true
	return false


func _aplicar() -> void:
	# A colisão muda fora do cálculo de física, por isso o set_deferred.
	_colisao.set_deferred("disabled", aberta)
	_folha.visible = not aberta
