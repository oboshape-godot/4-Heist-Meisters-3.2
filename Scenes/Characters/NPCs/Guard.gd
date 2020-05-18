extends PlayerDetection

onready var _navigation = get_tree().get_root().find_node("Navigation2D",true,false)
onready var _destinations = get_tree().get_root().find_node("Destinations", true, false)

var motion = Vector2()
var possible_destinations = []
var path : PoolVector2Array = []
var _startDelayDone = false

export var destination_threshold = 5
export var walk_speed = .5

func _ready():
	randomize()
	possible_destinations = _destinations.get_children()
	$Timer.start()


func _physics_process(_delta):
	if _startDelayDone == true: navigate()


func navigate():
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > destination_threshold:
		move()
	else:
		update_path()

func move():
	look_at(path[0])
	motion = (path[0] - position).normalized() * MAX_SPEED * walk_speed
	var _slideVel = move_and_slide(motion)

func update_path():
	if path.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		path.remove(0)


func make_path():
	randomize()
	var new_destination = possible_destinations[randi()%possible_destinations.size()-1]
	path = _navigation.get_simple_path(position,new_destination.global_position, false)

func _on_Timer_timeout():
	_startDelayDone = true
	make_path()
