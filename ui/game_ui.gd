extends CanvasLayer

@onready var debug_text: Label = $DebugText


func set_debug_text(text: String):
    debug_text.text = text
