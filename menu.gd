extends Node2D

func _on_button_pressed() -> void:
	Globais.vida_atual = 10
	get_tree().change_scene_to_file("res://Maaaain1.tscn")
	pass # Replace with function body.
