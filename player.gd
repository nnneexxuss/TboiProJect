extends CharacterBody2D

@export var speed: int = 220
@export var tiro_scene: PackedScene
@onready var animations = $AnimationPlayer

var pode_meter_bala = true
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
	if velocity.x < 0:
		direction = "Left"
	elif velocity.x > 0:
		direction = "Right"
	elif velocity.y < 0:
		direction = "Up"

	if velocity.length() > 0:
		animations.play("walk" + direction)
	else:
		animations.play("idle" + direction) # Opcional: animação parada

# FUNÇÃO PRINCIPAL
func _physics_process(delta):
	handle_input()
	move_and_slide()
	update_animation()
	
	# Pega a direção do tiro
	var direcao_tiro = Input.get_vector("tiroEsquerda", "tiroDireita", "tiroCima", "tiroBaixo")

	if direcao_tiro != Vector2.ZERO:
		if pode_meter_bala == true:
			shoot(direcao_tiro.normalized())
		
		
	

func _on_timer_timeout() -> void:
	pode_meter_bala = true
	pass # Replace with function body.
