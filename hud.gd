extends CanvasLayer

@onready var barra_vida := $BarraVida

func _process(_delta: float) -> void:
	# Atualiza continuamente a barra com o valor global
	barra_vida.max_value = Globais.vida_maxima
	barra_vida.value = Globais.vida_atual
