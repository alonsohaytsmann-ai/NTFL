extends Control



func _ready() -> void:
	Fader.fade_out(0.5)
	if Global.minigameLista_vencido:
		$Button2.visible = false



func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Global.tocar_sfx("res://Musicas/porta.mp3")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario2.tscn")


func _on_button_2_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/minigame.tscn")


func _on_pausar_pressed() -> void:
	$Button.visible = false
	
func _on_botao_despausar_pressed() -> void:
	$Button.visible = true
