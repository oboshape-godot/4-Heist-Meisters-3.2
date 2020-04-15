extends "res://Scripts/TemplateCharacter.gd"

var motion = Vector2() # motion velocity of player
var moveInputDir = Vector2() # used to record direction inputs


func _process(_delta):
	update_motion(_delta)
	

func _physics_process(_delta):
	move_and_slide(motion)
	
	
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
			motion = lerp(motion, Vector2.ZERO, 0.1)
	
	motion = motion.clamped(MAX_SPEED)


func _input(_event):
	if Input.is_action_just_pressed("torch_toggle"):
		$Torch.enabled = !$Torch.enabled
