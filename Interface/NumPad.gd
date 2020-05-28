extends Popup

var combination = [1,3,2,4]
var guess = []

onready var press_SFX = load("res://Imported Assets/SFX/twoTone1.ogg")
onready var correct_SFX = load("res://Imported Assets/SFX/correct.ogg")
onready var incorrect_SFX = load("res://Imported Assets/SFX/wrongAnswer.ogg")

onready var display = $"VBoxContainer/DisplayContainer_Glass/Display"
onready var light = $"VBoxContainer/ButtonContainer/GridContainer_Button/StatusLight"

onready var greenLightImage = load("res://Imported Assets/GFX/Interface/PNG/dotGreen.png")
onready var redLightImage = load("res://Imported Assets/GFX/Interface/PNG/dotRed.png")

signal combination_correct

func _ready():
	connect("about_to_show",self, "reset_lock")
	connect_buttons()
	reset_lock()	

func connect_buttons():
	for child in $"VBoxContainer/ButtonContainer/GridContainer_Button".get_children():
		if child is Button:
			child.connect("pressed",self,"button_pressed", [child.text])


func button_pressed(buttonText):
	$AudioStreamPlayer.stream = press_SFX
	$AudioStreamPlayer.play()
	if buttonText == "OK":
		check_guess()
	else:
		enter(buttonText)


func check_guess():
	if guess == combination:
		$AudioStreamPlayer.stream = correct_SFX
		$AudioStreamPlayer.play()
		$"VBoxContainer/ButtonContainer/GridContainer_Button/StatusLight".texture = greenLightImage
		$Timer.start()
	else:
		$AudioStreamPlayer.stream = incorrect_SFX
		$AudioStreamPlayer.play()
		reset_lock()

func enter(buttonText):
	guess.append(int(buttonText))
	update_display()

func update_display():
	display.text = PoolStringArray(guess).join("")
	if guess.size() == combination.size():
		check_guess()

func reset_lock():
	$"VBoxContainer/ButtonContainer/GridContainer_Button/StatusLight".texture = redLightImage
	if $AudioStreamPlayer.playing:
		yield($AudioStreamPlayer, "finished")
	display.text = ""
	guess.clear()



func _on_Timer_timeout():
	emit_signal("combination_correct")
