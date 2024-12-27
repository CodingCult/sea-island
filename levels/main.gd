extends Node2D

@onready var celia := $Celia

func _on_checkpoint_body_entered(body: Node2D) -> void:
    if body.get_instance_id() == celia.get_instance_id():
        # TEMP: changes level, should implement checkpoint later
        get_tree().change_scene_to_file("res://levels/pond.tscn")
