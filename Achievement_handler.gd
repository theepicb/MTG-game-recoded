extends Node2D
# need to keep track of what each number is for each achievement

# an array to store already earned achievements
var achievements_earnt = []

# counts amount of clicks for getting upgrades through clicking
func clickerCounter () :
	# check to stop getting same achievement twice 
	if achievements_earnt.has(0) == false: 
		if Global._clicksTotal == 10:
			# adds value to check
			achievements_earnt.push_front(0)
			Global._upgradesUnlocked.push_back(float(0))
			$"../upgrades".changeText("upgrades*")
			showach(0)
			pass
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# checks to see if youve earnt enough xp to level up
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
# achievement messages, should make this a dictionary, fuck i love dictionaries
var achievemes = ["achievement: you've clicked 10 times, your journey begins", "you leveled up to level " + str(Global._level) + "!"]

# function to draw little pop up message when earnt achievement
func showach(i):
	var message = Button.new()
	message.size.x = get_viewport_rect().size.x
	message.size.y = 50
	message.position.x = get_viewport_rect().size.x / 2 - message.size.x / 2 
	message.position.y = get_viewport_rect().size.y
	message.text = str(achievemes[i])
	add_child(message)
	# message pop up then fade, unsure if this deletes child after or not... INSANE MEMORY LEAK (not click bait) (gone wrong) (gone sexual)
	var y = 0
	while y < 33:
		message.position.y = message.position.y - 3

		y = y + 1
		await get_tree().create_timer(.003).timeout
		pass
	y = 1
	await get_tree().create_timer(2).timeout
	while y > 0:
		message.self_modulate.a = y

		await get_tree().create_timer(.02).timeout
		y = y - .02
		pass
	message.self_modulate.a = 0

	for child in $".".get_children():
		child.queue_free()
		pass
	pass
