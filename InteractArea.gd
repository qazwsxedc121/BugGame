extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InteractArea_body_entered(body):
	if body.has_method("onAreaEnter"):
		body.onAreaEnter(self)



func _on_InteractArea_body_exited(body):
	if body.has_method("onAreaExit"):
		body.onAreaExit(self)

func interact():
	get_parent().show_debug_ui()
