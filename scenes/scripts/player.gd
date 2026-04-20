extends CharacterBody2D


#move speed
const SPEED = 50.0
const MAXSPEED = 1000.0

#jump velocity. force of the jump
const JUMP_VELOCITY = -500.0

#do we have a jump input buffered
var buffered = false

#on ground. used to delay grounded state for jump buffering.
var onground = false

#can coyote jump?
var coyote = false

#are we in air
var midair = false

var doublejumpenabled = false
var maxdoublej = 1
var doublejumped = 0

#reset positions
var resetx = 600
var resety = 300

#is slamming?
var slamming = false
var slamgravitymult = 2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not slamming:
		velocity += get_gravity() * delta 
	elif not is_on_floor() and slamming:
		velocity += get_gravity() * delta * slamgravitymult
	else:
		velocity.y = 0
		
	#SET IF ON THE GROUND OR NOT
	if is_on_floor() :
		if not onground:
			#if there is a jump buffered, jump. set onground
			doublejumped = 0
			if buffered == true:
				_jump_up()
				#print('buffered jump')
				#print('jumped ')
			slamming = false
			onground = true
	else:
		onground = false
		
	#SET COYOTE
	if not is_on_floor() :
		if not midair:
			$"coyote timer".start()
			coyote = true
			midair = true
	else:
		midair = false

	# normal jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_jump_up()
		#print('jump')
	
	#jump buffering system
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		$"jump buffer timer".start(0.3)
		buffered = true
		
	#coyote jump system
	if Input.is_action_just_pressed("jump") and midair and coyote and velocity.y >= 0:
		_jump_up()
		#print('coyote jump')
		
		#double jump system
	if Input.is_action_just_pressed("jump") and midair and not coyote and doublejumpenabled:
		if doublejumped < maxdoublej:
			_jump_up()
			doublejumped +=1
	if Input.is_action_just_pressed("slam") and not onground:
		slam()
		print("test")
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x += direction * SPEED
		if (velocity.x * direction) > MAXSPEED:
			velocity.x = MAXSPEED * direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/4)
	
	if direction == 1:
		%"Player Sprite".flip_h = false
	elif direction == -1:
		%"Player Sprite".flip_h = true
	move_and_slide()
	
		
	#when releasing the jump button early
	if Input.is_action_just_released("jump"):
		#if going fast enough upwards
		if velocity.y < -100:
			#cut the upwards velocity in half
			velocity.y = velocity.y/2
			#print("end")
			
#	if velocity.y < 0:
#		print(velocity.y)
	#print(doublejumped)
	
	if Input.is_action_just_pressed("debug"):
		print("fps: ",Engine.get_frames_per_second()," y ", position.y)
	
	if slamming:
		set_collision_layer_value(2, true)
	else:
		set_collision_layer_value(2, false)
	


#jump code
func _jump_up():
	velocity.y = JUMP_VELOCITY
	#print("start")


#reset position when out of bounds
func _do_reset():
	position = Vector2(resetx,resety)
	velocity.x = 0
	velocity.y = 0


func slam():
	if not slamming:
		slamming = true
		velocity.y += 300

#if in the bounding box,reset
func _on_area_2d_body_entered(body: Node2D) -> void:
	_do_reset()
	

#jump buffer ends so clear buffered 
func _on_jump_buffer_timer_timeout() -> void:
	buffered = false
	#print('end')  

#coyote timer ends so no more jumping
func _on_coyote_timer_timeout() -> void:
	coyote = false
	#print('coyote end')


#set the position you reset to
func _set_checkpoint(x,y):
	resetx = x
	resety = y
	print(resetx)
	print(resety)


#when checkpoint entered set the checkpoint
func _on_checkpoint_body_entered(body: Node2D) -> void:
	#_set_checkpoint(0,0)
	pass



	
	#print("test")


func _on_checkpoint_entered_pos(posx: Variant, posy: Variant) -> void:
	_set_checkpoint(posx, posy)
	print("position 2 X",posx,"position 2 Y", posy)
