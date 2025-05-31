extends CharacterBody2D #player

@export var speed: int = 220
@export var tiro_scene: PackedScene
@export var animacaoTeletransporte: PackedScene
var explosao = 0
@onready var animations = $AnimationPlayer
var teletransporte = false
var pode_meter_bala = true

func _ready() -> void:
	var destino = Globais.ultimaPorta
	var marcador = get_tree().current_scene.get_node_or_null("Marcadores/" + destino)
	
	if marcador:
		position = marcador.global_position
	else:
		position = Vector2(Globais.ultima_pos_x, Globais.ultima_pos_y)
		print("DEU RUIM")

# MOVIMENTO
func handle_input():
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	velocity = move_direction * speed

# TIRO
func shoot(direcao_tiro: Vector2):
	if tiro_scene == null:
		print("Cena do tiro não atribuída!")
		return

	var tiro = tiro_scene.instantiate()
	tiro.position = position

	# Verifica se o script do tiro aceita 'velocity'
	#if tiro.has_variable("velocity"):
		#tiro.velocity = direcao_tiro * 200  # velocidade do tiro
	#else:
		#print("O tiro não tem variável 'velocity'!")
	tiro.velocity = direcao_tiro * 400
	pode_meter_bala = false
	$Timer.start()
	get_parent().add_child(tiro)

# ANIMAÇÃO
func update_animation():
	var direction = "Down"
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Up"

	if velocity.length() > 0:
		animations.play("walk" + direction)
	else:
		animations.stop() # Opcional: animação parada


func levar_dano(quantidade: int) -> void:
	Globais.vida_atual = max(Globais.vida_atual - quantidade, 0)

# FUNÇÃO PRINCIPAL
func _physics_process(delta):
	handle_input()
	move_and_slide()
	update_animation()
	
	if Globais.volta_teletransporte == true:
		$".".visible = false
		explosao = animacaoTeletransporte.instantiate()
		explosao.position = position
		get_parent().add_child(explosao)
		await get_tree().create_timer(0.3).timeout
		$".".visible = true
		speed = 220
		Globais.volta_teletransporte = false
		
	# Pega a direção do tiro
	var direcao_tiro = Input.get_vector("tiroEsquerda", "tiroDireita", "tiroCima", "tiroBaixo")

	if direcao_tiro != Vector2.ZERO:
		if pode_meter_bala == true:
			shoot(direcao_tiro.normalized())

func _on_timer_timeout() -> void:
	pode_meter_bala = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("acao") and Globais.player_dentro:
		explosao = animacaoTeletransporte.instantiate()
		$".".visible = false
		explosao.position = position
		get_parent().add_child(explosao)
		speed = 0
		await get_tree().create_timer(0.3).timeout
		teletransporte = true
		
	elif event.is_action_released("acao"):
		teletransporte = false
