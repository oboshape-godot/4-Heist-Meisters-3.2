extends TileMap

# preload and grab the reference to all the tilemaps
onready var floorTileMap : TileMap = get_node(".")
onready var furnatureMap : TileMap = get_node("../Furniture")
onready var navMap : TileMap = get_node("../NavMap")
var _wallTileID = 1

func _ready():
	# get all the wall tiles into an array
	var wallTileArray = floorTileMap.get_used_cells_by_id(_wallTileID)
	# get all the furnature tiles into an array
	var furnatureTilesArray = furnatureMap.get_used_cells()
	
	# need to get all the cells in the floor tilemap
	var tileMapCells = floorTileMap.get_used_cells()
	
#	# now remove all the wall tiles if they appear in the tileMapCells
	for item in wallTileArray:
		tileMapCells.erase(item)
	
	# now remove all the furnature locations from tilemap
	for furnatureItem in furnatureTilesArray:
		tileMapCells.erase(furnatureItem)
	
	
	# so now ive just got open floor pieces, add the nav tiles at that locations
	for tile in tileMapCells:
		navMap.set_cellv(Vector2(tile.x, tile.y),0)

