extends Control

enum StartEnum {CENTER, UP, DOWN, LEFT, RIGHT, ORIGIN, DESTINATION}
enum States {SPLASH, MAIN, SETTINGS}
var state = States.SPLASH

@export var splash_screen: Control
@export var main_menu: Control
@export var settings_menu: Control

var splash_animator
var main_animator
var settings_animator

# Called when the node enters the scene tree for the first time.
func _ready():
	splash_animator = splash_screen.get_animator_component()
	main_animator = main_menu.get_animator_component()
	settings_animator = settings_menu.get_animator_component()
	
	main_menu.settings_pressed.connect(_goto_settings)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if state == States.SPLASH:
		if event is InputEventKey:
			if event.pressed:
				splash_animator.animate_from_to(StartEnum.CENTER, StartEnum.RIGHT)
				main_animator.animate_from_to(StartEnum.LEFT, StartEnum.CENTER)
				state = States.MAIN

func _goto_settings():
	if state != States.SETTINGS:
		var current_animator = get_animator_by_state(state)
		current_animator.animate_from_to(StartEnum.CENTER, StartEnum.DOWN)
		settings_animator.animate_from_to(StartEnum.UP, StartEnum.CENTER)
		state = States.SETTINGS
		
func get_animator_by_state(state: States):
	match state:
		States.SPLASH:
			return splash_animator
		States.MAIN:
			return main_animator
		States.SETTINGS:
			return settings_animator

		
