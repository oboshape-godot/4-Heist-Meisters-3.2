extends TileMap

onready var floorTileMap = get_node("../Tilemap")

func _ready():
	var usedCells = self.get_used_cells()
	# iterate through all the furnature
	for item in usedCells:
		# get the world position of tile from V2
		var pos = map_to_world(item)
		# this gets the vector2 tile reference
		var mapTile = floorTileMap.world_to_map(pos)
		# need to get a reference to the floor tile at this V2
		
		print (mapTile)
