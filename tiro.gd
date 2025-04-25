extends Area2D

@export var velocity = Vector2.ZERO  # A velocidade será definida no script do personagem
var explosao = false

func _process(delta):
	# Move o tiro com a velocidade
	if !explosao:
		position += velocity * delta
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name != "player":
		$AnimatedSprite2D.play("explosão")
		explosao = true
		await $AnimatedSprite2D.animation_finished
		queue_free()  # Destrói o tiro se ele sair da tela
