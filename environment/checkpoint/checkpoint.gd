extends Area2D

@onready var main_manager: Node = %MainManager

func _on_body_entered(body: Node2D) -> void:
    main_manager.change_scene_pond()
