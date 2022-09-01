extends LineEdit

signal input_given;

func _ready():
	self.grab_focus();

func _process(_delta):
	if Input.is_action_pressed("ui_accept") and self.text != "":
		emit_signal("input_given", self.text);
		self.text = "";
