extends Node
## Guarda o progresso do jogador: quais fases estão liberadas e quais áreas
## já foram concluídas. Grava tudo em arquivo a cada mudança e lê de volta
## quando o jogo abre.
##
## Este script é um autoload: fica carregado o jogo inteiro, fora das cenas,
## e pode ser chamado de qualquer lugar como Progresso.concluir_area(...).

## Emitido sempre que o progresso muda.
signal mudou
## Emitido quando uma fase nova é liberada.
signal fase_foi_liberada(fase: int)

const TOTAL_DE_FASES := 5
## Quantidade de áreas de cada fase, na ordem das fases: Afrodite, Ares,
## Hades, Poseidon e Zeus. Para mudar a quantidade de uma fase, troque o
## número aqui. Os valores de Ares em diante são provisórios.
const AREAS_POR_FASE: Array[int] = [5, 2, 2, 2, 2]
## "user://" é a pasta de dados do jogo no computador de quem joga.
const CAMINHO_DO_ARQUIVO := "user://progresso.json"

## Número da última fase liberada. A fase 1 começa liberada.
var fases_liberadas := 1
## Áreas concluídas, cada uma no formato "fase-area" (por exemplo "1-2").
var areas_concluidas: Array[String] = []


func _ready() -> void:
	carregar()
	mudou.connect(salvar)  # toda mudança vai direto para o arquivo


func fase_esta_liberada(fase: int) -> bool:
	return fase >= 1 and fase <= fases_liberadas


func area_esta_concluida(fase: int, area: int) -> bool:
	return _chave(fase, area) in areas_concluidas


## Quantas áreas a fase tem. Devolve 0 para uma fase que não existe.
func areas_da_fase(fase: int) -> int:
	if fase < 1 or fase > TOTAL_DE_FASES or fase > AREAS_POR_FASE.size():
		return 0
	return AREAS_POR_FASE[fase - 1]


## Diz se a fase existe e tem uma área com esse número.
func area_existe(fase: int, area: int) -> bool:
	return area >= 1 and area <= areas_da_fase(fase)


## Uma fase está concluída quando todas as áreas dela foram concluídas.
func fase_esta_concluida(fase: int) -> bool:
	if areas_da_fase(fase) == 0:
		return false
	for area in range(1, areas_da_fase(fase) + 1):
		if not area_esta_concluida(fase, area):
			return false
	return true


## O jogo está concluído quando todas as fases estão concluídas.
func jogo_esta_concluido() -> bool:
	for fase in range(1, TOTAL_DE_FASES + 1):
		if not fase_esta_concluida(fase):
			return false
	return true


## Marca uma área como concluída. Se com ela a fase inteira ficou concluída,
## libera a fase seguinte. Áreas fora das fases (fase 0) e áreas de fases
## ainda bloqueadas são ignoradas.
func concluir_area(fase: int, area: int) -> void:
	if not area_existe(fase, area) or not fase_esta_liberada(fase):
		return
	if area_esta_concluida(fase, area):
		return
	areas_concluidas.append(_chave(fase, area))
	if fase_esta_concluida(fase) and fase == fases_liberadas and fase < TOTAL_DE_FASES:
		fases_liberadas = fase + 1
		fase_foi_liberada.emit(fases_liberadas)
	mudou.emit()


## Apaga todo o progresso, como em um jogo novo.
func reiniciar() -> void:
	fases_liberadas = 1
	areas_concluidas.clear()
	mudou.emit()


## Grava o progresso no arquivo, em JSON.
func salvar() -> void:
	var arquivo := FileAccess.open(CAMINHO_DO_ARQUIVO, FileAccess.WRITE)
	if arquivo == null:
		push_warning("Progresso: não foi possível gravar o arquivo (erro %d)." % FileAccess.get_open_error())
		return
	var dados := {
		"versao": 1,
		"fases_liberadas": fases_liberadas,
		"areas_concluidas": areas_concluidas,
	}
	arquivo.store_string(JSON.stringify(dados, "\t"))


## Lê o progresso do arquivo. Se o arquivo não existir ou estiver
## estragado, o jogo começa do zero em vez de dar erro.
func carregar() -> void:
	fases_liberadas = 1
	areas_concluidas.clear()
	if not FileAccess.file_exists(CAMINHO_DO_ARQUIVO):
		return
	var json := JSON.new()
	var erro := json.parse(FileAccess.get_file_as_string(CAMINHO_DO_ARQUIVO))
	if erro != OK or not json.data is Dictionary:
		push_warning("Progresso: arquivo ilegível, começando do zero.")
		return
	var dados: Dictionary = json.data

	# Nada do arquivo é usado sem conferir: ele pode ter sido editado à mão.
	var liberadas = dados.get("fases_liberadas", 1)
	if liberadas is float or liberadas is int:
		fases_liberadas = clampi(int(liberadas), 1, TOTAL_DE_FASES)
	var areas = dados.get("areas_concluidas", [])
	if areas is Array:
		for chave in areas:
			if chave is String and _chave_e_valida(chave) and not chave in areas_concluidas:
				areas_concluidas.append(chave)


func _chave(fase: int, area: int) -> String:
	return "%d-%d" % [fase, area]


func _chave_e_valida(chave: String) -> bool:
	var partes := chave.split("-")
	if partes.size() != 2 or not partes[0].is_valid_int() or not partes[1].is_valid_int():
		return false
	return area_existe(int(partes[0]), int(partes[1]))
