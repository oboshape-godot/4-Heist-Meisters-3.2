
extends TemplateCharacter

var motion = Vector2() # motion velocity of player
var moveInputDir = Vector2() # used to record direction inputs

const PLAYER_SPRITE = preload("res://Imported Assets/GFX/PNG/Hitman 1/hitman1_stand.png")
const BOX_SPRITE = preload("res://Imported Assets/GFX/PNG/Tiles/tile_129.png")

const HUMAN_LIGHT_OCCLUDER = preload("res://Scenes/Characters/human_shape_light_occluder.tres")
const CRATE_LIGHT_OCCLUDER = preload("res://Scenes/Characters/player_box_shape_occluder.tres")

enum COLLISION_LAYER { player = 1, disguised = 512 }

var is_disguised : bool = false

func _process(_delta):
	update_motion(_delta)


func _physics_process(_delta):
	var _remainder = move_and_slide(motion)

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
		reveal()
		is_disguised = false
	else:
		disguise()
		is_disguised = true

func reveal() -> void:
	$Sprite.texture = PLAYER_SPRITE
	$Light2D.texture = PLAYER_SPRITE
	$LightOccluder2D.occluder = HUMAN_LIGHT_OCCLUDER
	collision_layer = COLLISION_LAYER.player
	

func disguise() -> void:
	$Sprite.texture = BOX_SPRITE
	$Light2D.texture = BOX_SPRITE
	$LightOccluder2D.occluder = CRATE_LIGHT_OCCLUDER
	collision_layer = COLLISION_LAYER.disguised
