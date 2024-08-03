extends Control

enum States {SPLASH, MAIN}
var state = States.SPLASH

@export var splash_screen: Control
@export var main_menu: Control

var splash_animator
var main_animator

# Called when the node enters the scene tree for the first time.
func _ready():
	splash_animator = splash_screen.get_animator_component()
	main_animator = main_menu.get_animator_component()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if state == States.SPLASH:
		if event is InputEventKey:
			if event.pressed:
				splash_animator.animate_out()
				main_animator.animate_in()
				state = States.MAIN
