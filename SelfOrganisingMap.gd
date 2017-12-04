extends Node

var node = preload("NeuralNode.gd")
var tools = preload("Tools.gd").new()

var nodes = []
var lastWinner
var width
var height


var INPUT_SAMPLE_SIZE = 3

func _init(widthRef, heightRef):
	nodes = []
	width = widthRef
	height = heightRef
	
	for x in range(width):
		for y in range(height):
			nodes.append(node.new(x, y, x + 1, y + 1, INPUT_SAMPLE_SIZE))

func Reinforce():
	if lastWinner != null:
		var neighbourhood = sqrt(width * height) / 10
		var widthSquared = neighbourhood * neighbourhood
		
		for i in range(nodes.size()):
			var distanceSquared = (lastWinner.vector.x - nodes[i].vector.x) * (lastWinner.vector.x - nodes[i].vector.x) + (lastWinner.vector.y - nodes[i].vector.y) * (lastWinner.vector.y - nodes[i].vector.y)
			
			if distanceSquared < widthSquared:
				var influence = exp((-distanceSquared) / (2 * widthSquared))
				
				nodes[i].AdjustWeights(lastWinner.weights, 1.0, influence)

func Epoch(data):
	if(data[0].size() != INPUT_SAMPLE_SIZE):
		return false
	
	var result = tools.Roll(0, data.size())
	lastWinner = GetBestMatch(data[result])
	
	var neighbourhood = sqrt(width * height) / 10
	var widthSquared = neighbourhood * neighbourhood
	
	for i in range(nodes.size()):
		var distanceSquared = (lastWinner.vector.x - nodes[i].vector.x) * (lastWinner.vector.x - nodes[i].vector.x) + (lastWinner.vector.y - nodes[i].vector.y) * (lastWinner.vector.y - nodes[i].vector.y)
		
		if (distanceSquared < widthSquared):
			var influence = exp((-distanceSquared) / (2 * widthSquared))
			
			var before = nodes[i].weights
			nodes[i].AdjustWeights(data[result], 1.0, influence)
			var after = nodes[i].weights
			print("CHANGED: " + str(before == after))
	
	return true

func GetBestMatch(inputs):
	var lowestDistance = 9999999999
	var winner = null
	
	for i in range(nodes.size()):
		var distance = nodes[i].GetDistance(inputs)
		if (distance < lowestDistance):
			lowestDistance = distance
			winner = nodes[i]
	
	return winner

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
