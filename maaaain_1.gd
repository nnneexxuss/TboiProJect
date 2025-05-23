#extends Node2D

#@onready var player: CharacterBody2D = $Player/player

#func _ready() -> void:
	#if Globais.destination_level != "":
		#var point = get_node(Globais.destination_level)
		#if point:
			#player.globais_position = point.globais_position 
