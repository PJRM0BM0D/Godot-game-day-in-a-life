extends Control

var currentlyloading = String()
var progress = []
var newscene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentlyloading:
		ResourceLoader.load_threaded_get_status(currentlyloading,progress)
		print(progress)
		if progress[0] == 1:
			newscene = ResourceLoader.load_threaded_get(currentlyloading)
			_load_complete()
		

func _on_load_start(scene):
	ResourceLoader.load_threaded_request(scene)
	currentlyloading = scene
	


func _load_complete():
	get_tree().change_scene_to_packed(newscene)
