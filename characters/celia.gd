extends CharacterBody2D


const SPEED := 300.0
const JUMP_VELOCITY := -400.0

@onready var animated_sprite := $AnimatedSprite2D
var jumped := false
var count := 0
var jump_wait := 0.0

signal change_debug_label(text: String)

func _process(_delta):
    animated_sprite.play("default")
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

    if is_on_wall_only():
        var jump_direction := get_slide_collision(0).get_normal().x

        velocity.y = JUMP_VELOCITY * 0.75
        velocity.x = jump_direction * SPEED * 0.5
        jump_wait = 0.1

    jump_wait -= delta

    var direction := Input.get_axis("left", "right")
    if direction and jump_wait <= 0:
        velocity.x = direction * SPEED

        # Auto jumps if Celia is moving horizontally
        if is_on_floor():
            jumped = true

            # Jump higher if holding jump
            if Input.is_action_pressed("jump"):
                velocity.y = JUMP_VELOCITY
            else:
                velocity.y = JUMP_VELOCITY * 0.25
    elif jump_wait <= 0:
        velocity.x = move_toward(velocity.x, 0, SPEED) # Stops in 0s
        # velocity.x = move_toward(velocity.x, 0, delta * SPEED / 0.2) # Stops in 0.2s

    move_and_slide()
