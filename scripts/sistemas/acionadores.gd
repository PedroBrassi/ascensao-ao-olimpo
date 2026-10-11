class_name Acionadores
extends RefCounted
## Funções de apoio para objetos que dependem de acionadores, como a porta
## e o portal.
##
## Um ACIONADOR é qualquer nó que tenha:
## - uma variável `ativo`, verdadeira ou falsa;
## - um sinal `estado_mudou(ativo)`, emitido quando essa variável muda.
##
## O ReceptorDeLuz é o primeiro acionador do jogo. Alavancas e placas de
## pressão podem seguir o mesmo contrato e funcionar com os mesmos objetos.
##
## Este script não vai em nenhum nó: as funções são chamadas direto, como
## Acionadores.todos_ativos(lista).


## Verdadeiro quando todos os acionadores da lista estão ativos. Uma lista
## vazia conta como verdadeira. Entradas inválidas são ignoradas.
static func todos_ativos(lista: Array[Node]) -> bool:
	for no in lista:
		if not _e_valido(no):
			continue
		if not no.get("ativo"):
			return false
	return true


## Liga o sinal `estado_mudou` de cada acionador à função dada, e avisa no
## console sobre as entradas que não são acionadores.
static func conectar(lista: Array[Node], ao_mudar: Callable) -> void:
	for no in lista:
		if not _e_valido(no):
			push_warning("Acionadores: há uma entrada vazia ou sem `ativo` e `estado_mudou` na lista. Ela foi ignorada.")
			continue
		no.connect("estado_mudou", ao_mudar)


static func _e_valido(no: Node) -> bool:
	return no != null and no.has_signal("estado_mudou") and "ativo" in no
