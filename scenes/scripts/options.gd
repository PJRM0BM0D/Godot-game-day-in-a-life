extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/start_screen.tscn")


func _on_veiw_sense_slider_value_changed(value: float) -> void:
	SettingsManager.sensitivity = value
	$"CenterContainer/VBoxContainer/sense background/sense label".text = "sensitivity: "+str(int(value))
	
