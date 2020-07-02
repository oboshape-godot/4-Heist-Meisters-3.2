extends NinePatchRect

var loot_count = 0;
var loot_image_briefcase = preload("res://Imported Assets/GFX/Loot/suitcase.png")
func _ready():
	hide()

func collect_loot():
	show()
	$VBoxContainer/ItemList.clear()
	loot_count += 1
	for _item in range(loot_count):
		$VBoxContainer/ItemList.add_icon_item(loot_image_briefcase)
