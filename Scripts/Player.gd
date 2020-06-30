
extends TemplateCharacter

var motion = Vector2() # motion velocity of player
var moveInputDir = Vector2() # used to record direction inputs
var velocity_multiplier = 1
export var disguise_slowdown = 0.25

var disguise_label_position_offset : Vector2

const PLAYER_SPRITE = preload("res://Imported Assets/GFX/PNG/Hitman 1/hitman1_stand.png")
const BOX_SPRITE = preload("res://Imported Assets/GFX/PNG/Tiles/tile_129.png")

const HUMAN_LIGHT_OCCLUDER = preload("res://Scenes/Characters/human_shape_light_occluder.tres")
const CRATE_LIGHT_OCCLUDER = preload("res://Scenes/Characters/player_box_shape_occluder.tres")

enum COLLISION_LAYER { player = 1, disguised = 512 }

var is_disguised : bool = false
export var disguise_duration : float = 5.0
export var number_of_disguises = 3


func _ready():
	$Timer.wait_time = disguise_duration
	disguise_label_position_offset = $disguise_time.rect_position
	reveal()


func _process(_delta):
	update_motion(_delta)
	if is_disguised:
		$disguise_time.text = str($Timer.time_left).pad_decimals(2)
		set_disguise_Label_transform()


func _physics_process(_delta):
	var _remainder = move_and_slide(motion * velocity_multiplier)

func update_motion(_delta):
	# point towards the mouse cursor
	look_at(get_global_mouse_position())

	# get the key inputs for motion, so zero it out just in case nothings pressed
	moveInputDir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		moveInputDir.x = -1.0
	if Input.is_action_pressed("move_right"):
		moveInputDir.x = 1.0
	if Input.is_action_pressed("move_up"):
		moveInputDir.y = -1.0
	if Input.is_action_pressed("move_down"):
		moveInputDir.y = 1.0

	# if there is an input, normalise the direction muptiply speed and add to motion
	if moveInputDir != Vector2.ZERO:
		motion += SPEED * moveInputDir.normalized()
	else:
		if motion != Vector2.ZERO:
			#although not the perfect use of lerp its a slowdown
			motion = lerp(motion, Vector2.ZERO, 0.6)

	motion = motion.clamped(MAX_SPEED)

func _input(_event):
	if Input.is_action_just_pressed("toggle_vision_mode"):
		get_tree().call_group("Interface", "cycle_vision_mode")

	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()


func toggle_disguise() -> void :
	if is_disguised:
		is_disguised = false
		reveal()
	elif number_of_disguises > 0:
		is_disguised = true
		disguise()

func reveal() -> void:
	$Sprite.texture = PLAYER_SPRITE
	$Light2D.texture = PLAYER_SPRITE
	$LightOccluder2D.occluder = HUMAN_LIGHT_OCCLUDER
	collision_layer = COLLISION_LAYER.player
	
	velocity_multiplier = 1
	
	$disguise_time.hide()
	is_disguised = false


func disguise() -> void:
	$Sprite.texture = BOX_SPRITE
	$Light2D.texture = BOX_SPRITE
	$LightOccluder2D.occluder = CRATE_LIGHT_OCCLUDER
	collision_layer = COLLISION_LAYER.disguised
	
	velocity_multiplier = disguise_slowdown
	
	$Timer.start()
	$disguise_time.show()
	is_disguised = true
	number_of_disguises -= 1

func set_disguise_Label_transform():
	$disguise_time.rect_global_position = position + disguise_label_position_offset
	$disguise_time.set_rotation(-global_rotation)
