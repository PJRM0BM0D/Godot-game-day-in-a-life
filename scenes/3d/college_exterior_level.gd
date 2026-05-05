extends Node3D

signal enableddj()

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
	pass


func pepsi_collected():
	enableddj.emit()
	add_child(instance)
