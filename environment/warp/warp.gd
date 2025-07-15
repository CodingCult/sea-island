extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	var target = get_meta("warp_target")
	if target != null:
		Utils.change_stage_raw(target)
	else:
		Utils.change_stage(Utils.Stage.POND)
