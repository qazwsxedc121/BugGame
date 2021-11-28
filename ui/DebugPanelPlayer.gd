extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var defaultTemplate = {
	"Player Direction": ["invert", "normal"],
	"Player Speed": ["slow", "medium", "fast"],
	"Player Jump": ["disable", "low", "normal", "high"],
}
var valueMap = {
	"Player Direction": [true, false],
	"Player Speed": [50, 200, 600],
	"Player Jump": [0, 100, 600, 1200],
}
var options = {
	"Player Direction": null,
	"Player Speed": null,
	"Player Jump": null,
}
var rightState = {
	"Player Direction": 1,
	"Player Speed": 1,
	"Player Jump": 2,
}
var now_state = {
	"Player Direction": 1,
	"Player Speed": 1,
	"Player Jump": 2,
}

var current_debug = null

func _ready():
	current_debug = get_parent().get_parent().get_node("Player")
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


func get_unfinished():
	var res = []
	for key in now_state.keys():
		if now_state[key] != rightState[key]:
			res.append("%s is not correct!(Player)" % key)
	return res

func gen_random_bug():
	var categorys = now_state.keys()
	var category = categorys[randi() % len(categorys)]
	var x = randi() % len(defaultTemplate[category])
	while x == rightState[category]:
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
	if k == "Player Direction":
		current_debug.invert_dir = valueMap[k][selected]
	elif k == "Player Speed":
		current_debug.move_speed = valueMap[k][selected]
	elif k == "Player Jump":
		current_debug.jump_impulse = valueMap[k][selected]
	print(now_state)

