extends CharacterBody3D

var sensitivity = 0.005
@onready var head: Node3D = $"head"
@onready var player_camera: Camera3D = $head/Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 6.5
#const rotsense = 0

#jump stuff
var doublejumpenabled = false
var maxdoublej = 1
var doublejumped = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	elif event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		player_camera.rotate_x(-event.relative.y * sensitivity)
		player_camera.rotation.x = clamp(player_camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


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
	
#	var input_rotate := Input.get_axis("rotate left","rotate right")
#	if input_rotate:
#		rotate_y(-(input_rotate * rotsense * delta))

	move_and_slide()

#jump code
func _jump_up():
	velocity.y = JUMP_VELOCITY
	#print("start")


func _on_double_jump_activator_body_entered(body: Node3D) -> void:
	doublejumpenabled = true
