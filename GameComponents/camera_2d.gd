extends Camera2D

func _ready():
	# Get the TileMap node using the absolute path
	var tilemap_layer: TileMapLayer = get_node("/root/Game/Terrain/Background")
	set_camera_limits(tilemap_layer)

func set_camera_limits(tilemap_layer):

	var map_width_tiles = tilemap_layer.get_used_rect().size.x  # Number of tiles in width
	var map_height_tiles = tilemap_layer.get_used_rect().size.y  # Number of tiles in height
	var pos = tilemap_layer.get_used_rect().position  # Position of the TileMap
	var tile_size = 48
	
	# Calculate the size of the map in pixels
	var map_width_pixels = map_width_tiles * tile_size
	var map_height_pixels = map_height_tiles * tile_size

	# Set the camera limits based on the map size and position
	limit_left = pos.x * tile_size
	limit_top = pos.y * tile_size  
	limit_right = limit_left + map_width_pixels
	limit_bottom = limit_top + map_height_pixels

	limit_smoothed = true

	print("Camera limits set to: Left=%s, Top=%s, Right=%s, Bottom=%s" % [limit_left, limit_top, limit_right, limit_bottom])
