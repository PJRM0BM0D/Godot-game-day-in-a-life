extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"CenterContainer/VBoxContainer/speedrun timer button/speedrun icon".hide()
	$"CenterContainer/VBoxContainer/normalise diagonals button/diagonals icon".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/start_screen.tscn")


func _on_veiw_sense_slider_value_changed(value: float) -> void:
	SettingsManager.sensitivity = value
	$"CenterContainer/VBoxContainer/sense background/sense label".text = "sensitivity: "+str(int(value))
	print("sensitivity: "+str(int(value)))
	



func _on_speedrun_timer_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		SettingsManager.speedrun_timer = true
		$"CenterContainer/VBoxContainer/speedrun timer button/speedrun icon".show()
	if toggled_on == false:
		SettingsManager.speedrun_timer = false
		$"CenterContainer/VBoxContainer/speedrun timer button/speedrun icon".hide()
	print("speedrun timer : " + str(toggled_on))


func _on_normalise_diagonals_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		SettingsManager.normalise_diagonals = false
		$"CenterContainer/VBoxContainer/normalise diagonals button/diagonals icon".show()
	if toggled_on == false:
		SettingsManager.normalise_diagonals = true
		$"CenterContainer/VBoxContainer/normalise diagonals button/diagonals icon".hide()
	print("normalise diagonals : " + str(toggled_on))
