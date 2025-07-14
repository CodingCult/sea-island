extends Control

@onready var sound_on_button: CheckButton = $MarginContainer/VBoxContainer/SoundToggle
@onready var fullscreen_button: CheckButton = $MarginContainer/VBoxContainer/FullscreenToggle

func _ready() -> void:
	var config = Config.get_config()
	sound_on_button.button_pressed = config.get_value("sound", "on", false)
	fullscreen_button.button_pressed = config.get_value("video", "fullscreen", false)

func _on_return_button_pressed() -> void:
	Utils.change_stage(Utils.Stage.MAIN_MENU)


func _on_check_button_toggled(toggled_on: bool) -> void:
	var config = Config.get_config()
	config.set_value("sound", "on", toggled_on)
	Config.write_config(config)
	Config.apply_config(config)


func _on_check_button_2_toggled(toggled_on: bool) -> void:
	var config = Config.get_config()
	config.set_value("video", "fullscreen", toggled_on)
	Config.write_config(config)
	Config.apply_config(config)
