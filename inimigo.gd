extends CharacterBody2D #inimigo

@onready var navigation_agent_2d = $NavigationAgent2D
@onready var detection_area = $DetectionArea

@export var Player: CharacterBody2D
@export var Speed: float = 100
var perseguindo := false

var estadoMorte = false

func _physics_process(delta):
	if perseguindo:
		var direction = (navigation_agent_2d.get_next_path_position() - global_position).normalized() 
		velocity = direction * Speed
	else:
		velocity = Vector2.ZERO
		
		
	if estadoMorte == true:
		
		queue_free()
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
