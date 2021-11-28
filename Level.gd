extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_enemy
onready var all_enemy = [
	$Enemy, $Enemy2
]

onready var timeused = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	panels["setting"].afterready()
	var i = Global.level
	while i > 0:
		gen_bugs()
		i -= 1


func finish():
	Global.score += timeused
	if Global.level < 3:
		Global.level += 1
		get_tree().change_scene("res://scenes/NextLevel.tscn")
	else:
		Global.level = 1
		get_tree().change_scene("res://scenes/Finish.tscn")

func _process(delta):
	timeused += delta
	$CanvasLayer2/TimeCount.text = "%.2f" % timeused

func gen_bugs():
	$Enemy.gen_random_bug()
	$Enemy2.gen_random_bug()
	panels["audio"].gen_random_bug()
	panels["player"].gen_random_bug()
	panels["setting"].gen_random_bug()

func get_enemy_unfinished():
	var res = []
	for i in all_enemy:
		res.append_array(i.get_unfinished())
	return res

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
onready var panels = {
	"run": $CanvasLayer/DebugPanelRun,
	"audio": $CanvasLayer/DebugPanelAudio,
	"player": $CanvasLayer/DebugPanelPlayer,
	"setting": $CanvasLayer/DebugPanelSetting,
}
onready var backgrounds = {
	"player": $BackgroundP,
	"monster": $BackgroundM,
	"background": $Background,
}

func set_light(light):
	$WorldEnvironment.environment.adjustment_brightness = light

func set_background(background_name):
	for key in backgrounds.keys():
		backgrounds[key].visible = false
	if background_name != "none":
		backgrounds[background_name].visible = true

func get_cfg_panel(configtype):
	return panels[configtype]

func show_debug_ui(configtype):
	var panel = get_cfg_panel(configtype)
	if panel.visible:
		panel.visible = false
		$Player.freeze = false
		panel.debug_done()
	else:
		if panel.has_method("refresh"):
			panel.refresh()
		panel.visible = true
		$Player.freeze = true
	
func show_enemy_debug_ui(enemy):
	if $CanvasLayer/EnemyDebugPanel.visible:
		$CanvasLayer/EnemyDebugPanel.debug_done()
		$Player.freeze = false
	else:
		$CanvasLayer/EnemyDebugPanel.set_current_debug(enemy)
		$Player.freeze = true
