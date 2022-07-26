extends KinematicBody

export var mouse_sens = 0.5

onready var camera = $Camera

var gravity = -1
var speed = 8
var mouse_sensitivity = 0.002

var velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sens * event.relative.x
		camera.rotation_degrees.x -= mouse_sens * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)

func get_direction():
	var direction = Vector3()
	if Input.is_action_pressed("forward"):
		direction += -self.global_transform.basis.z
	if Input.is_action_pressed("backward"):
		direction += self.global_transform.basis.z
	if Input.is_action_pressed("right"):
		direction += self.global_transform.basis.x
	if Input.is_action_pressed("left"):
		direction += -self.global_transform.basis.x
	direction = direction.normalized()
	return direction

func _physics_process(delta):
	velocity.y += gravity * delta
	var direction_velocity = get_direction() * speed
	velocity.x = direction_velocity.x
	velocity.z = direction_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
