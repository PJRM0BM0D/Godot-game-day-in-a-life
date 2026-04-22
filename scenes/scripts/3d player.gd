extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6.5
const rotsense = 2

#jump stuff
var doublejumpenabled = false
var maxdoublej = 1
var doublejumped = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_jump_up()
	
		#double jump system
	if Input.is_action_just_pressed("jump") and not is_on_floor() and doublejumpenabled:
		if doublejumped < maxdoublej:
			_jump_up()
			doublejumped +=1
	
	if is_on_floor():
		doublejumped = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("strafe left", "strafe right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	var input_rotate := Input.get_axis("rotate left","rotate right")
	if input_rotate:
		rotate_y(-(input_rotate * rotsense * delta))

	move_and_slide()

#jump code
func _jump_up():
	velocity.y = JUMP_VELOCITY
	#print("start")


func _on_double_jump_activator_body_entered(body: Node3D) -> void:
	doublejumpenabled = true
