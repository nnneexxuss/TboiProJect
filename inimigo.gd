extends CharacterBody2D #inimigo

@onready var navigation_agent_2d = $NavigationAgent2D
@onready var detection_area = $DetectionArea
@onready var sprite: AnimatedSprite2D = $Sprite2D

@export var Player: CharacterBody2D

@export var Speed: float = 200

var perseguindo := false
var estadoMorte = false
var vida_monstro = 4

func _physics_process(delta):
	if perseguindo and !estadoMorte:
		var direction = (navigation_agent_2d.get_next_path_position() - global_position).normalized() 
		velocity = direction * Speed
	else:
		velocity = Vector2.ZERO
		
	if vida_monstro <=0:
		sprite.play("MORTE")
		estadoMorte = true
		
		#$".".scale = Vector2(9.5, 9.5)
		#await get_tree().create_timer(0.2).timeout
		#queue_free()
		
	move_and_slide()

func _on_timer_timeout():
	if perseguindo:
		navigation_agent_2d.target_position = Player.global_position


func _on_DetectionArea_body_entered(body):
	if body == Player:
		perseguindo = true
		navigation_agent_2d.target_position = Player.global_position

func _on_DetectionArea_body_exited(body):
	if body == Player:
		perseguindo = false


func _on_causar_dano_body_entered(body: Node2D) -> void:
	if body == Player:
		Globais.vida_atual -= 1
		if Globais.vida_atual <= 0:
			get_tree().change_scene_to_file("res://GAMEOVER.tscn")
		else:	
			$CausarDano/CollisionShape2D.disabled = true
			await get_tree().create_timer(1.0).timeout
			$CausarDano/CollisionShape2D.disabled = false
	pass # Replace with function body.
