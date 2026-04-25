extends KinematicBody2D

var speed = 400
var velocity = Vector2.ZERO
onready var right_joystick = $"../right_joystick"
onready var left_joystick = $"../left_joystick"
onready var body = $body
onready var gun = $gun
onready var body_collision = $body_collision


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var vector = left_joystick.output
	velocity = vector * speed
	var angel_diff = Vector2.RIGHT.rotated(self.rotation).angle_to(vector)
	
	if abs(angel_diff) < 0.3:
		#var acceleration = 1 - (angel_diff/0.2)
		move_and_slide(velocity)
	
	if velocity != Vector2.ZERO:
		self.rotation = lerp_angle(rotation, vector.angle(), 0.15)
	
	if right_joystick.output != Vector2.ZERO:
		gun.rotation = lerp_angle(gun.rotation, right_joystick.output.angle() - self.rotation,0.3)
	else: gun.rotation = lerp_angle(gun.rotation, 0, 0.1)
	
	body_collision.rotation = body.rotation