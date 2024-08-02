extends Node

enum GAME_MODES {MENU, GAME}

@onready var gameplay_components = %GameplayComponents
@onready var hud_container = %HUDContainer
@onready var game_container = %GameContainer
@onready var menu_container = %MenuContainer

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
