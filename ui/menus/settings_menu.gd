extends Control

@onready var sound_on_button: CheckButton = $MarginContainer/VBoxContainer/SoundToggle
@onready var fullscreen_button: CheckButton = $MarginContainer/VBoxContainer/FullscreenToggle
@onready var resolution_select: OptionButton = $MarginContainer/VBoxContainer/ResolutionSelect

func _ready() -> void:
	var config = Config.get_config()
	sound_on_button.button_pressed = config.get_value("sound", "on", false)
	fullscreen_button.button_pressed = config.get_value("video", "fullscreen", false)

	resolution_select.disabled = config.get_value("video", "fullscreen", false)

	var index = Config.resolution_dict.find_key(config.get_value("video", "resolution", Vector2i(1920, 1080))) 

	resolution_select.select(index)

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
	resolution_select.disabled = config.get_value("video", "fullscreen", false)
	Config.write_config(config)
	Config.apply_config(config)


func _on_resolution_select_item_selected(index: int) -> void:
	var config = Config.get_config()
	config.set_value("video", "resolution", Config.resolution_dict.get(index))
	Config.write_config(config)
	Config.apply_config(config)
