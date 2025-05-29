extends Area2D

func _on_area_entered(area: Area2D) -> void:
	print("ALGO TOCOU")
	if area.name == "tiro" :
		get_parent().queue_free()



func _on_body_entered(body: Node2D) -> void:
	print("ALGO TOCOU")
	if body.name == "tiro" :
		get_parent().queue_free()
