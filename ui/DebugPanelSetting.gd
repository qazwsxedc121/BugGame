extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var defaultTemplate = {
	"Light": ["low", "meidum", "high"],
	"Gravity": ["low", "high"],
	"Background": ["none", "background", "player", "monster"],
}
var valueMap = {
	"Light": [0.3, 1, 2],
	"Gravity": [10, 40],
	"Background": ["none", "background", "player", "monster"],
}
var options = {
	"Light": null,
	"Gravity": null,
	"Background": null,
}
var rightState = {
	"Light": 1,
	"Gravity": 1,
	"Background": 1,
}
var now_state = {
	"Light": 1,
	"Gravity": 1,
	"Background": 1,
}

var current_debug_player = null
var current_debug_level = null

func _ready():
	current_debug_player = get_parent().get_parent().get_node("Player")
	current_debug_level = get_parent().get_parent()
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

func afterready():
	for key in rightState.keys():
		setcfg(key, rightState[key])
		options[key].select(rightState[key])

func get_unfinished():
	var res = []
	for key in now_state.keys():
		if now_state[key] != rightState[key]:
			res.append("%s is not correct!(Setting)" % key)
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
	if k == "Light":
		current_debug_level.set_light(valueMap[k][selected])
	elif k == "Gravity":
		current_debug_player.gravity = valueMap[k][selected]
	elif k == "Background":
		current_debug_level.set_background(valueMap[k][selected])
	print(now_state)

