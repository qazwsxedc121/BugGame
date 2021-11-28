extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var defaultTemplate = {
	"BGM Volume": ["zero", "low", "normal", "high"],
	"BGM Speed": ["0", "0.5", "1", "2"],
}
var valueMap = {
	"BGM Volume": [-80, -20, 0, 10],
	"BGM Speed": [0, 0.5, 1, 3]
}
var options = {
	"BGM Volume": null,
	"BGM Speed": null,
}
var rightState = {
	"BGM Volume": 2,
	"BGM Speed": 2
}
var now_state = {
	"BGM Volume": 0,
	"BGM Speed": 0,
}

func get_unfinished():
	var res = []
	for key in now_state.keys():
		if now_state[key] != rightState[key]:
			res.append("%s is not correct!(Audio)" % key)
	return res
	

var current_debug = null

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
	for key in rightState.keys():
		setcfg(key, rightState[key])
		options[key].select(rightState[key])

func gen_random_bug():
	var categorys = now_state.keys()
	var category = categorys[randi() % len(categorys)]
	var x = randi() % len(defaultTemplate[category])
	while x == now_state[category]:
		x = randi() % len(defaultTemplate[category])
	setcfg(category, x)
	options[category].select(x)

func debug_done():
	for k in options.keys():
		var cfgspeed = options[k].selected;
		setcfg(k, cfgspeed)
	self.visible = false

func setcfg(k, selected):
	now_state[k] = selected
	if k == "BGM Volume":
		$BGM.volume_db = valueMap[k][selected]
	elif k == "BGM Speed":
		$BGM.pitch_scale = valueMap[k][selected]
		if selected != 0:
			$BGM.play()
		else:
			$BGM.stop()
	print(now_state)

