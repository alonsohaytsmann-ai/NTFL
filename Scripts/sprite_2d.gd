extends CharacterBody2D

var dragging = false
var of = Vector2(0, 0)

const initial_x = 576
const initial_y = 162

var desafios = [
	{"imagem": preload("res://Sprites/imagens lixo/Pilha.png"), "lixeira_correta": 1},
	{"imagem": preload("res://Sprites/imagens lixo/lampada.png"), "lixeira_correta": 1},
	{"imagem": preload("res://Sprites/imagens lixo/esponja usada.png"), "lixeira_correta": 2},
	{"imagem": preload("res://Sprites/imagens lixo/Disco-cd.png"), "lixeira_correta": 2},
	{"imagem": preload("res://Sprites/imagens lixo/brinquedo-dinossauro.png"), "lixeira_correta": 2},
	{"imagem": preload("res://Sprites/imagens lixo/relógio-mecanico.png"), "lixeira_correta": 2},
	{"imagem": preload("res://Sprites/imagens lixo/Tenis-luzes.png"), "lixeira_correta": 1},
	{"imagem": preload("res://Sprites/imagens lixo/tomada-benjamin.png"), "lixeira_correta": 1},
]

var indice_atual = 0

@onready var sprite_visual: Sprite2D = $Sprite2D
@onready var texto_mensagem: Label = $"../Mensagem"

func _ready() -> void:
	carregar_desafio()
	mensagem_padrao()
	Fader

func _process(_delta):
	if dragging:
		position = get_global_mouse_position() - of

	var tamanho_tela = get_viewport_rect().size
	position.x = clamp(position.x, 0, tamanho_tela.x)
	position.y = clamp(position.y, 0, tamanho_tela.y)

func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false

func _on_area_1_body_entered(_body: Node2D) -> void:
	dragging = false
	verificar_resposta(1)

func _on_area_2_body_entered(_body: Node2D) -> void:
	dragging = false
	verificar_resposta(2)

func mensagem_padrao():
	texto_mensagem.text = "Escolha o lixo para o descarte correto."
	texto_mensagem.modulate = Color(1, 1, 1) 

func verificar_resposta(lixeira_escolhida: int):
	if indice_atual >= desafios.size():
		return

	var desafio_atual = desafios[indice_atual]

	if lixeira_escolhida == desafio_atual["lixeira_correta"]:
		texto_mensagem.text = "Acertou!"
		texto_mensagem.modulate = Color(0, 1, 0)  
		indice_atual += 1

		if indice_atual < desafios.size():
			carregar_desafio()
			voltar()
			await get_tree().create_timer(1.5).timeout
			mensagem_padrao()
		else:
			fim_de_jogo()
	else:
		texto_mensagem.text = "Errou!"
		texto_mensagem.modulate = Color(1, 0, 0)  
		voltar()
		await get_tree().create_timer(1.5).timeout
		mensagem_padrao()

func carregar_desafio():
	sprite_visual.texture = desafios[indice_atual]["imagem"]

func voltar():
	position.x = initial_x
	position.y = initial_y

func fim_de_jogo():
	texto_mensagem.text = "Fim do minigame!"
	texto_mensagem.modulate = Color(1, 1, 1)
	print("Fim do jogo!")
	$"../Sair".visible = true
	$"../Lixo2".visible = false
	$"../Lixo1".visible = false
	Global.minigameLixo_vencido = true
	$"../Mensagem".visible = false
	hide()
