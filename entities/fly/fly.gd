extends Area2D

const speed := 100.0

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var fly_sprite: Sprite2D = $FlySprite

var direction: Vector2


func _ready() -> void:
    change_direction()


func _physics_process(delta: float) -> void:
    position += direction * speed * delta
    if ray_cast.is_colliding():
        change_direction()


func change_direction() -> void:
    direction = Vector2(randf() - 0.5, randf() - 0.5).normalized()
    ray_cast.target_position = direction * 10 # 10px distance
    fly_sprite.rotation_degrees = rad_to_deg(direction.angle())
