extends Node

# 场景名称: 场景状态
var world_states = {}

@onready var player_status: Status = $PlayerStatus
@onready var color_rect: ColorRect = $LoadingRect


func _ready() -> void:
	color_rect.color.a = 0


func change_scene(path: String, entry_point: String) -> void:
	var tree := get_tree()
	tree.paused = true # 暂停游戏

	# 转场动画1
	var tween := create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(color_rect, "color:a", 1, 0.2)
	await tween.finished

	# 实现保持场景状态——保存离开场景的原状态
	var old_name := tree.current_scene.scene_file_path.get_file().get_basename()
	world_states[old_name] = tree.current_scene.to_dict()

	# 切换场景
	tree.change_scene_to_file(path)
	await tree.tree_changed

	# 实现保持场景状态——读取进入场景的原状态
	var new_name := tree.current_scene.scene_file_path.get_file().get_basename()

	if new_name in world_states:
		tree.current_scene.from_dict(world_states[new_name])

	for node in tree.get_nodes_in_group("entry_points"):
		if node.name == entry_point:
			tree.current_scene.update_player(node.global_position, node.direction)
			break

	tree.paused = false # 取消暂停

	# 转场动画2
	tween = create_tween()
	tween.tween_property(color_rect, "color:a", 0, 0.2)
