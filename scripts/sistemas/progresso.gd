extends Node
## Guarda o progresso do jogador: quais fases estão liberadas e quais áreas
## já foram concluídas.
##
## Este script é um autoload: fica carregado o jogo inteiro, fora das cenas,
## e pode ser chamado de qualquer lugar como Progresso.concluir_area(...).

## Emitido sempre que o progresso muda.
signal mudou
## Emitido quando uma fase nova é liberada.
signal fase_foi_liberada(fase: int)

const TOTAL_DE_FASES := 5
const AREAS_POR_FASE := 2

## Número da última fase liberada. A fase 1 começa liberada.
var fases_liberadas := 1
## Áreas concluídas, cada uma no formato "fase-area" (por exemplo "1-2").
var areas_concluidas: Array[String] = []


func fase_esta_liberada(fase: int) -> bool:
	return fase >= 1 and fase <= fases_liberadas


func area_esta_concluida(fase: int, area: int) -> bool:
	return _chave(fase, area) in areas_concluidas


func fase_esta_concluida(fase: int) -> bool:
	for area in range(1, AREAS_POR_FASE + 1):
		if not area_esta_concluida(fase, area):
			return false
	return true


func jogo_esta_concluido() -> bool:
	return fase_esta_concluida(TOTAL_DE_FASES)


## Marca uma área como concluída. Se com ela a fase inteira ficou concluída,
## libera a fase seguinte. Áreas fora das fases (como as de teste, que usam
## fase 0) e áreas de fases ainda bloqueadas são ignoradas.
func concluir_area(fase: int, area: int) -> void:
	if not _area_existe(fase, area) or not fase_esta_liberada(fase):
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


func _area_existe(fase: int, area: int) -> bool:
	return fase >= 1 and fase <= TOTAL_DE_FASES and area >= 1 and area <= AREAS_POR_FASE


func _chave(fase: int, area: int) -> String:
	return "%d-%d" % [fase, area]
