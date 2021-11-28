extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tasks = []

func refresh():
	tasks = []
	var level = get_parent().get_parent()
	tasks.append_array(level.get_enemy_unfinished())
	var panels = [
		get_parent().get_node("DebugPanelAudio"),
		get_parent().get_node("DebugPanelPlayer"),
		get_parent().get_node("DebugPanelSetting"),
	]
	for p in panels:
		tasks.append_array(p.get_unfinished())
	for n in $TaskList/VBoxContainer.get_children():
		n.queue_free()
	for t in tasks:
		var hcontainer = HBoxContainer.new()
		var l = Label.new()
		l.text = t
		hcontainer.add_child(l)
		$TaskList/VBoxContainer.add_child(hcontainer)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func debug_done():
	self.visible = false


func _on_Finish_pressed():
	if len(tasks) == 0:
		get_parent().get_parent().finish()
	else:
		alert_task_not_done()

func alert_task_not_done():
	$Warn/Count.text = "%d" % len(tasks)
	$AnimationPlayer.play("ShowAndHide")
