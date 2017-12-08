extends Node

var console
var neuralNet

var waitingForColour = true

var lastColour = []

func _ready():
	console = get_tree().get_root().get_node("./Root/TextConsole")
	neuralNet = get_tree().get_root().get_node("./Root/NeuralNet")
	
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		var input = get_text()
		if waitingForColour == true:
			var colour = Color(input)
			
			var red = colour.r
			var green = colour.g
			var blue = colour.b
			
			lastColour.clear()
			lastColour.append(red)
			lastColour.append(green)
			lastColour.append(blue)
			
			var winner = neuralNet.GetBestMatch(lastColour)
			
			var winnerRed = winner.weights[0]
			var myColour = Color(winner.weights[0], winner.weights[1], winner.weights[2])
			print(myColour.to_html())
			
			console.append_bbcode("[color=" + input + "]Your colour, " + input + "\n")
			console.append_bbcode("[color=#" + myColour.to_html() + "]My colour, #" + myColour.to_html() + "\n")
			console.append_bbcode("Is this close enough? Y/N\n")
			waitingForColour = false
			self.set_text("")
		else:
			if input == "Y" or input == "y":
				neuralNet.Reinforce()
				console.append_bbcode("Reinforcing.\n")
			elif input == "N" or input == "n":
				neuralNet.Epoch(lastColour)
				console.append_bbcode("Retraining.\n")
			self.set_text("")
			waitingForColour = true