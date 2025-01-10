extends CanvasLayer

@onready var debug_text: Label = $DebugLabel


func set_debug_text(text: String):
    debug_text.text = text
