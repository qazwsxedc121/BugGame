extends KinematicBody2D

export(float) var move_speed = 500
export(float) var jump_impulse = 1000
export(float) var gravity = 100

var velocity : Vector2

var overlaped_area = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	# Get player input
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var jump_pressed = Input.is_action_just_pressed("jump")
	
	if axis.x < -0.1:
		$Sprite.flip_h = true
	elif axis.x > 0.1:
		$Sprite.flip_h = false
	
	velocity.x = axis.x * move_speed
	velocity.y += gravity
	
	if(jump_pressed):
		velocity.y -= jump_impulse
	
	# No delta needed, automatically included
	velocity = move_and_slide(velocity, Vector2.DOWN)
	if abs(velocity.x) > 5:
		$Sprite.play("run")
	else:
		$Sprite.play("idle")
	
	if Input.is_action_just_pressed("interact"):
		if overlaped_area.size() > 0:
			overlaped_area[0].interact()

func onAreaEnter(area):
	if -1 == overlaped_area.find(area):
		overlaped_area.append(area)

func onAreaExit(area):
	if -1 != overlaped_area.find(area):
		overlaped_area.erase(area)
