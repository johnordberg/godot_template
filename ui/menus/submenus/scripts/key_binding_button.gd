extends Button

@export var action = "up"
@export var key = InputEventKey.new()
var key_text: String

func get_action():
	return action

func get_key():
	return key

func set_key(new_key):
	key = new_key
	
func set_key_text(new_text):
	text = new_text.as_text()

