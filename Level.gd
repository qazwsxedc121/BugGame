extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func show_debug_ui():
	$CanvasLayer/DebugPanel1.visible = !$CanvasLayer/DebugPanel1.visible
	
func show_enemy_debug_ui(enemy):
	if $CanvasLayer/EnemyDebugPanel.visible:
		$CanvasLayer/EnemyDebugPanel.debug_done()
	else:
		$CanvasLayer/EnemyDebugPanel.set_current_debug(enemy)
