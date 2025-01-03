extends Label

var frames := 0


func _process(_delta: float) -> void:
    frames += 1


func _on_fps_update_timeout() -> void:
    text = "FPS: " + str(frames)
    frames = 0
