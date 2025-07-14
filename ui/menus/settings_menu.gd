extends Control


func _on_return_button_pressed() -> void:
	Utils.change_stage(Utils.Stage.MAIN_MENU)


func _on_check_button_toggled(toggled_on: bool) -> void:
	var config = Config.get_config()
	config.set_value("sound", "on", toggled_on)
	Config.write_config(config)
