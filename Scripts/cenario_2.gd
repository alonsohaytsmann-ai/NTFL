extends Control

var gaveta1: bool = false
var gaveta2: bool = false
var fundo_gaveta1: Texture2D
var fundo_gaveta2: Texture2D
var fundo_ambas: Texture2D
var fundo_normal: Texture2D

func _ready() -> void:
	fundo_gaveta1 = $Fundo3.texture
	fundo_gaveta2 = $Fundo2.texture
	fundo_ambas = $Fundo4.texture
	fundo_normal = $Sprite2D.texture
	
	Fader.fade_out(0.5)
	
	if Global.chave_coletada == true:
		$Chave.visible = false
		$Chave.disabled = true
	
	if Global.porta_cenario4_aberta == true:
		$Porta_Cenario4.visible = false
		$"Porta_Cenario4 2#".visible = true

func _on_porta_cenario_1_pressed() -> void:
	Global.tocar_sfx("res://Musicas/porta.mp3")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario1.tscn")

func _on_porta_cenario_3_pressed() -> void:
	Global.tocar_sfx("res://Musicas/porta.mp3")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario3.tscn")

func _on_porta_cenario_4_pressed() -> void:
	if Global.tem_chave == true or Global.porta_cenario4_aberta == true:
		$Porta_Cenario4.visible = false
		$"Porta_Cenario4 2#".visible = true
		await Fader.fade_in(0.5)
		Global.tocar_sfx("res://Musicas/porta.mp3")
		get_tree().change_scene_to_file("res://Cenarios/Cenario4.tscn")
		Global.porta_cenario4_aberta = true
		Global.tem_chave = false
	else:
		$"Porta bloqueada".visible = true
		$"Porta bloqueada/Timer porta".start()

func _on_chave_pressed() -> void:
	$Chave.visible = false
	$Chave.disabled = true
	Global.tem_chave = true
	Global.chave_coletada = true
	$"Chave possuida".visible = true
	$"Chave possuida/Timer chave".start()

func _on_timer_chave_timeout() -> void:
	$"Chave possuida".visible = false

func _on_timer_porta_timeout() -> void:
	$"Porta bloqueada".visible = false

func _on_porta_cenario_4_2_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario4.tscn")

func _on_notebook_pressed() -> void:
	if Global.tem_chave_philips == true:
		get_tree().change_scene_to_file("res://Cenarios/notebook.tscn")
		Global.tem_chave_philips = false
		$Notebook.visible = false
	else:
		$"Precisa de philps".visible = true
		$"Precisa de philps/Timer notebook".start()

func _on_timer_notebook_timeout() -> void:
	$"Precisa de philps".visible = false

func _process(delta: float) -> void:
	pass

func _on_gaveta_1_pressed() -> void:
	gaveta1 = true
	$"Gaveta 1".visible = false
	$Gaveta01.visible = true
	
	if Global.chave_coletada == false:
		Global.tem_chave = true
		Global.chave_coletada = true
		$"Chave possuida".visible = true
		$"Chave possuida/Timer chave".start()
		
	atualizar_fundo()

func _on_gaveta_2_pressed() -> void:
	gaveta2 = true
	$"Gaveta 2".visible = false
	$Gaveta02.visible = true
	atualizar_fundo()

func _on_gaveta_01_pressed() -> void:
	gaveta1 = false
	$"Gaveta 1".visible = true
	$Gaveta01.visible = false
	atualizar_fundo()

func _on_gaveta_02_pressed() -> void:
	gaveta2 = false
	$"Gaveta 2".visible = true
	$Gaveta02.visible = false
	atualizar_fundo()

func atualizar_fundo() -> void:
	var nova: Texture2D = fundo_normal
	
	if gaveta1 == true and gaveta2 == true:
		nova = fundo_ambas
	elif gaveta1 == true:
		nova = fundo_gaveta1
	elif gaveta2 == true:
		nova = fundo_gaveta2
		
	if nova != null:
		$Sprite2D.texture = nova
