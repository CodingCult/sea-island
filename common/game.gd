extends Node

var checkpoint_position = Vector2(0,0)
var celia: CharacterBody2D = null


func handle_player_death():
    Utils.reload_stage.call_deferred()
