extends Control
var original_y = position.y
var screen_height
@export var shown = false
@export var animation_player: AnimationPlayer

const MENU_EASING = preload("res://ui/menu_easing.tres")

func _ready():
	screen_height = get_tree().get_root().size.y
	if not shown:
		animation_player.play("hide")
		animation_player.seek(1.0)

func _process(delta):
	if shown:
		if animation_player.current_animation != "show":
			animation_player.play("show")
	else:
		if animation_player.current_animation != "hide":
			animation_player.play("hide")

func show_menu():
	shown = true
	
func hide_menu():
	shown = false


func _on_animation_player_animation_finished(anim_name):
	animation_player.pause()
