extends Node


func _ready() -> void:
	apply_config(get_config())


func apply_config(config: ConfigFile):
	var is_fullscreen: bool = config.get_value("video", "fullscreen", true)

	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1920, 1080))


func write_config(config: ConfigFile):
	config.save("user://config.ini");


func get_default_config() -> ConfigFile:
	var config = ConfigFile.new()
	var err = config.load("res://config/default_config.ini")

	assert(err == OK, "Could not load default_config.ini")

	return config


func get_config() -> ConfigFile:
	var config = ConfigFile.new()
	var err = config.load("user://config.ini")

	if err != OK:
		var default_config = get_default_config()
		write_config(default_config)
		return default_config
	
	return config
