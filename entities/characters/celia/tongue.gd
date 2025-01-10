extends Area2D

var score := 0
 
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
    area_entered.connect(eat_fly)


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("attack") and not animation_player.is_playing():
        animation_player.play("attack")


func eat_fly(area: Area2D) -> void:
    score += 1
    GameUi.set_debug_text(str(score))
    area.queue_free()
