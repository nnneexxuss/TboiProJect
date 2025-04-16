extends Area2D

@export var velocity = Vector2.ZERO  # A velocidade será definida no script do personagem

func _process(delta):
	# Move o tiro com a velocidade
	position += velocity * delta
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name != "player":
		queue_free()  # Destrói o tiro se ele sair da tela
