extends Control

signal loadstart(lscene)

var loadingscreen = preload("res://scenes/ui/loading_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	print("start")
	var instance = loadingscreen.instantiate()
	add_child(instance)
	var loader = get_node("loading screen")
	#var lscript = loader.get_script()
	#print(lscript)
	loadstart.connect(loader._on_load_start)
	loadstart.emit("res://scenes/2d/level test.tscn")
	


func _on_options_button_pressed() -> void:
	print("options")


func _on_credits_button_pressed() -> void:
	print("credits")
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
