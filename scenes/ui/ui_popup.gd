extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starttimer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func starttimer():
	$"dissapear timer".start(5)


func _on_dissapear_timer_timeout() -> void:
	queue_free()
