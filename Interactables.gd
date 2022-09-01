extends Node


class Bed:
	var name = "bed"
	
	func take(var player):
		player.addItem("too much ambition (tried to 'take bed')")
		return "Try as you might, the bed is too heavy to move."
	
	func look(var player):
		return "It's a queen-sized bed. The 'bedsheet' is white. The bed looks comfy, barring the conspicuous lack of a pillow."
	
	func use(var player, var interactable_list):
		return "This is no time for a nap!\nHave you completely forgotten the situation you're in?"

class Bedsheet:
	var name = "bedsheet"
	var tied = false
	
	func take(var player):
		if tied:
			player.addItem("rope")
			return "You pick up the rope."
		player.addItem("bedsheet")
		return "You pick up the bedsheet."
	
	func look(var player):
		if tied:
			return "It's a bedsheet, but in rope form."
		return "There's a few stains here and there, but they're still nice sheets."
	
	func use(var player, var interactable_list):
		if player.hasItem("bedsheet"):
			player.replaceItem("bedsheet", "rope")
		if tied:
			return "You've already tied it into a rope."
		interactable_list.push_front(Rope.new())
		return "You tie the bedsheet into a makeshift 'rope'."
		
class Rope:
	var name = "rope"
	
	func take(var player):
		player.addItem(name)
		return "You pick up the rope."
	
	func look(var player):
		return "It's a rope made of bedsheet."
		
	func use(var player, var interactable_list):
		return "Use it for what? Just 'take' the rope."
		

class Table:
	var name = "table"
	
	func take(var player):
		player.addItem("no tables")
		return "It's too heavy to move. And it's bolted down to the floor, which certainly isn't helping."
		
	func look(var player):
		return "The metal table is bolted to the floor.\nOn top of the table, you see a 'bottle', a clock', and a 'lamp'."

	func use(var player, var interactable_list):
		return "You use the table for awhile. Nothing interesting happens."

class Clock:
	var name = "clock"
	
	func take(var player):
		player.addItem("clock")
		return "You pick up the alarm clock."
		
	func look(var player):
		return "It's a classical alarm clock.\nStrangly, it seems to be missing hands."
		
	func use(var player, var interactable_list):
		var time = OS.get_time()
		return "It's impossible to use a clock without hands.\n(but for the record, the time is %d:%d)" % [time.hour, time.minute]

class Bottle:
	var name = "bottle"
	var full = true
	
	func take(var player):
		if full:
			player.addItem("bottle")
		else:
			player.addItem("empty bottle")
		return "You pick up the water bottle."
	
	func look(var player):
		if full:
			return "It's a bottle full of clear water."
		else:
			return "It's an empty bottle"
		
	func use(var player, var interactable_list):
		if full:
			if(player.hasItem("bottle")):
				player.replaceItem("bottle", "empty bottle")
			full = false
			return "You drink from the bottle. Now it's an empty bottle."
		else:
			return "You drink from the bottle. Now it's an emptier bottle."

class Lamp:
	var name = "lamp"
	var lit = false
	
	func take(var player):
		player.addItem("lamp")
		return "You pick up the portable lamp."
		
	func look(var player):
		return "It's a portable camping lamp. The lamp is %d." % [("lit" if lit else "unlit")]
		
	func lit():
		return lit
		
	func use(var player, var interactable_list):
		lit = not lit
		if lit:
			return "You turn on the lamp."
		else:
			return "You turn off the lamp."

class Window:
	var name = "window"
	
	func take(var player):
		player.addItem("abstract thoughts (tried to 'take window')")
		return "You're not even sure how to get started on that."
		
	func look(var player):
		return "It's a nice day outside.\nYou can't see it though, since the window is blocked by iron 'bars'."
	
	func use(var player, var interactable_list):
		return "You can't open the window. You'd need to remove the iron bars first."

class Bars:
	var name = "bars"
	
	func take(var player):
		return "You can't take them; they're still attached to the wall."
	
	func look(var player):
		return "These bars block the window.\nThey're firmly affixed to the wall on either side of the window itself."
		
	func use(var player, var interactable_list):
		return "Without a tool of some sort, you cannot remove the iron bars."

class Floor:
	var name = "floor"
	
	func take(var player):
		player.addItem("math on your mind (tried to 'take floor')")
		return "Of what number? (What's next, 'take ceiling'?)"

	func look(var player):
		return "The floor is solid, like most good floors.\nThere's a 'purse' on the floor, and a stuffed 'teddy'."
	
	func use(var player, var interactable_list):
		return "You lay down on the floor. That didn't help much."

class Purse:
	var name = "purse"
	
	func take(var player):
		player.addItem(name)
		player.addItem("no moral compass (that purse wasn't yours!)")
		return "You pick up the purse."
	
	func look(var player):
		return "It's a cheap pleather purse, that definitely isn't yours.\nInside, you see 'cash', 'keys', and 'sanitizer'."

	func use(var player, var interactable_list):
		return "You zip and unzip the purse a few times.\nYou didn't accomplish anything, but that made a satisfying sound."

class Cash:
	var name = "cash"
	
	func take(var player):
		player.addItem(name)
		player.addItem("the sin of greed")
		return "Greedily, you pull out the money."
	
	func look(var player):
		return "It's about a grand in raw cash.\nYou can't help but wonder why this cash was in such a cheap purse.\nClearly the owner didn't care for clout."
	
	func use(var player, var interactable_list):
		return "You'll have to find a vending machine, merchant, or ATM first."

class Keys:
	var name = "keys"
	
	func take(var player):
		player.addItem("keys")
		return "You take out the car keys. Now, to find the car!"
		
	func look(var player):
		return "The keys are on a cute frog keychain. They look like car keys."
		
	func use(var player, var interactable_list):
		return "You'll have to find and 'take car' first."

class Sanitizer:
	var name = "sanitizer"
	
	func take(var player):
		player.addItem("sanitizer")
		return "You've acquired a bottle of hand sanitizer."
	
	func look(var player):
		return "It's a half-empty bottle of hand sanitizer.\n(or half-full, depending on the perspective)"
	
	func use(var player, var interactable_list):
		player.addItem("clean hands")
		return "You sanitize your hands."

class Teddy:
	var name = "teddy"
	
	func take(var player):
		player.addItem("a teddy bear named Mr. Snuffleguts")
		return "You pick up Mr. Snuffleguts."
		
	func look(var player):
		return "It's a teddy bear named Mr. Snuffleguts."
		
	func use(var player, var interactable_list):
		return "You hug the bear tightly."

class Door:
	var name = "door"
	
	func take(var player):
		player.addItem("no common sense (tried to 'take door')")
		return "It's too firmly attached to the wall to remove."
	
	func look(var player):
		return "The door is made of metal. Are doors usually chained up like this?"
	
	func use(var player, var interactable_list):
		return "Try as you might, the door refuses to open.\nThe chains might have something to do with that."

class Closet:
	var name = "closet"
	
	func take(var player):
		player.addItem("no sense of scale (tried to 'take closet')")
		return "That won't fit in your bag."
		
	func look(var player):
		return "It's too dark inside the closet to see anything useful."
		
	func use(var player, var interactable_list):
		return "You take off your clothes and place them in the closet. (just kidding!)"

class Eyes:
	var name = "eyes"
	
	func take(var player):
		player.addItem("a functional human body")
		return "You already have that.\nYou've had them since you were born."
	
	func look(var player):
		return "That's going to be really difficult without a mirror."
		
	func use(var player, var interactable_list):
		return "That would be a good idea, yes. You'd best get on with it, then."

var interactable_list
var action_list

func _ready():
	reset()
	action_list = [
		"take", 
		"use",
		"look"
	]
	
func reset():
	interactable_list = [
		Bed.new(),
		Bedsheet.new(),
		
		Table.new(),
		Clock.new(),
		Lamp.new(),
		Bottle.new(),
		
		Closet.new(),
		Door.new(),
		
		Window.new(),
		Bars.new(),
		
		Floor.new(),
		Purse.new(),
		Sanitizer.new(),
		Keys.new(),
		Cash.new(),
		Teddy.new(),
		
		Eyes.new()
	]

func is_lamp_lit():
	return _get_interactable("lamp").lit()

func _get_interactable(var name):
	for interactable in interactable_list:
		if name == interactable.name:
			return interactable;
	return null

func is_an_interactable(var txt):
	return _get_interactable(txt) != null

func is_an_action(var txt):
	for action in action_list:
		if txt == action:
			return true
	return false

func interact(var action, var object, var player):
	var interactable = _get_interactable(object)
	
	if action == "take":
		if player.hasItem(interactable.name):
			return "You're already carrying this."
		return interactable.take(player)
	elif action == "look":
		return interactable.look(player)
	elif action == "use":
		return interactable.use(player, interactable_list)
