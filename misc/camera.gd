extends Camera2D

const SPEED := 128.0

@onready var celia: CharacterBody2D = %Celia


func _process(delta: float) -> void:
    # Moves to discrete height levels
    var height_level = int(celia.position.y / 32)
    global_position.y = move_toward(global_position.y, height_level * 32, SPEED * delta)

    global_position.x = celia.position.x
