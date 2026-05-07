extends Node3D

signal loadstart(lscene)

var loadingscreen = preload("res://scenes/ui/loading_screen.tscn")


var stopwatch : float = SettingsManager.time_elapsed
var dostopwatch : bool = SettingsManager.speedrun_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dostopwatch:
		stopwatch += delta
		$"CanvasLayer/speedrun timer".text = str(round(stopwatch))


func _on_exit_collider_body_entered(body: Node3D) -> void:
		#print("start")
	print(stopwatch)
	SettingsManager.time_elapsed = stopwatch
	var instance = loadingscreen.instantiate()
	add_child(instance)
	var loader = get_node("loading screen")
	#var lscript = loader.get_script()
	#print(lscript)
	loadstart.connect(loader._on_load_start)
	loadstart.emit("res://scenes/2d/level test.tscn")
