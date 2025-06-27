extends Node2D

@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var geometry: TileMapLayer = $Node/Geometry


func _ready() -> void:
	var used := geometry.get_used_rect().grow(-5)
	var tile_size := geometry.tile_set.tile_size

	camera_2d.limit_top = used.position.y * tile_size.y
	camera_2d.limit_bottom = used.end.y * tile_size.y
	camera_2d.limit_left = used.position.x * tile_size.x
	camera_2d.limit_right = used.end.x * tile_size.x
