extends TextureButton

var clicks: int = 0
var fim: bool = false
var move_timer: Timer

func _ready() -> void:
	add_to_group("botoes")
	pressed.connect(_botao_pressionado)
	
	move_timer = Timer.new()
	move_timer.wait_time = Global.velocidade_botao()
	move_timer.one_shot = true
	move_timer.timeout.connect(_mover_botao)
	add_child(move_timer)
	
	_mover_botao()

func _mover_botao() -> void:
	if fim:
		return
		
	var min_x = 120
	var max_x = 900
	var min_y = 63
	var max_y = 470
	
	position = Vector2(
		randf_range(min_x, max_x),
		randf_range(min_y, max_y)
	)
	
	move_timer.start()

func _botao_pressionado() -> void:
	if fim:
		return
		
	clicks += 1
	
	if clicks >= 3:
		_perdedor()
	else:
		_mover_botao()

func _perdedor() -> void:
	fim = true
	move_timer.stop()
	get_tree().call_group("botoes", "set_disabled", true)
	$"../Label".visible = true
	
