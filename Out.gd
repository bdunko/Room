extends RichTextLabel

class Line:
	enum TextColor {DEFAULT, RED, BLUE}
	
	var text; #the line's text
	var color; #whether this line should be printed in red
	
	#constructor
	func _init(var text, var color = TextColor.DEFAULT):
		self.text = text;
		self.color = color;

#array of Line objects
var lines;
var active_line_number;

#HTML color codes for text colors
const active_color = "#FFFFFF";
const inactive_color = "#7E7E7E";
const red_color = "#FF0000";
const blue_color = "#ADD8E6";

# Called when the node enters the scene tree for the first time.
func _ready():
	clear();
	
func clear():
	lines = [];

# Called each frame. Update the text display.
func _process(delta):
	self.bbcode_text = "";
	for i in range(0, len(lines)):
		self.bbcode_text += _addColorBBCode(lines[i].text, _getTextColor(i, lines[i]));

func _getTextColor(line_num, line):
	if line.color == Line.TextColor.RED:
		return red_color;
	elif line.color == Line.TextColor.BLUE:
		return blue_color;
		
	return (active_color if line_num == active_line_number else inactive_color);

func _addColorBBCode(text, color):
	return ("[color=%s]%s[/color]\n" % [color, text]); 

func add(text, textColor = Line.TextColor.DEFAULT):
	lines += [Line.new(text, textColor)];\
	if textColor == Line.TextColor.DEFAULT and len(lines) != 0 :
		active_line_number = len(lines)-1
