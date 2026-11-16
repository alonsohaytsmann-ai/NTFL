extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fader.fade_out(0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"CanvasLayer/Botao Lista".visible = false
	$CanvasLayer/inventario.visible = false


func _on_sair_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario4.tscn")
