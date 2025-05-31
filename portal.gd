extends Area2D #portal

@export var nextScene: String
@export var id_portal_destino: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("rotina de mudança de sala")
		Globais.ultimaPorta = id_portal_destino
		Globais.ultima_pos_x = body.global_position.x
		Globais.ultima_pos_y = body.global_position.y
		call_deferred("_mudar_cena")
		
func _mudar_cena():
	get_tree().change_scene_to_file(nextScene)
