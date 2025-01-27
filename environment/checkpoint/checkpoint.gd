extends Area2D


func _on_body_entered(_body: Node2D):
    Game.checkpoint_position = self.position
