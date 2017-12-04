extends Node

func Roll(minimum, maximum):
	var result = randi() % maximum
	if result < minimum:
		result = minimum
	
	return result

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
