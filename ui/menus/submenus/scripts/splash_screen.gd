extends Control

enum StartEnum {CENTER, UP, DOWN, LEFT, RIGHT, ORIGIN, DESTINATION}
@onready var ui_animator_component = $UiAnimatorComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_animator_component.animate_from_to(StartEnum.LEFT, StartEnum.CENTER)

func get_animator_component():
	return ui_animator_component
