extends Area2D #area2D que simula explosao player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globais.volta_teletransporte == true:
		animated_sprite_2d.play("reverso")
	elif Globais.volta_teletransporte == false:
		animated_sprite_2d.play("explosão")
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	await animated_sprite_2d.animation_finished
	queue_free()
