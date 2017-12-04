extends Node

var brain
var pixelWidth
var pixelHeight

func _ready():
	brain = get_tree().get_root().get_node("./Root/NeuralNet").brain
	pixelWidth = 300 / brain.width
	pixelHeight = 300 / brain.height
	set_process(true)
	CreateGrid()

func _process(delta):
	var row = 0
	var column = 0
	for i in range(brain.nodes.size()):
		var node = get_child(i)
		var red = brain.nodes[i].weights[0]
		var green = brain.nodes[i].weights[1]
		var blue = brain.nodes[i].weights[2]
		node.set_modulate(Color(red, green, blue))

func CreateGrid():
	var draw = load("draw.png")
	for i in range(brain.nodes.size()):
		var sprite = Sprite.new()
		sprite.set_texture(draw)
		var red = brain.nodes[i].weights[0]
		var green = brain.nodes[i].weights[1]
		var blue = brain.nodes[i].weights[2]
		sprite.set_modulate(Color(red, green, blue))
		sprite.set_global_scale(Vector2(pixelWidth, pixelHeight))
		sprite.set_pos(Vector2(i % brain.width * pixelWidth, i / brain.width * pixelHeight + (pixelHeight/ 2)))
		sprite.set_name("NN" + str(i))
		add_child(sprite)