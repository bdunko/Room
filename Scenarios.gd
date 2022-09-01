extends Node

class Scenario:
	var scareText
	
	func _init(var scareText):
		self.scareText = scareText;
		
class MadnessScenario extends Scenario:
	func _init(var scareText).(scareText):
		pass
	
	func generateEndingText(var player):
		var result = "";
		result += "The thoughts are starting again.\n"
		if player.hasItem("purse"):
			result += "Her purse...\n"
		if player.hasItem("sanitizer"):
			result += "Her sanitizer...\n"
		if player.hasItem("cash"):
			result += "Her money...\n"
		if player.hasItem("a teddy bear named Mr. Snuffleguts"):
			result += "Her bear...\n"

		result += "A second of guilt flashes through your mind.\nBut like always, it quickly passes.\nYou start daydreaming about the next one.\n"
		
		return result

class PoisonedScenario extends Scenario:
	func _init(var scareText).(scareText):
		pass
	
	func generateEndingText(var player):
		var result = "";
		result += "You feel your heart rate increasing. Your throat begins to tighten.\n"
		if player.hasItem("a teddy bear named Mr. Snuffleguts"):
			result += "You grasp Mr. Snuffleguts tight...\n"
		if player.hasItem("sanitizer"):
			result += "No amount of hand sanitizer is sufficient as antivenom.\n"
		if player.hasItem("bottle"):
			result += "You drink the water, but it's insufficient to dilute a poison of this potency.\n"
		elif player.hasItem("empty bottle"):
			result += "The water was insufficient to dilute a poison of this potency.\n"
		result += "Your organs are beginning to shut down... there's nothing you can do..."
		
		return result

class AbductedScenario extends Scenario:
	func _init(var scareText).(scareText):
		pass
	
	func generateEndingText(var player):
		var result = "";
		result += "You hear the familiar sound of a key being inserted into the door.\n"
		if player.hasItem("a teddy bear named Mr. Snuffleguts"):
			result += "You hold Mr. Snuffleguts tight...\n"
		if player.hasItem("keys"):
			result += "Looking down at your car keys, you wonder if this all could have been avoided,\nhad you only stayed home that night."
		if player.hasItem("cash"):
			result += "Was the cash really worth it? Now you're paying with something priceless.\n"
		result += "You hear laughter as the door swings open... there's nothing you can do..."
		
		return result

class FireScenario extends Scenario:
	func _init(var scareText).(scareText):
		pass
	
	func generateEndingText(var player):
		var result = "";
		result += "The flames are lapping at your ankles now.\n"
		if player.hasItem("a teddy bear named Mr. Snuffleguts"):
			result += "You futilely offer up Mr. Snuffleguts as a sacrifice...\n"
		if player.hasItem("bottle"):
			result += "You empty the bottle at your feet.\nThat helped a little, but is it enough...?\n"
		if player.hasItem("empty bottle"):
			result += "You feel really foolish now for drinking that water bottle.\n"
		result += "The flames close in... there's nothing you can do..."
		
		return result

class StrangerScenario extends Scenario:
	func _init(var scareText).(scareText):
		pass
	
	func generateEndingText(var player):
		var result = "";
		result += "The door to your closet bursts open as the stranger rushes towards you.\n"
		var defended = false
		if player.hasItem("a teddy bear named Mr. Snuffleguts"):
			result += "You futilely hold up Mr. Snuffleguts as a shield...\n"
			defended = true
		if player.hasItem("purse"):
			result += "You desperately consider swinging the purse as a weapon...\n"
			defended = true
		if player.hasItem("keys"):
			result += "You pull out the keys, but they aren't sharp enough to do any real damage...\n"
			defended = true
		if not defended:
			result += "You don't have anything at all to defend yourself with...\n"
		result += "The cloaked figure closes in... there's nothing you can do..."
		
		return result

var scenarios
var current

func _ready():
	scenarios = [
		StrangerScenario.new("You'd better think of something soon.\nThat stranger in your closet is getting impatient."),
		FireScenario.new("The smoke is getting thicker.\nThe flames have almost reached the foot of the bed."),
		AbductedScenario.new("You hear screams from the next cell over.\nIt sounds like they're finally finishing him off."),
		PoisonedScenario.new("Pain shoots through your veins.\nThe poison is surely getting close to your heart by now..."),
		MadnessScenario.new("You wonder if the doctor will let you go home soon.\nAfter all, you didn't REALLY mean to kill that girl, right?")
	]

func pickScenario():
	current = scenarios[randi()%len(scenarios)]
	
func getScareText():
	return current.scareText
	
func getEndText(var player):
	#print(player.hasItem("cake"))
	return current.generateEndingText(player)
