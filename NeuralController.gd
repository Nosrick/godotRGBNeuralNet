extends Node

var trainingSet = []
var brain

var console
var lineEdit

func CreateTrainingSet():
	var red = []
	red.append(1.0)
	red.append(0)
	red.append(0)
	
	var green = []
	green.append(0)
	green.append(1.0)
	green.append(0)
	
	var blue = []
	blue.append(0)
	blue.append(0)
	blue.append(1.0)
	
	trainingSet.append(red)
	trainingSet.append(green)
	trainingSet.append(blue)

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
	
	CreateTrainingSet()
	brain = load("SelfOrganisingMap.gd").new(50, 50)
	for i in range(10):
		brain.Epoch(trainingSet)
		
	console.add_text("Welcome to RGBNeuralNet. Enter a colour value to use. For example: #FFFFFF\n")