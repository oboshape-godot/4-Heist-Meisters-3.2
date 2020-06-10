extends CanvasModulate


const DARK = Color("191818")
const NIGHTVISION = Color.green

onready var audio_NV_OFF = load ("res://Imported Assets/SFX/nightvision_off.wav")
onready var audio_NV_ON = load ("res://Imported Assets/SFX/nightvision.wav")


func _ready():
	pass
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
	$AudioStreamPlayer.stream = audio_NV_OFF
	$AudioStreamPlayer.play()
	$CooldownTimer.wait_time = 3.0
	$CooldownTimer.start()
	get_tree().call_group("lights", "show")
	get_tree().call_group("labels", "hide")


func NIGHTVISION_Mode():
	color = NIGHTVISION
	$AudioStreamPlayer.stream = audio_NV_ON
	$AudioStreamPlayer.play()
	$CooldownTimer.wait_time = 0.5
	$CooldownTimer.start()
	get_tree().call_group("lights", "hide")
	get_tree().call_group("labels", "show")
