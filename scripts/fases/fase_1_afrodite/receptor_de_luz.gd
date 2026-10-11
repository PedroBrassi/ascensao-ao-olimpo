class_name ReceptorDeLuz
extends Node2D
## Receptor do puzzle de luz da fase de Afrodite. Fica ativo enquanto algum
## feixe chega até ele, e desliga assim que a luz para de chegar.
##
## Quem avisa que a luz chegou é a FonteDeLuz, chamando iluminar() a cada
## quadro de física. O receptor aceita luz vinda de qualquer direção.
##
## O desenho são duas imagens, uma para cada estado: os nós Inativo e Ativo.
## Ligado, o receptor ganha também um halo em volta (nó Brilho), para a
## mudança ser de forma e não só de cor. O halo é PROVISÓRIO: não veio na
## arte, é um degradê feito no próprio Godot.
##
## Se a cena ainda tiver o desenho provisório antigo (o nó Nucleo), o script
## continua mostrando e escondendo esse nó.

## Emitido quando o receptor passa a receber luz.
signal ativado
## Emitido quando o receptor deixa de receber luz.
signal desativado
## Emitido nas duas mudanças, com o estado novo.
signal estado_mudou(ativo: bool)

## Grupo em que todo receptor se registra. É por ele que a luz encontra os
## receptores da cena.
const GRUPO := "receptores_de_luz"

## Verdadeiro enquanto o receptor recebe luz. Só leitura.
var ativo := false

var _quadro_da_ultima_luz := -10

@onready var _arte_inativa := get_node_or_null("Inativo") as CanvasItem
@onready var _arte_ativa := get_node_or_null("Ativo") as CanvasItem
@onready var _brilho := get_node_or_null("Brilho") as CanvasItem
@onready var _nucleo := get_node_or_null("Nucleo") as CanvasItem  # desenho provisório


func _ready() -> void:
	add_to_group(GRUPO)
	_atualizar_desenho()


func _physics_process(_delta: float) -> void:
	# A fonte pode rodar antes ou depois do receptor dentro do mesmo quadro,
	# então a luz vale se chegou neste quadro ou no anterior.
	var recebendo := Engine.get_physics_frames() - _quadro_da_ultima_luz <= 1
	if recebendo == ativo:
		return
	ativo = recebendo
	_atualizar_desenho()
	estado_mudou.emit(ativo)
	if ativo:
		ativado.emit()
	else:
		desativado.emit()


## Chamado pela FonteDeLuz em cada quadro em que o feixe termina aqui.
func iluminar() -> void:
	_quadro_da_ultima_luz = Engine.get_physics_frames()


func _atualizar_desenho() -> void:
	if _arte_inativa != null:
		_arte_inativa.visible = not ativo
	if _arte_ativa != null:
		_arte_ativa.visible = ativo
	if _brilho != null:
		_brilho.visible = ativo
	if _nucleo != null:
		_nucleo.visible = ativo
