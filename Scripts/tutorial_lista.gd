extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_sair_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/tela_dificuldade.tscn")
