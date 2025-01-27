extends Camera2D

const SPEED := 128.0

@onready var celia: CharacterBody2D = %Celia


func _ready():
    var start_position = Game.checkpoint_position
    var height_level = int(start_position.y / 32)
    position.x = start_position.x
    position.y = height_level * 32


func _process(delta: float) -> void:
    # Moves to discrete height levels
    var height_level = int(celia.position.y / 32)
    
    # Moves faster if farther away
    # FIX: if camera moves too fast when following, celia looks to be stuttering
    var distance_difference = abs(celia.position.y - global_position.y)
    
    var speed_constant = clamp(distance_difference / 32, 1, 2)
    
    global_position.y = move_toward(global_position.y, height_level * 32, SPEED * speed_constant * delta)

    global_position.x = celia.position.x
