extends CharacterBody3D

@onready var camera: Camera3D = $Camera3d
@export var speed: float = 10.0
var xz: Vector3 = Vector3.ZERO
var y_movement: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * 0.01
		camera.rotation.x = clamp(camera.rotation.x - event.relative.y * 0.01, -PI/3, PI/3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var direction = Vector3(x, 0, z).rotated(Vector3.UP, rotation.y)
	xz = xz.lerp(direction * speed, 0.2)
	if (is_on_floor()):
		y_movement.y = Input.get_action_strength("jump") * 10
	else:
		y_movement.y -= delta * 14
		
	velocity = xz + y_movement
	var target_fov: float = 110
	if x == 0 and z >= 0:
		target_fov = 100
	camera.fov = lerp(camera.fov, target_fov, 0.05)
	move_and_slide()
