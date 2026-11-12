extends Control

var jogo_ativo: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not jogo_ativo or get_tree().paused:
		return

	if _venceu():
		_finalizar_jogo(true)
		return

	Global.tempo -= delta
	if Global.tempo <= 0.0:
		Global.tempo = 0.0
		_finalizar_jogo(false)
		return

	$Tempo.text = "Tempo: %d" % Global.tempo
	_atualizar_inventario()
	_atualizar_checks_do_papelzao()

func _venceu() -> bool:
	return Global.minigamePc_vencido and Global.minigameLista_vencido \
		and Global.minigameLixo_vencido and Global.minigameNotebook_vencido

func _finalizar_jogo(venceu: bool) -> void:
	if not jogo_ativo: return
	jogo_ativo = false

	await Fader.fade_in(0.5)

	_esconder_hud()
	$Papelzao.visible = false

	$Panel.visible = true
	$Panel.move_to_front()

	if venceu:
		Global.tocar_musica_vitoria()
		$Vitoria.visible = true
		$Vitoria/pontos.visible = true
		$Vitoria.move_to_front()
		if Global.has_method("calcular_pontuacao"):
			$Vitoria/pontos.text = "" + str(Global.calcular_pontuacao())
	else:
		Global.tocar_musica_derrota()
		$"Fim de jogo".visible = true
		$"Fim de jogo".move_to_front()

	$"Botao voltar para o menu perdeu".visible = true
	$"Botao voltar para o menu perdeu".move_to_front()

	await Fader.fade_out(0.5)

func _atualizar_checks_do_papelzao() -> void:
	if $Papelzao.visible == false:
		return
		
	$"Papelzao/Check 1".visible = Global.minigamePc_vencido
	$"Papelzao/Check 2".visible = Global.minigameLista_vencido
	$"Papelzao/Check 3".visible = Global.minigameLixo_vencido
	$"Papelzao/Check 4".visible = Global.minigameNotebook_vencido



func _resetar_jogo() -> void:
	Global.tem_chave = false
	Global.tem_chave_philips = false
	Global.chave_coletada = false
	Global.porta_cenario4_aberta = false
	Global.minigamePc_vencido = false
	Global.minigameLista_vencido = false
	Global.minigameNotebook_vencido = false
	Global.minigameLixo_vencido = false

func _on_botao_voltar_para_o_menu_perdeu_pressed() -> void:
	_voltar_ao_menu()

func _on_botao_voltar_para_o_menu_pausa_pressed() -> void:
	get_tree().paused = false
	_voltar_ao_menu()

func _voltar_ao_menu() -> void:
	_resetar_jogo()
	Global.tocar_musica_dificuldade()
	get_tree().change_scene_to_file("res://Cenarios/tela_do_menu.tscn")
	Fader.fade_out(0.5)

func _on_pausar_pressed() -> void:
	Global.pausar_musica(true)
	get_tree().paused = true  
	_esconder_hud()
	_fade_in_elementos([$Panel, $VBoxContainer, $Pausado])

func _on_botao_despausar_pressed() -> void:
	Global.pausar_musica(false)
	get_tree().paused = false
	_fade_out_elementos([$Panel, $VBoxContainer, $Pausado])
	_mostrar_hud()

func _on_botao_lista_pressed() -> void:
	_esconder_hud()
	_fade_in_elementos([$Panel, $Papelzao])

func _on_voltar_pressed() -> void:
	_fade_out_elementos([$Panel, $Papelzao])
	_mostrar_hud()

func _atualizar_inventario() -> void:
	if $Papelzao.visible == true:
		$"inventario/Chave 1".visible = false
		$"inventario/Chave philips 1".visible = false
	else:
		if Global.tem_chave == true:
			$"inventario/Chave 1".visible = true
		else:
			$"inventario/Chave 1".visible = false
			
		if Global.tem_chave_philips == true:
			$"inventario/Chave philips 1".visible = true
		else:
			$"inventario/Chave philips 1".visible = false

func _mostrar_hud() -> void:
	$Pausar.visible = true
	$Tempo.visible = true
	$Sprite2D.visible = true
	$"Botao Lista".visible = true
	$inventario.visible = true

func _esconder_hud() -> void:
	$Pausar.visible = false
	$Tempo.visible = false
	$Sprite2D.visible = false
	$"Botao Lista".visible = false
	$inventario.visible = false

func _fade_in_elementos(nos: Array[Control], duracao: float = 0.2) -> void:
	var t := create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	for no in nos:
		no.modulate.a = 0.0
		no.visible = true
		t.parallel().tween_property(no, "modulate:a", 1.0, duracao)

func _fade_out_elementos(nos: Array[Control], duracao: float = 0.2) -> void:
	var t := create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	for no in nos:
		t.parallel().tween_property(no, "modulate:a", 0.0, duracao)
		t.parallel().tween_callback(func(): no.visible = false).set_delay(duracao)
