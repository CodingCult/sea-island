extends Node

enum Stage {MAIN, POND, MAIN_MENU, SETTINGS_MENU}


func change_stage(new_stage: Stage):
	var new_stage_path = _stage_dict[new_stage]
	get_tree().change_scene_to_file.bind(new_stage_path).call_deferred()
	Game.checkpoint_position = Vector2(0,0)


func change_stage_raw(new_stage: PackedScene):
	get_tree().change_scene_to_packed.bind(new_stage).call_deferred()
	Game.checkpoint_position = Vector2(0, 0)


func reload_stage():
	get_tree().reload_current_scene.call_deferred()


var _stage_dict = {
	Stage.MAIN: "res://stages/main.tscn",
	Stage.POND: "res://stages/pond.tscn",
	Stage.MAIN_MENU: "res://ui/menus/main_menu.tscn",
	Stage.SETTINGS_MENU: "res://ui/menus/settings_menu.tscn"
}
