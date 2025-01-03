extends Area2D


func _on_body_entered(_body: Node2D) -> void:
    Utils.change_stage(Utils.Stage.POND)
