extends Node2D

onready var base = $base
onready var hand = $hand
var maximum= 120
var index = null
onready var tween = $tween
export var output = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and event.position.distance_to(self.global_position) < maximum and index == null:
			hand.global_position = event.position
			index = event.index
		else:
			if index == event.index: index = null
			release_joystick()
			output = Vector2.ZERO
	if event is InputEventScreenDrag:
		if event.index == index:
			var dir = event.position - self.global_position
			if dir.length() > maximum: dir = dir.normalized() * maximum 
			hand.position = dir
			output = dir / maximum

func release_joystick():
	tween.interpolate_property(hand, "position", hand.position, Vector2.ZERO, 0.2, Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
			
		