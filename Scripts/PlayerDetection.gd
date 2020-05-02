extends TemplateCharacter

const FOV_TOLERANCE = 20
const RED = Color (1, 0.25, 0.25)
const WHITE = Color (1, 1, 1)

var _Player

func _ready():
	_Player = get_node("/root").find_node("Player",true,false)

func _process(_delta):
	Player_in_FOV()


func Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (_Player.position - global_position).normalized()
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		$Torch.color = RED
	else:
		$Torch.color = WHITE
