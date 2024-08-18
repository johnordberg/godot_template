extends Control

@onready var ui_animator_component = $UiAnimatorComponent

signal back_to_menu

func get_animator_component():
	return ui_animator_component

func _on_quit_pressed():
	back_to_menu.emit()
