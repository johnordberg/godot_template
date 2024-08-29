extends Control

@onready var ui_animator_component = $UiAnimatorComponent

signal settings_pressed
signal credits_pressed
signal quit_pressed
signal new_game

func get_animator_component():
	return ui_animator_component

func _on_settings_pressed():
	settings_pressed.emit()

func _on_credits_pressed():
	credits_pressed.emit()

func _on_quit_pressed():
	quit_pressed.emit()

func _on_new_game_pressed():
	new_game.emit()
