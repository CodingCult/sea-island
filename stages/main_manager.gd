extends Node

func change_scene_pond() -> void:
    get_tree().change_scene_to_file.bind("res://stages/pond.tscn").call_deferred()
