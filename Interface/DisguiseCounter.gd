extends ItemList

var disguise_icon = preload("res://Imported Assets/GFX/PNG/Tiles/tile_129.png")

func update_disguises(_itemcount):
	clear()
	for _item in range(_itemcount):
		add_icon_item(disguise_icon, false)
