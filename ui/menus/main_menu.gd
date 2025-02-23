extends Control


func _on_play_button_pressed() -> void:
    Utils.change_stage(Utils.Stage.MAIN)


func _on_settings_button_pressed() -> void:
    Utils.change_stage(Utils.Stage.SETTINGS_MENU)


func _on_exit_button_pressed() -> void:
    get_tree().quit()
