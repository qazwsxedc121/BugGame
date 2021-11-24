extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move_speed = 100
var gravity = 60
var velocity : Vector2
var state = ["idle", "patrol"]
var dir = "left"
var freeze = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AITimer.wait_time = 1.0
	$AITimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if freeze:
		return
	if dir == "left":
		velocity.x = 1.0 * move_speed
	else:
		velocity.x = -1.0 * move_speed
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.DOWN)
	if abs(velocity.x) > 5:
		$Sprite.play("run")
	else:
		$Sprite.play("idle")
	if velocity.x < -0.1:
		$Sprite.flip_h = false
	elif velocity.x > 0.1:
		$Sprite.flip_h = true
	

func _on_InteractArea_body_entered(body):
	if body.has_method("onAreaEnter"):
		body.onAreaEnter(self)



func _on_InteractArea_body_exited(body):
	if body.has_method("onAreaExit"):
		body.onAreaExit(self)

func interact():
	get_parent().show_enemy_debug_ui(self)


func _on_AITimer_timeout():
	if dir == "left":
		dir = "right"
	else:
		dir = "left"
