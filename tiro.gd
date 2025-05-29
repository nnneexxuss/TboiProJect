extends Area2D #tiro

@export var velocity = Vector2.ZERO  # A velocidade será definida no script do personagem
var explosao = false

func _process(delta):
	# Move o tiro com a velocidade
	if !explosao:
		position += velocity * delta
	
func _on_body_entered(body: Node2D) -> void:
	 
	if body.is_in_group("Enemy"):
		print("entrando no corpo")
		$AnimatedSprite2D.play("explosão")
		explosao = true
		body.estadoMorte = true
		$CollisionShape2D.disabled = true
		$CollisionShape2D.visible = false
		await $AnimatedSprite2D.animation_finished
		queue_free()  # Destrói o tiro se ele sair da tela
		
	elif body.name != "player":
		$AnimatedSprite2D.play("explosão")
		explosao = true
		$CollisionShape2D.disabled = true
		$CollisionShape2D.visible = false
		await $AnimatedSprite2D.animation_finished
		queue_free()  # Destrói o tiro se ele sair da tela
