extends Control


func _ready() -> void:
	Fader.fade_out(0.5)
func _on_voltar_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/tela_do_menu.tscn")


func _on_animacao_facil_animation_finished() -> void:
	Global.Escolher_dificuldade(Global.Dificuldade.Facil)
	await get_tree().create_timer(0.2).timeout
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/cutscene.tscn")


func _on_animacao_medio_animation_finished() -> void:
	Global.Escolher_dificuldade(Global.Dificuldade.Medio)
	await get_tree().create_timer(0.2).timeout
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/cutscene.tscn")


func _on_animacao_dificil_animation_finished() -> void:
	Global.Escolher_dificuldade(Global.Dificuldade.Dificil)
	await get_tree().create_timer(0.2).timeout
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/cutscene.tscn")


func _on_animacao_impossivel_animation_finished() -> void:
	Global.Escolher_dificuldade(Global.Dificuldade.Impossivel)
	await get_tree().create_timer(0.2).timeout
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/cutscene.tscn")


func _on_facil_pressed() -> void:
	$"animacao facil".play("default")


func _on_medio_pressed() -> void:
	$"animacao medio".play("default")


func _on_dificil_pressed() -> void:
	$"animacao dificil".play("default")


func _on_impossivel_pressed() -> void:
	$"animacao impossivel".play("default")


func _on_tutorial_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Tutorial interface.tscn")
