extends Control


func _ready() -> void:
	Fader.fade_out(0.5)
	if Global.chave_philips_coletada == true:
		$"Chave philips".visible = false

func _process(delta: float) -> void:
	if Global.minigameLixo_vencido == true:
		$"Botao Lixo".visible = false

func _on_botao_lixo_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Arrastavel.tscn")


func _on_chave_philips_pressed() -> void:
	Global.tem_chave_philips = true
	Global.chave_philips_coletada = true
	$"Chave philips".visible = false
	


func _on_botao_cenario_3_pressed() -> void:
	Global.tocar_sfx("res://Musicas/porta.mp3")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario2.tscn")


func _on_pausar_pressed() -> void:
	$"Chave philips".visible = false
	$"Botao Cenario 3".visible = false

func _on_botao_despausar_pressed() -> void:
	$"Botao Cenario 3".visible = true
	if Global.chave_philips_coletada == false:
		$"Chave philips".visible = true
