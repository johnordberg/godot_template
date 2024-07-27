extends Control

enum Menu_States {INTRO, MENU, NEW, SETTINGS, CREDITS}

@onready var timer = $Timer

@export var intro_menu: Control
@export var game_menu: Control
@export var new_menu: Control
@export var settings_menu: Control
@export var credits_menu: Control
@export var animation_lag_time: float = .25

var menu_state = Menu_States.INTRO
var active_menu

func _ready():
	active_menu = intro_menu

func _unhandled_key_input(event):
	if menu_state == Menu_States.INTRO:
		change_menu(Menu_States.MENU, game_menu)

func _on_continue_button_button_up():
	pass # Replace with function body.

func _on_new_game_button_button_up():
	change_menu(Menu_States.INTRO, new_menu)

func _on_settings_button_button_up():
	change_menu(Menu_States.MENU, settings_menu)

func _on_credits_button_button_up():
	change_menu(Menu_States.MENU, credits_menu)

func _on_quit_button_button_up():
	pass # Replace with function body.

func change_menu(new_menu_state: Menu_States, menu_node):
	menu_state = new_menu_state
	active_menu.hide_menu()
	active_menu = menu_node
	if timer.is_stopped:
		timer.start(animation_lag_time)

func _on_timer_timeout():
	timer.stop()
	active_menu.show_menu()

