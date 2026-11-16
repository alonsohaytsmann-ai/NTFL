extends Control
func _ready() -> void:
	Fader.fade_out(0.5)

func _on_creditos_pressed() -> void:
	Global.tocar_sfx("res://Musicas/lista.wav")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Creditos.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()


func _on_novo_jogo_pressed() -> void:
	Global.tocar_sfx("res://Musicas/lista.wav")
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/tela_dificuldade.tscn")
