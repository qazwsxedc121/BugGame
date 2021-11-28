extends KinematicBody2D

export(float) var move_speed = 500
export(float) var jump_impulse = 1000
export(float) var gravity = 100

var velocity : Vector2

var overlaped_area = []
var freeze = false
var invert_dir = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bubbles/Panel.modulate = Color("00ffffff")

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		if overlaped_area.size() > 0:
			overlaped_area[0].interact()
	if freeze:
		return
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if invert_dir:
		axis.x = -axis.x
	
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


func onAreaEnter(area):
	if -1 == overlaped_area.find(area):
		overlaped_area.append(area)
	if len(overlaped_area) >= 1:
		show_hint(overlaped_area[0].get_hint())

func onAreaExit(area):
	if -1 != overlaped_area.find(area):
		overlaped_area.erase(area)
	if len(overlaped_area) < 1:
		hide_hint()

func show_hint(text):
	$Bubbles/Panel/Label.text = text
	$Bubbles/Panel/AnimationPlayer.play("show")

func hide_hint():
	$Bubbles/Panel/AnimationPlayer.play("hide")
