extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fader.fade_out(0.5)
	$"CanvasLayer/Botao Lista".visible = false
	$CanvasLayer/inventario.visible = false

func _process(delta: float) -> void:
	$"CanvasLayer/Botao Lista".visible = false
	$CanvasLayer/inventario.visible = false


func _on_sair_se_perdeu_pressed() -> void:
	$Label2.visible = false
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario1.tscn")


func _on_tentar_de_novo_pressed() -> void:
	$Label.visible = false
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/DesligarPC.tscn")


func _on_sair_se_ganhou_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario1.tscn")
