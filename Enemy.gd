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
export var idx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AITimer.wait_time = 1.0
	$AITimer.start()

var right_state = {
	"Speed": 1,
	"Scale": 1,
}
var now_state = {
	"Speed": 1,
	"Scale": 1,
}

func get_hint():
	return "c: debug"

func gen_random_bug():
	var categorys = now_state.keys()
	var category = categorys[randi() % len(categorys)]
	var x = randi() % 3
	while x == right_state[category]:
		x = randi() % 3
	setcfg(category, x)

func get_unfinished():
	var res = []
	for key in now_state.keys():
		if now_state[key] != right_state[key]:
			res.append("%s is not correct!(Monster%d)" % [key, idx])
	return res

func setcfg(t, cfg):
	now_state[t] = cfg
	if t == "Speed":
		if cfg == 0:
			move_speed = 0
		elif cfg == 1:
			move_speed = 100
		elif cfg == 2:
			move_speed = 300
	elif t == "Scale":
		if cfg == 0:
			$Sprite.scale = Vector2(0.5, 0.5)
		elif cfg == 1:
			$Sprite.scale = Vector2(1.0, 1.0)
		elif cfg == 2:
			$Sprite.scale = Vector2(3.0, 3.0)

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
