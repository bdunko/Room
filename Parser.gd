extends Node

var synonyms : Dictionary;

func _ready():
	synonyms = {
		"search" : "look",
		"check" : "look",
		"bag" : "inventory",
		"stuff" : "inventory",
	}

func _standardizeWord(word):
	return synonyms[word] if synonyms.has(word) else word

func standardize(sentence : String):
	var standard = ""
	var words = sentence.strip_edges().to_lower().split(" ");
	for word in words:
		standard += _standardizeWord(word) + " "
	return standard.strip_edges()
