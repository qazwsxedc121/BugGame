extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var defaultTemplate = {
	"Speed": ["zero", "normal", "high"],
	"Scale": ["0.5", "1", "2"],
	
}
var options = {
	"Speed": null,
	"Scale": null,
}

var current_debug = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in defaultTemplate.keys():
		var hcontainer = HBoxContainer.new()
		var l = Label.new()
		l.text = key
		hcontainer.add_child(l)
		hcontainer.add_child(VSeparator.new())
		var option = OptionButton.new()
		for s in defaultTemplate[key]:
			option.add_item(s)
		hcontainer.add_child(option)
		options[key] = option
		$VBoxContainer.add_child(hcontainer)

func set_current_debug(enemy):
	self.visible = true
	for key in enemy.now_state.keys():
		options[key].select(enemy.now_state[key])
	current_debug = enemy
	current_debug.freeze = true

func debug_done():
	for k in options.keys():
		var cfgspeed = options[k].selected;
		current_debug.setcfg(k, cfgspeed)

	current_debug.freeze = false
	self.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
