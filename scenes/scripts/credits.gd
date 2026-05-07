extends Control

var stopwatch : float = SettingsManager.time_elapsed
var dostopwatch : bool = SettingsManager.speedrun_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"speedrun timer".text = "Your Final time was "+str(round(stopwatch)) + " seconds"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/start_screen.tscn")
