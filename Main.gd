extends Node

var ACTION_LIMIT = 8
var ACTION_SCARE = 4
var ALARM_TIMER = 3

var CLOSE_EYES_COLOR = "#000000"
var LIT_COLOR = "#d6a940"
var UNLIT_COLOR = "#1b1a20"

class Player:
	var resetRequired;
	var inventory : Array;
	
	func _init():
		reset()
	
	func reset():
		resetRequired = false
		inventory = []
		
	func hasItem(item):
		return inventory.has(item)
		
	func addItem(item):
		inventory.push_back(item)
		
	func removeItem(item):
		inventory.erase(item)
		
	func replaceItem(itemOld, itemNew):
		removeItem(itemOld)
		addItem(itemNew)
	
	func forceReset():
		resetRequired = true
	
	func isResetRequired():
		return resetRequired
		
	func inventoryAsString():
		if len(inventory) == 0:
			return "nothing"
		
		var s = ""
		for i in range(0, len(inventory)):
			if i == 0:
				s += inventory[i]
			elif i == len(inventory)-1:
				s += ", and " + inventory[i]
			else:
				s += ", " + inventory[i]
		return s

var player;
var action_counter;
var alarm_counter;

func _ready():
	randomize();
	$In.connect("input_given", self, "_handleInput");
	_reset(true);

func _reset(first_time = false):
	$BG2.color = Color(CLOSE_EYES_COLOR)
	player = Player.new()
	$In.editable = false;
	if not first_time:
		yield(get_tree().create_timer(2.0), "timeout");
		$Out.clear();
		$Out.add("...");
		yield(get_tree().create_timer(2.0), "timeout");
	$Out.add("You open your 'eyes'.");
	$BG2.color = Color(UNLIT_COLOR)
	yield(get_tree().create_timer(1.0), "timeout");
	$Out.add("You are in a room.");
	$In.editable = true;
	action_counter = 0;
	alarm_counter = 0;
	$Scenarios.pickScenario()
	$Interactables.reset()
	

func _handleInput(input_text):
	var input = $Parser.standardize(input_text);
	var parts = input.split(" ")
	var action = input.split(" ")[0] if len(parts) > 0 else ""
	var object = input.split(" ")[1] if len(parts) > 1 else ""
	var didTimeProgress = false
	
	if input == "close eyes" or input == "close my eyes" or input == "close your eyes":
		$Out.add("You close your eyes...", $Out.Line.TextColor.DEFAULT);
		_reset();
	elif player.isResetRequired():
		$Out.add("It's too late to do anything except 'close eyes'.", $Out.Line.TextColor.BLUE)
	elif input == "help" or input == "":
		$Out.add("You could try 'look'ing around.", $Out.Line.TextColor.BLUE);
	elif input == "look":
		$Out.add("You're on a 'bed'. There's a 'table' next to the bed.\nTo your left is a 'window'. Below you is the 'floor'.\nParallel to the foot of the bed is a 'door'.\nAnd on the adjacent wall, a 'closet'.", $Out.Line.TextColor.DEFAULT)
		didTimeProgress = true
	elif input == "wait":
		$Out.add("You do absolutely nothing for a few moments.", $Out.Line.TextColor.DEFAULT)
		didTimeProgress = true
	elif input == "inventory":
		$Out.add("You're carrying %s." % player.inventoryAsString(), $Out.Line.TextColor.BLUE)
	elif $Interactables.is_an_interactable(input): #lines like 'bed' or 'closet' without actions
		$Out.add("Do what with the %s? (Try to 'look %s', 'take %s', or 'use %s')" % [input, input, input, input], $Out.Line.TextColor.BLUE)
	elif $Interactables.is_an_action(action) and $Interactables.is_an_interactable(object): #valid interactions
		$Out.add($Interactables.interact(action, object, player))
		didTimeProgress = true
	elif $Interactables.is_an_action(action) and not $Interactables.is_an_interactable(object): #illegal object
		$Out.add("I don't know what %s is." % object, $Out.Line.TextColor.BLUE);
	elif not $Interactables.is_an_action(action) and $Interactables.is_an_interactable(object): #illegal action
		$Out.add("I don't know how to %s. (try 'look', 'take', or 'use')" % action, $Out.Line.TextColor.BLUE);
	else: #invalid input
		$Out.add("I don't know what you're saying. (try 'help', 'inventory', or 'wait')", $Out.Line.TextColor.BLUE);
		if len(input.split(" ")) > 2:
			$Out.add("And keep it to TWO words or less, please.", $Out.Line.TextColor.BLUE);
		
	if didTimeProgress:
		action_counter += 1
		if player.hasItem("clock"):
			alarm_counter += 1
			if(alarm_counter == ALARM_TIMER):
				yield(get_tree().create_timer(0.25), "timeout");
				$Out.add("BZT! BZT!\nThe alarm clock is going off.", $Out.Line.TextColor.RED);
				
		if $Interactables.is_lamp_lit():
			$BG2.color = Color(LIT_COLOR)
		else:
			$BG2.color = Color(UNLIT_COLOR)
		
		if action_counter == ACTION_SCARE:
			$In.editable = false;
			yield(get_tree().create_timer(0.25), "timeout");
			$Out.add($Scenarios.getScareText(), $Out.Line.TextColor.RED);
			$In.editable = true;
		if action_counter == ACTION_LIMIT:
			yield(get_tree().create_timer(0.25), "timeout");
			$Out.add($Scenarios.getEndText(player), $Out.Line.TextColor.RED);
			player.forceReset()
			yield(get_tree().create_timer(1.0), "timeout");
			$Out.add("Instinctively, you close your eyes...", $Out.Line.TextColor.BLUE);
