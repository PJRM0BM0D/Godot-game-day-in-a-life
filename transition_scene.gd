extends Control

signal loadstart(lscene)

var loadingscreen = preload("res://scenes/ui/loading_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = loadingscreen.instantiate()
	add_child(instance)
	var loader = get_node("loading screen")
	#var lscript = loader.get_script()
	#print(lscript)
	loadstart.connect(loader._on_load_start)
	loadstart.emit("res://scenes/3d/college_exterior_level.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
