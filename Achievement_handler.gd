extends Node2D
var upgrades = []

var clickerCounter = func (clicks) :
	if upgrades.has(0) == false: 
		if clicks == 10:
			upgrades.push_front(0)
			Global._upgradesUnlocked.push_back(float(0))
			$CanvasLayer/upgrades.set_text.call("upgrades*")
			showach(0)
			pass
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global._xp >= Global._xpToNextLevel[Global._level] :
		Global._xp -= Global._xpToNextLevel[Global._level]
		Global._level += 1
		Global._levelUp(Global._level)
		if Global._level == 2 :
			Global._upgradesUnlocked.push_back(float(3))
			pass
		showach(1)
		pass
	pass
var achievemes = ["achievement: you've clicked 10 times, your journey begins", "you leveled up to level " + str(Global._level) + "!"]
func showach(i):
	var message = Button.new()
	message.size.x = 800
	message.size.y = 40
	message.position.x = 200
	message.position.y = get_viewport_rect().size.y
	add_child(message)
	var label = Label.new()
	label.position.x = 220
	label.position.y = get_viewport_rect().size.y + 7
	add_child(label)
	label.text = str(achievemes[i])
	var y = 0
	while y < 33:
		message.position.y = message.position.y - 3
		label.position.y = label.position.y - 3
		y = y + 1
		await get_tree().create_timer(.001).timeout
		pass
	y = 1
	await get_tree().create_timer(2).timeout
	while y > 0:
		message.self_modulate.a = y
		label.self_modulate.a = y
		await get_tree().create_timer(.02).timeout
		y = y - .02
		pass
	message.self_modulate.a = 0
	label.self_modulate.a = 0
	for child in $".".get_children():
		child.queue_free()
		pass
	pass
