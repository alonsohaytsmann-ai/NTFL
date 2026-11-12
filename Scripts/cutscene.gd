extends Control


@onready var passar_botao: Button = $Button

func _ready() -> void:
	Fader.fade_out(0.5)
	passar_botao.icon = preload("res://Sprites/Passar-botão1.png")

func _on_video_stream_player_finished() -> void:
	await Fader.fade_in(0.5)
	Global.tocar_musica_dificuldade()
	get_tree().change_scene_to_file("res://Cenarios/Cenario1.tscn")
	


func _on_button_pressed() -> void:
	await Fader.fade_in(0.5)
	Global.tocar_musica_dificuldade()
	get_tree().change_scene_to_file("res://Cenarios/Cenario1.tscn")


func _on_button_button_down() -> void:
	passar_botao.icon = preload("res://Sprites/Passar-botão2.png")
	
func _on_button_button_up() -> void:
	passar_botao.icon = preload("res://Sprites/Passar-botão1.png")
