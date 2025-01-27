extends CharacterBody2D


const SPEED := 200.0
const JUMP_VELOCITY := -400.0

@onready var animated_sprite := $AnimatedSprite2D

var jumped := false
var jump_wait := 0.0
var last_direction := 1.0


func _ready():
    Game.celia = self
    position = Game.checkpoint_position


func _process(_delta):
    var direction := Input.get_axis("left", "right")

    # If no direction, don't flip Celia
    if direction:
        animated_sprite.flip_h = direction < 0


func _physics_process(delta: float):
    jump_wait -= delta

    handle_gravity(delta)
    handle_wall_jump()
    handle_user_movement()
    handle_damage_collisions()
    
    move_and_slide()


func handle_gravity(delta: float):
    # Add the gravity.
    if is_on_floor():
        jumped = false
    else:
        velocity += get_gravity() * delta


func handle_wall_jump():
    # If Celia hits a wall after jumping, auto wall-jump.
    if is_on_wall_only() and jumped:
        var jump_direction := get_slide_collision(0).get_normal().x

        velocity.y = JUMP_VELOCITY
        velocity.x = jump_direction * SPEED * 0.5
        jump_wait = 0.2


func handle_user_movement():
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


func get_colliding_tiles(collision: KinematicCollision2D) -> Array[TileData]:
    var collider: TileMapLayer = collision.get_collider()
    var tiles: Array[TileData] = []
    var cell_coords := collision.get_position() - collision.get_normal()
    var cell_position = collider.local_to_map(cell_coords)
    tiles.push_back(collider.get_cell_tile_data(cell_position))
    
    # Handles Celia standing on two tiles
    if int(cell_coords.x) != 8 and collision.get_normal().y == -1:
        cell_position.x += 1 if int(cell_position.x) % 16 > 8 else -1
        tiles.push_back(collider.get_cell_tile_data(cell_position))
        
    return tiles


func handle_damage_collisions():
    for i in range(get_slide_collision_count()):
        var collision := get_slide_collision(i)
        var collider := collision.get_collider()
        
        if collider is TileMapLayer:
            var colliding_tiles := get_colliding_tiles(collision)
            for tile in colliding_tiles:
                if not tile:
                    continue

                if tile.get_custom_data("is_damaging"):
                    # "kills" player
                    Game.handle_player_death()
                    return
