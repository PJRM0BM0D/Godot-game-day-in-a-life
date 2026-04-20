extends Camera2D

var xpos = position.x
var ypos = position.y
var defaultpos = Vector2(position.x, position.y)


var lerp_speed = float(4.0)
var offx = 0
var offy = 0
var xspeed = 3
var yspeed = 3

@onready var playernode = get_node("..")

var look_ahead_x = 32 # The number of pixels to look ahead
var look_ahead_y = 0 # 90 # The number of pixels to look ahead

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Calculate the position to move the camera to
	
	
#	var target_pos = defaultpos + Vector2(look_ahead, 0)
	#x offset code
	if playernode.velocity.x/xspeed < look_ahead_x and playernode.velocity.x/xspeed > -(look_ahead_x):
		offx = playernode.velocity.x/xspeed
	
	elif playernode.velocity.x/xspeed > look_ahead_x :
			offx = look_ahead_x
	elif  playernode.velocity.x/xspeed < -(look_ahead_x):
			offx = -(look_ahead_x)
	
	#y offset code
	if playernode.velocity.y/yspeed < look_ahead_y and playernode.velocity.y/yspeed > -(look_ahead_y):
		offy = playernode.velocity.y/yspeed
	
	elif playernode.velocity.y/yspeed > look_ahead_y :
			offy = look_ahead_y
	elif playernode.velocity.y/yspeed < -(look_ahead_y):
			offy = -(look_ahead_y)
		
	offset = offset.lerp(Vector2(offx,offy), delta * lerp_speed)
	#print(offx," " ,offy )
	#print(playernode.velocity.x, " ", playernode.velocity.y)
