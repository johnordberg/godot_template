extends Control

var original_y = 0
var screen_height

@export var shown = false
@export var animation_length: float = .2
var animation_progress: float = 0.0

const MENU_EASING = preload("res://ui/menu_easing.tres")

func _ready():
	screen_height = get_tree().get_root().size.y
	if not shown:
		position.y = -screen_height
	else:
		position.y = 0

func _process(delta):
	if shown:
		animation_progress -= delta / animation_length
	else:
		animation_progress += delta / animation_length
	animation_progress = clamp(animation_progress, 0, 1)
	position.y = original_y - (get_curve_point(animation_progress) * screen_height)

func show_menu():
	shown = true
	
func hide_menu():
	shown = false

func get_curve_point(x_coord):
	return MENU_EASING.sample(x_coord)
