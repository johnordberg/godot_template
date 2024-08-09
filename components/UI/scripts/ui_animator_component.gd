class_name UIAnimatorComponent extends Component

@export var animation_target: CanvasItem
@export var animation_curve: Curve
@export var animation_length: float

@export var origin: Marker2D
@export var destination: Marker2D

enum StartEnum {CENTER, UP, DOWN, LEFT, RIGHT, ORIGIN, DESTINATION}
@export var startPosition: StartEnum

enum States {PLAYING, PAUSED}
var state:States = States.PAUSED

var progress:float = 0
var time_counter:float = 0

var origin_coords: Vector2
var destination_coords: Vector2
var center_coords: Vector2
var up_coords: Vector2
var down_coords: Vector2
var left_coords: Vector2
var right_coords: Vector2

var start_pos: Vector2
var end_pos: Vector2

@onready var timer = $Timer

@onready var center_marker = $CenterMarker
@onready var left_marker = $LeftMarker
@onready var right_marker = $RightMarker
@onready var up_marker = $UpMarker
@onready var down_marker = $DownMarker

func _ready():
	origin_coords = origin.position
	destination_coords = destination.position
	center_coords = center_marker.position
	left_coords = left_marker.position
	right_coords = right_marker.position
	up_coords = up_marker.position
	down_coords = down_marker.position
	
	animation_target.position = get_position_coords(startPosition)
	start_pos = get_position_coords(startPosition)
	end_pos = get_position_coords(startPosition)

func _process(delta):
	if state == States.PLAYING:
		time_counter = clamp(time_counter + (delta), 0, animation_length)
		progress = time_counter / animation_length
		var difference = end_pos - start_pos
		animation_target.position = start_pos + (difference * animation_curve.sample(progress))

func animate_from_to(from: StartEnum, to: StartEnum):
	if not state == States.PLAYING:
		animation_target.position = get_position_coords(from)
		start_pos = get_position_coords(from)
		end_pos = get_position_coords(to)
		progress = 0
		time_counter = 0
		timer.start(animation_length)
		state = States.PLAYING
	else:
		print("already playing")

func _on_timer_timeout():
	timer.stop()
	state = States.PAUSED
	if not animation_target.position == end_pos:
		animation_target.position = end_pos

func get_position_coords(pos: StartEnum):
	match pos:
		StartEnum.CENTER:
			return center_coords
		StartEnum.UP:
			return up_coords
		StartEnum.DOWN:
			return down_coords
		StartEnum.LEFT:
			return left_coords
		StartEnum.RIGHT:
			return right_coords
		StartEnum.ORIGIN:
			return origin_coords
		StartEnum.DESTINATION:
			return destination_coords
