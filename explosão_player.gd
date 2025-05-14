extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	animated_sprite_2d.play("explosão")
	await animated_sprite_2d.animation_finished
	queue_free()
