extends Area2D

@export var destino: NodePath  # O outro portal (ex: "../TeleportB")

var player: Node2D = null

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body
		Globais.player_dentro = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		Globais.player_dentro = false
		player = null

func _process(_delta: float) -> void:
	if Globais.player_dentro and player and player.teletransporte:
		var destino_node = get_node(destino)
		if destino_node:
			player.global_position = destino_node.global_position
			player.visible = true
			player.teletransporte = false  # impede múltiplos TPs imediatos
			Globais.volta_teletransporte = true
