extends Control

@onready var ui_animator_component = $UiAnimatorComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_animator_component.animate_in()

func get_animator_component():
	return ui_animator_component
