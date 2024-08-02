class_name UIAnimatorComponent extends Component

@export var animation_target: CanvasItem
@export var animation_curve: Curve
@export var animation_length: float
@export var origin: Marker2D
@export var destination: Marker2D

enum States {UNINITIALIZED, PLAYING, PAUSED}
enum Directions {FORWARDS, BACKWARDS}

var state = States.UNINITIALIZED
var direction = Directions.FORWARDS

var progress:float = 0
var time_counter:float = 0

var origin_coords
var destination_coords

@onready var timer = $Timer

func _ready():
	origin_coords = origin.position
	destination_coords = destination.position
	set_initial_state()

func _process(delta):
	if state == States.PLAYING:
		var direction_multiplier = -1
		if direction == Directions.FORWARDS:
			direction_multiplier = 1
		time_counter = clamp(time_counter + (delta * direction_multiplier), 0, animation_length)
	progress = time_counter / animation_length
	var difference = destination_coords - origin_coords
	animation_target.position = origin_coords + (difference * animation_curve.sample(progress))

func _get_configuration_warning() -> String:
	var warnings = ""
	if not origin:
		warnings += "Origin is not assigned, please add a Marker2D."
	if not destination:
		warnings += "Destination is not assigned, please add a Marker2D."
		
	return warnings
		
func set_initial_state():
	if state == States.UNINITIALIZED:
		animation_target.position = origin_coords
		state = States.PAUSED
	else:
		print("already initialized")

func animate_in():
	if state == States.PAUSED:
		state = States.PLAYING
		animation_target.position = origin_coords
		direction = Directions.FORWARDS
		progress = 0
		timer.start(animation_length)
	else:
		print("already playing")
	
func animate_out():
	if state == States.PAUSED:
		state = States.PLAYING
		animation_target.position = destination_coords
		direction = Directions.BACKWARDS
		progress = 1
		timer.start(animation_length)
	else:
		print("already playing")

func _on_timer_timeout():
	timer.stop()
	if state == States.PLAYING:
		state = States.PAUSED
		if direction == Directions.FORWARDS:
			if not animation_target.position == origin_coords:
				animation_target.position = origin_coords
		elif direction == Directions.BACKWARDS:
			if not animation_target.position == destination_coords:
				animation_target.position = destination_coords
