extends Node3D

signal enableddj()

signal loadstart(lscene)

var loadingscreen = preload("res://scenes/ui/loading_screen.tscn")

var stopwatch : float = SettingsManager.time_elapsed
var dostopwatch : bool = SettingsManager.speedrun_timer

@onready var pepsi  = $pepsi
@onready var pepsignal = pepsi.collected
@onready var player = $player

var instance

var djpopup = preload("res://scenes/ui/ui_popup.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	pepsignal.connect(pepsi_collected)
	enableddj.connect(player.enable_double_jump)
	instance = djpopup.instantiate()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dostopwatch:
		stopwatch += delta
		$"CanvasLayer/speedrun timer".text = str(round(stopwatch))


func pepsi_collected():
	enableddj.emit()
	add_child(instance)


func _on_end_level_area_body_entered(body: Node3D) -> void:
		#print("start")
	print(stopwatch)
	SettingsManager.time_elapsed = stopwatch
	var instance = loadingscreen.instantiate()
	add_child(instance)
	var loader = get_node("loading screen")
	#var lscript = loader.get_script()
	#print(lscript)
	loadstart.connect(loader._on_load_start)
	loadstart.emit("res://scenes/ui/end credits.tscn")
