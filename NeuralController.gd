extends Node

var red = [1.0, 0.0, 0.0]
var green = [0.0, 1.0, 0.0]
var blue = [0.0, 0.0, 1.0]
var brain

var console
var lineEdit

func GetBestMatch(inputs):
	return brain.GetBestMatch(inputs)

func Epoch(inputs):
	return brain.Epoch(inputs)

func Reinforce():
	brain.Reinforce()

func _ready():
	randomize()
	console = get_tree().get_root().get_node("./Root/TextConsole")
	lineEdit = get_tree().get_root().get_node("./Root/LineEdit")
	
	brain = load("SelfOrganisingMap.gd").new(50, 50)
	for i in range(10):
		brain.Epoch(red)
		brain.Epoch(green)
		brain.Epoch(blue)
		
	console.add_text("Welcome to RGBNeuralNet. Enter a colour value to use. For example: #FFFFFF\n")