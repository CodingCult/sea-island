extends CharacterBody2D


const SPEED := 300.0
const JUMP_VELOCITY := -400.0

@onready var animated_sprite := $AnimatedSprite2D
var jumped := false
var fast_falling := false

func _process(_delta):
    animated_sprite.play("default")
    var direction := Input.get_axis("left", "right")

    # If no direction, don't flip Celia
    if direction:
        animated_sprite.flip_h = direction < 0


func _physics_process(delta):
    # Add the gravity.
    if is_on_floor():
        fast_falling = false
        jumped = false
    else:
        velocity += get_gravity() * delta
    
    # Fast fall to give player more control
    if Input.is_action_just_released("jump") and jumped:
        fast_falling = true
    
    if fast_falling:
        velocity += get_gravity() * delta * 0.75

    var direction := Input.get_axis("left", "right")
    if direction:
        velocity.x = direction * SPEED

        # Auto jumps if Celia is moving horizontally
        if is_on_floor():
            jumped = true

            # Jump higher if holding jump
            if Input.is_action_pressed("jump"):
                velocity.y = JUMP_VELOCITY
            else:
                velocity.y = JUMP_VELOCITY * 0.5
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED) # Stops in 0s
        # velocity.x = move_toward(velocity.x, 0, delta * SPEED / 0.2) # Stops in 0.2s

    move_and_slide()
