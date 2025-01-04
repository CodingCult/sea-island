extends Node2D

@onready var flies: Node = $Flies
@onready var fly: Area2D = $Flies/Fly

func _ready() -> void:
    # TranslationServer.set_locale("fr")
    var packed_scene = PackedScene.new()
    packed_scene.pack(fly)

    for _i in range(100):
        var new_fly = packed_scene.instantiate()
        # duplicated_node.position = Vector2(randf_range(-10, 10), 2)
        add_child(new_fly)
