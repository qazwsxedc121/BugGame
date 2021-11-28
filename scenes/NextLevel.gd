extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Time.text = "%.2f" %  Global.score
	$CanvasLayer/Control/Level.texture = load("res://art/Menu/Levels/0%d.png" % Global.level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Level.tscn")
