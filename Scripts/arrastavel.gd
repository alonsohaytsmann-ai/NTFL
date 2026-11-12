extends Control


func _ready() -> void:
	Fader.fade_out(0.5)
	$CanvasLayer/inventario.visible = false
	$"CanvasLayer/Botao Lista".visible = false


func _process(delta: float) -> void:
	pass


func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenarios/Cenario4.tscn")
	await Fader.fade_in(0.5)
