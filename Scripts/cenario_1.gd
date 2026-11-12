extends Control

func _on_minigame_1_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/DesligarPC.tscn")

func _on_porta_pressed() -> void:
	Global.tocar_sfx("res://Musicas/porta.mp3")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario2.tscn")

func _ready() -> void:
	Fader.fade_out(0.5)
	if Global.minigamePc_vencido:
		$"Minigame 1".visible = false
