extends Node2D

signal loadstart(lscene)

var loadingscreen = preload("res://scenes/ui/loading_screen.tscn")

var doreset = bool(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if doreset:
		get_tree().reload_current_scene()

func change():
	pass


func _on_level_exit_body_entered(body: Node2D) -> void:
	#print("start")
	var instance = loadingscreen.instantiate()
	add_child(instance)
	var loader = get_node("loading screen")
	#var lscript = loader.get_script()
	#print(lscript)
	loadstart.connect(loader._on_load_start)
	loadstart.emit("res://scenes/ui/transition_scene.tscn")
	

func _on_obstacle_reset() -> void:
	doreset = true
