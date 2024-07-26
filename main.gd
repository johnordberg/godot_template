extends Node

enum GAME_MODES {MENU, GAME}

@export var ui_container: Control
@export var game_container: Node
@export var hud_container: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	print(has_component(&"test_gameplay_component"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_component(component: StringName) -> Node:
	return get_meta(component, null)

func has_component(component: StringName) -> bool:
	return has_meta(component)
