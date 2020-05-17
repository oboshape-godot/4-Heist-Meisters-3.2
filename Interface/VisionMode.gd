extends CanvasModulate


const DARK = Color("191818")
const NIGHTVISION = Color.green

onready var audioNV_OFF = load ("res://Imported Assets/SFX/nightvision_off.wav")
onready var varaudioNV_ON = load ("res://Imported Assets/SFX/nightvision.wav")


func _ready():
	visible = true
	color = DARK


func cycle_vision_mode():
	if $CooldownTimer.is_stopped():
		if color == DARK:
			NIGHTVISION_Mode()
		else:
			DARK_Mode()


func DARK_Mode():
	color = DARK
	$AudioStreamPlayer.stream = audioNV_OFF
	$AudioStreamPlayer.play()
	$CooldownTimer.wait_time = 3.0
	$CooldownTimer.start()


func NIGHTVISION_Mode():
	color = NIGHTVISION
	$AudioStreamPlayer.stream = varaudioNV_ON
	$AudioStreamPlayer.play()
	$CooldownTimer.wait_time = 0.5
	$CooldownTimer.start()
