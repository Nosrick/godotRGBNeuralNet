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
				
				nodes[i].AdjustWeightsOja(lastWinner.weights, 0.5, influence)
	
	return true

func Epoch(data):
	if(data.size() != INPUT_SAMPLE_SIZE):
		return false
	
	lastWinner = GetBestMatch(data)
	
	var neighbourhood = sqrt(width * height) / 10
	var widthSquared = neighbourhood * neighbourhood
	
	for i in range(nodes.size()):
		var distanceSquared = (lastWinner.vector.x - nodes[i].vector.x) * (lastWinner.vector.x - nodes[i].vector.x) + (lastWinner.vector.y - nodes[i].vector.y) * (lastWinner.vector.y - nodes[i].vector.y)
		
		if (distanceSquared < widthSquared):
			var influence = exp((-distanceSquared) / (2 * widthSquared))
			
			nodes[i].AdjustWeightsOja(data, 0.5, influence)
	
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
