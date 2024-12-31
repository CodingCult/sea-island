extends CharacterBody2D


const SPEED := 200.0
const JUMP_VELOCITY := -400.0

@onready var animated_sprite := $AnimatedSprite2D

var jumped := false
var jump_wait := 0.0
var last_direction := 1

func _process(_delta):
    var direction := Input.get_axis("left", "right")

    # If no direction, don't flip Celia
    if direction:
        animated_sprite.flip_h = direction < 0


func _physics_process(delta):
    # Add the gravity.
    if is_on_floor():
        jumped = false
    else:
        velocity += get_gravity() * delta
        
    jump_wait -= delta

    # If Celia hits a wall after jumping, auto wall-jump.
    if is_on_wall_only() and jumped:
        var jump_direction := get_slide_collision(0).get_normal().x

        velocity.y = JUMP_VELOCITY
        velocity.x = jump_direction * SPEED * 0.5
        jump_wait = 0.2

    var input_direction := Input.get_axis("left", "right")
    if input_direction: last_direction = input_direction
    
    # Does not use is_on_floor() for more responsive movement, due to nature of hopping
    # TODO: Handle not allowing jump after falling
    if Input.is_action_pressed("jump") and not jumped:
        velocity.x = SPEED * last_direction
        velocity.y = JUMP_VELOCITY
        jumped = true
        jump_wait = 0.2
    
    if input_direction and jump_wait <= 0:
        # Auto jumps if Celia is moving horizontally
        if is_on_floor():
            velocity.y = JUMP_VELOCITY * 0.25
        velocity.x = SPEED * input_direction
    elif jump_wait <= 0:
        velocity.x = 0
    
    move_and_slide()
