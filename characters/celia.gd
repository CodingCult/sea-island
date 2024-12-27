extends CharacterBody2D


const SPEED := 200.0
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

    if is_on_wall_only() and jumped:
        var jump_direction := get_slide_collision(0).get_normal().x

        velocity.y = JUMP_VELOCITY
        velocity.x = jump_direction * SPEED * 0.5
        jump_wait = 0.2

    jump_wait -= delta

    var direction := Input.get_axis("left", "right")
    if direction and jump_wait <= 0:
        velocity.x = SPEED * direction

        # Auto jumps if Celia is moving horizontally
        if is_on_floor():
            # Jump higher if holding jump
            if Input.is_action_pressed("jump"):
                velocity.y = JUMP_VELOCITY
                jumped = true
            else:
                velocity.y = JUMP_VELOCITY * 0.25
    elif jump_wait <= 0:
        velocity.x = 0

    move_and_slide()
