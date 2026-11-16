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
	await get_tree().create_timer(0.2).timeout
	Global.tocar_sfx("res://Musicas/papel 3.mp3")


func _on_animacao_fundo_animation_finished() -> void:
	get_tree().change_scene_to_file("res://Cenarios/Tutorial Lista.tscn")
