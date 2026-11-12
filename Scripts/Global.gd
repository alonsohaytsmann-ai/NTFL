extends Node

var chave_coletada: bool = false
var porta_cenario4_aberta: bool = false
var tem_chave_philips: bool = false
var chave_philips_coletada: bool = false
var tem_chave: bool = false
var minigamePc_vencido: bool = false
var minigameLista_vencido: bool = false
var minigameLixo_vencido: bool = false
var minigameNotebook_vencido: bool = false
enum Dificuldade { Facil, Medio, Dificil, Impossivel }
var Dificuldade_atual: Dificuldade = Dificuldade.Medio
var tempo: float = 30.0
var toca_musica: AudioStreamPlayer

func _ready() -> void:
	toca_musica = AudioStreamPlayer.new()
	add_child(toca_musica)
	_musica_menu()
	
func _musica_menu()-> void:		
	if toca_musica.playing:
		toca_musica.stop()
	toca_musica.volume_db = -5
	toca_musica.stream = preload("res://Musicas/menu.mp3")
	toca_musica.process_mode = Node.PROCESS_MODE_ALWAYS
	toca_musica.play()
	
func Escolher_dificuldade(dificuldade_escolhida: Dificuldade):
	Dificuldade_atual = dificuldade_escolhida
	
	match Dificuldade_atual:
		Dificuldade.Facil:
			tempo = 300.0
		Dificuldade.Medio:
			tempo = 120.0
		Dificuldade.Dificil:
			tempo = 90.0
		Dificuldade.Impossivel:
			tempo = 30.0
	 
func tocar_musica_dificuldade() -> void:
	if toca_musica.playing:
		toca_musica.stop()
	match Dificuldade_atual:
		Dificuldade.Facil:
			toca_musica.stream = load("res://Musicas/1facil.mp3")
		Dificuldade.Medio:
			toca_musica.stream = load("res://Musicas/2medio.mp3")
		Dificuldade.Dificil:
			toca_musica.stream = load("res://Musicas/3dificil.mp3")
		Dificuldade.Impossivel:
			toca_musica.stream = load("res://Musicas/4impossivel.wav")
	if toca_musica.stream is AudioStreamMP3 or toca_musica.stream is AudioStreamOggVorbis:
		toca_musica.stream.loop = true
	toca_musica.play()
	
func tocar_musica_vitoria() -> void:
	toca_musica.stream = load("res://Musicas/ganhou.mp3")
	if toca_musica.stream is AudioStreamMP3 or toca_musica.stream is AudioStreamOggVorbis:
		toca_musica.stream.loop = true
	toca_musica.play()
	
func tocar_musica_derrota() -> void:
	toca_musica.stream = load("res://Musicas/perdeu.mp3")
	toca_musica.play()
	
func calcular_pontuacao() -> int:
	match Dificuldade_atual:
		Dificuldade.Facil:
			return int(tempo * 5)
		Dificuldade.Medio:
			return int(tempo * 20)
		Dificuldade.Dificil:
			return int(tempo * 40)
		Dificuldade.Impossivel:
			return int(tempo * 200)
	return 0
		
func velocidade_botao() -> float:
	match Dificuldade_atual:
		Dificuldade.Facil:
			return 1.0  
		Dificuldade.Medio:
			return 0.8   
		Dificuldade.Dificil:
			return 0.7
		Dificuldade.Impossivel:
			return 0.4  
	return 1.0


func tocar_sfx(caminho_audio: String, volume_db: float = 0.0) -> void:
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = load(caminho_audio)
	sfx_player.volume_db = volume_db
	add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)
func pausar_musica(estado: bool) -> void:
	if toca_musica:
		toca_musica.stream_paused = estado
