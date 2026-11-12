extends Control

var trocando := false


func _on_proximo_pressed() -> void:
	if trocando:
		return
	trocando = true
	$Proximo.disabled = true

	var t := create_tween().set_parallel(true)
	t.tween_property($Proximo, "modulate:a", 0.0, 0.25)
	t.tween_property($TextureRect, "modulate:a", 0.0, 0.25)
	await t.finished
	$Proximo.visible = false
	$TextureRect.visible = false

	var anim = $"fundo/animacao fundo"
	anim.modulate.a = 0.0
	anim.visible = true
	anim.play("default")
	create_tween().tween_property(anim, "modulate:a", 1.0, 0.3)


func _on_animacao_fundo_animation_finished() -> void:
	get_tree().change_scene_to_file("res://Cenarios/Tutorial Lixeira.tscn")
