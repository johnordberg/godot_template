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
	
	settings_menu.init_config()
	
	settings_menu.master_volume_changed.connect(_set_master_volume)
	settings_menu.music_volume_changed.connect(_set_music_volume)
	settings_menu.game_volume_changed.connect(_set_game_volume)
	settings_menu.save_and_return_pressed.connect(_save_and_close_settings)

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
		
func _goto_main():
	if state != States.MAIN:
		var current_animator = get_animator_by_state(state)
		current_animator.animate_from_to(StartEnum.CENTER, StartEnum.RIGHT)
		main_animator.animate_from_to(StartEnum.LEFT, StartEnum.CENTER)
		state = States.MAIN
		
func get_animator_by_state(state: States):
	match state:
		States.SPLASH:
			return splash_animator
		States.MAIN:
			return main_animator
		States.SETTINGS:
			return settings_animator

func _set_master_volume(value):
	Global.master_volume = value
	
func _set_music_volume(value):
	Global.music_volume = value
	
func _set_game_volume(value):
	Global.game_volume = value
	
func _save_and_close_settings():
	settings_menu.save_config()
	_goto_main()
