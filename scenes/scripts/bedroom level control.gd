extends Node3D

signal loadstart(lscene)

var loadingscreen = preload("res://scenes/ui/loading_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_collider_body_entered(body: Node3D) -> void:
		#print("start")
	var instance = loadingscreen.instantiate()
	add_child(instance)
	var loader = get_node("loading screen")
	#var lscript = loader.get_script()
	#print(lscript)
	loadstart.connect(loader._on_load_start)
	loadstart.emit("res://scenes/2d/level test.tscn")
