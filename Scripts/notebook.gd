extends Control

@onready var parafuso: AnimatedSprite2D = $parafuso
@onready var chavinha: Control = $chavinha
@onready var parafusinho: AnimatedSprite2D = $parafusinho
@onready var tela_venceu: CanvasItem = $Venceu

const AJUSTE_ANIM := Vector2(20, 20)
const TAMANHO_CHAVE := Vector2(200, 200)
const RAIO_ACERTO := 60.0
const TEMPO_TRAJETORIA := 1.0

var tween_chave: Tween
var botao_atual: Button
var restantes: int = 0
var animando: bool = false

func _ready() -> void:
	Fader.fade_out(0.5)
	
	position = (get_viewport_rect().size - size) * 0.5
	parafuso.position = size * 0.5
	parafusinho.visible = false
	chavinha.visible = false
	chavinha.size = TAMANHO_CHAVE

	for filho in get_children():
		if filho is Button and filho != tela_venceu:
			filho.focus_mode = Control.FOCUS_NONE
			filho.pressed.connect(_on_parafuso_clicado.bind(filho))
			restantes += 1

func _process(delta: float) -> void:
	$"CanvasLayer/Botao Lista".visible = false
	$CanvasLayer/inventario.visible = false

func _on_parafuso_clicado(botao: Button) -> void:
	if chavinha.visible or animando:
		return
		
	botao_atual = botao
	parafuso.frame = 0
	parafuso.visible = true
	chavinha.visible = true
	
	_iniciar_ciclo_chave()


func _iniciar_ciclo_chave() -> void:
	var limite_max_x: float = maxf(0.0, size.x - TAMANHO_CHAVE.x)
	var limite_min_x: float = minf(size.x * 0.7, limite_max_x)
	var limite_max_y: float = maxf(0.0, size.y - TAMANHO_CHAVE.y)

	var pos_inicial := Vector2(
		randf_range(limite_min_x, limite_max_x),
		randf_range(0.0, limite_max_y)
	)
	var pos_final := Vector2(
		limite_max_x - pos_inicial.x,
		limite_max_y - pos_inicial.y
	)

	chavinha.position = pos_inicial

	if tween_chave and tween_chave.is_running():
		tween_chave.kill()

	tween_chave = create_tween()
	tween_chave.tween_property(chavinha, "position", pos_final, TEMPO_TRAJETORIA)
	tween_chave.tween_callback(_iniciar_ciclo_chave)


func _input(event: InputEvent) -> void:
	if not chavinha.visible or animando:
		return

	var toque_tela := (event is InputEventScreenTouch and event.is_pressed())
	if event.is_action_pressed("ui_accept") or toque_tela:
		get_viewport().set_input_as_handled()
		_verificar_acerto()


func _verificar_acerto() -> void:
	var centro_chave: Vector2 = chavinha.position + (chavinha.size * 0.5)

	if centro_chave.distance_squared_to(parafuso.position) <= (RAIO_ACERTO * RAIO_ACERTO):
		_processar_acerto()
	else:
		print("errado")


func _processar_acerto() -> void:
	print("acerto")
	if tween_chave:
		tween_chave.kill()
		
	chavinha.visible = false
	animando = true

	parafuso.play("girando")
	await parafuso.animation_finished
	parafuso.visible = false

	if is_instance_valid(botao_atual):
		botao_atual.visible = false
		await _tocar_animacao_sumir(botao_atual)
		botao_atual = null

	animando = false
	restantes -= 1

	if restantes <= 0:
		print("acabo")
		Global.minigameNotebook_vencido = true
		tela_venceu.visible = true


func _tocar_animacao_sumir(botao: Button) -> void:
	parafusinho.position = botao.position + (botao.size * 0.5) + AJUSTE_ANIM
	parafusinho.visible = true
	parafusinho.stop()
	parafusinho.frame = 0
	parafusinho.play("default")
	await parafusinho.animation_finished
	parafusinho.visible = false


func _on_venceu_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario2.tscn")
