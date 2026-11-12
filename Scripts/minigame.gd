extends Control

@onready var texto_mensagem = $mensagem
@onready var botao_esq = $botaoesquerdo
@onready var botao_dir = $botaodireito

var perguntas_disponiveis = []

var perguntas = [
	{"certo": "SSD Novo", "imagem": preload("res://Sprites/imagens minigame rodrigo/SSD-minigame3.png"), "errado": "HD Antigo", "imagem2": preload("res://Sprites/imagens minigame rodrigo/HD-antigo-minigame3.png"), "motivo": "SSDs gastam bem menos energia."},
	{"certo": "Monitor LED", "imagem": preload("res://Sprites/imagens minigame rodrigo/Monitor-led-minigame3.png"), "errado": "Monitor CRT (Tubo)", "imagem2": preload("res://Sprites/imagens minigame rodrigo/Monitor-tubo-minigame3.png"), "motivo": "Monitores de tubo dissipam muita energia e calor."},
	{"certo": "Modo Suspensão", "imagem": preload("res://Sprites/imagens minigame rodrigo/Modo-suspensão-minigame3.png"), "errado": "Protetor de Tela", "imagem2": preload("res://Sprites/imagens minigame rodrigo/Protetor-tela-minigame3.png"), "motivo": "Protetor de tela mantém a placa de vídeo a trabalhar."}
]

var pergunta_atual
var acertos = 0  
var certa_esta_na_esquerda = true

func _ready():
	Fader.fade_out(0.5)
	texto_mensagem.add_theme_font_size_override("font_size", 22)
	perguntas_disponiveis = perguntas.duplicate()
	nova_pergunta()
	$"CanvasLayer/Botao Lista".visible = false
	$CanvasLayer/inventario.visible = false

func nova_pergunta():
	botao_esq.disabled = false
	botao_dir.disabled = false
	
	if perguntas_disponiveis.is_empty():
		perguntas_disponiveis = perguntas.duplicate()
	
	var sorteio = randi() % perguntas_disponiveis.size()
	pergunta_atual = perguntas_disponiveis[sorteio]
	perguntas_disponiveis.remove_at(sorteio)
	
	var pos = randi() % 2
	if pos == 0:
		certa_esta_na_esquerda = true
		botao_esq.text = pergunta_atual["certo"]
		botao_dir.text = pergunta_atual["errado"]
		
		if pergunta_atual.has("imagem"):
			$TextureRect.texture = pergunta_atual["imagem"]
		if pergunta_atual.has("imagem2"):
			$TextureRect2.texture = pergunta_atual["imagem2"]
	else:
		certa_esta_na_esquerda = false
		botao_esq.text = pergunta_atual["errado"]
		botao_dir.text = pergunta_atual["certo"]
		
		if pergunta_atual.has("imagem2"):
			$TextureRect.texture = pergunta_atual["imagem2"]
		if pergunta_atual.has("imagem"):
			$TextureRect2.texture = pergunta_atual["imagem"]
		
	texto_mensagem.text = "Escolha a opção sustentável."
	texto_mensagem.modulate = Color(0, 0, 0)

func checar_resposta(clicou_na_esquerda):
	botao_esq.disabled = true
	botao_dir.disabled = true
	
	if clicou_na_esquerda == certa_esta_na_esquerda:
		texto_mensagem.text = "Acertou! " + pergunta_atual["motivo"]
		texto_mensagem.modulate = Color(0, 1, 0)  
		
		acertos += 1  
		
		await get_tree().create_timer(2.0).timeout
		
		if acertos >= 3:
			texto_mensagem.text = "Fim do minigame!"
			texto_mensagem.modulate = Color(0, 0, 0)
			botao_esq.visible = false
			botao_dir.visible = false
			$TextureRect.visible = false
			$TextureRect2.visible = false
			$"Sair finalizado".visible = true
			return
		
		nova_pergunta()
		
	else:
		texto_mensagem.text = "Errou! Tente novamente. " + pergunta_atual["motivo"]
		texto_mensagem.modulate = Color(1, 0, 0)
		
		await get_tree().create_timer(2.0).timeout
		
		texto_mensagem.text = "Escolha a opção sustentável."
		texto_mensagem.modulate = Color(0, 0, 0)
		
		botao_esq.disabled = false
		botao_dir.disabled = false

func _on_botao_esquerdo_pressed():
	checar_resposta(true)

func _on_botao_direito_pressed():
	checar_resposta(false)

func _on_sair_finalizado_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario3.tscn")
	Global.minigameLista_vencido = true

func _process(delta: float) -> void:
	$"CanvasLayer/Botao Lista".visible = false
	$CanvasLayer/inventario.visible = false
