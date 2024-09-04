extends Area3D

@onready var timer: Timer = $Timer

@export var swinging: bool = false;

func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D and swinging:
		timer.start()
		Engine.time_scale = 0.1
		body.apply_impulse((-(get_parent().transform.basis.z.normalized()) + Vector3(0, 1.5, 0)) * 10)


func _on_timer_timeout() -> void:
	swinging = false
	Engine.time_scale = 1
