extends CharacterBody3D

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var camera: Camera3D = $Camera
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sword: Area3D = $Sword

const BASE_SPEED = 5.0
const JUMP_VELOCITY = 4.5

var speed = BASE_SPEED
var gravity = get_gravity()

func _physics_process(delta: float) -> void:
	mesh_instance.set_instance_shader_parameter("velocity", Vector3(1, 0, 0))
	# Play sword animation
	if Input.is_action_just_pressed("attack"):
		animation_player.play("sword_swing_up")
		sword.swinging = true
		
	# Check for wall running and adjust values
	if is_on_wall_only():
		gravity = Vector3(0, -5.0, 0)
		speed = 10.0
	else:
		gravity = get_gravity()
		speed = 5.0
		
	# Add the gravity.
	if not is_on_floor():
		velocity += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		transform.basis.x += transform.basis.z * (event.relative.x / 100)
		camera.transform.basis.y += camera.transform.basis.z * (-event.relative.y /300)
		transform.basis = transform.basis.orthonormalized()


func _on_area_3d_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()
