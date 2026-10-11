class_name InteracaoDoJogador
extends Node2D
## Parte do personagem que cuida da interação com objetos.
##
## A cada quadro, escolhe o Interativo mais próximo que esteja ao alcance e
## o marca como selecionado. Ao apertar "interagir", aciona esse objeto.
## A distância é medida a partir da posição deste nó.
##
## Com o jogo pausado (pausa, derrota ou escurecimento da tela) este nó não
## roda, então não há interação nesses momentos.

## Emitido quando o objeto selecionado muda. Vem nulo quando não há nenhum.
signal selecao_mudou(objeto: Interativo)
## Emitido quando o personagem aciona um objeto.
signal interagiu(objeto: Interativo)

## Desligue para o personagem deixar de interagir por um tempo.
@export var habilitada := true
## Para trocar de objeto, o outro precisa estar mais perto que o atual por
## mais do que esta distância. Evita a seleção ficar alternando quando dois
## objetos estão quase à mesma distância.
@export var margem_de_troca := 4.0

## Objeto que será acionado ao apertar o botão. Nulo quando não há nenhum.
var selecionado: Interativo = null


func _physics_process(_delta: float) -> void:
	_atualizar_selecao()
	if selecionado == null:
		return
	# just_pressed só vale no quadro em que o botão desce: segurar não repete.
	if Input.is_action_just_pressed("interagir") and not Transicao.em_andamento():
		selecionado.acionar(get_parent() as Node2D)
		interagiu.emit(selecionado)


func _atualizar_selecao() -> void:
	if not is_instance_valid(selecionado):
		selecionado = null  # o objeto saiu da cena
	if not habilitada:
		_selecionar(null)
		return

	var ponto := global_position
	var mais_proximo: Interativo = null
	var menor_distancia := INF
	for no in get_tree().get_nodes_in_group(Interativo.GRUPO):
		var objeto := no as Interativo
		if objeto == null or not objeto.esta_ao_alcance_de(ponto):
			continue
		var distancia := objeto.global_position.distance_to(ponto)
		if distancia < menor_distancia:
			menor_distancia = distancia
			mais_proximo = objeto

	# No empate, ou quase empate, o objeto atual continua selecionado.
	if selecionado != null and selecionado != mais_proximo and selecionado.esta_ao_alcance_de(ponto):
		if selecionado.global_position.distance_to(ponto) <= menor_distancia + margem_de_troca:
			mais_proximo = selecionado
	_selecionar(mais_proximo)


func _selecionar(objeto: Interativo) -> void:
	if objeto == selecionado:
		return
	if selecionado != null:
		selecionado.definir_selecao(false)
	selecionado = objeto
	if selecionado != null:
		selecionado.definir_selecao(true)
	selecao_mudou.emit(selecionado)
