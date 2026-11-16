extends Control


func _ready() -> void:
	Fader.fade_out(0.5)
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Global.tocar_sfx("res://Musicas/lista.wav")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/tela_do_menu.tscn")
