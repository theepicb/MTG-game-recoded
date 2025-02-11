extends Sprite2D
# variables to stop error when spamming inventory button while inventory is still requesting
var script_running = false
var stop_function = false

# tracks what page of inventory player is on
var screen = 0

# function to load inventory from card_Inventory
func loadInv() :
	# removes inventory before redrawing on canvas
	removeInv()
	# arrays to easily set x and y positions
	var x_positions = []
	var y_positions = []
	
	#function to generate x and y positions, should probably just make this an array that generates on ready
	for i in range(Global._inv.size()):
		x_positions.push_back(360 + ((i % 6) * 220))
		y_positions.push_back(150 + (floor(i / 6) * 350))
		pass
	
	# functions to tell inventory how many cards to draw and from which starting point
	var stop_condition = Global._inv.size()
	
	# checks to see if inventory is larger than 12 items multiplied which page of inventory your on
	if (stop_condition > 12) :
		if (Global._inv.size() > 12 * (screen + 1)) :
			stop_condition = 12
		else:
			# if you are on last page gives remainder of cards left
			stop_condition = stop_condition % 12
	else:
		stop_condition = min(12 * (screen + 1), Global._inv.size())
		pass
	# main loop for generation cards grabs them off scyfall so ping is issue
	# also have issue of player spamming inventory button making weird results so have temp work around but need to revise
	for i in range(stop_condition):
		# variable to allow system to know if in for loop
		script_running = true
		
		# creates new label for price
		var price = Label.new();
		# sets position from array
		price.position = Vector2(x_positions[i] - 60,170 + y_positions[i])
		# text and style
		price.text = "$" + str(Global._inv[i + (screen * 12)].price)
		price.add_theme_font_size_override("font_size", 20)
		add_child(price)
		
		# the label that tells the player how many of that card is owned
		var countLabel = Label.new()
		# takes generated x position and offsets 40 pixels
		countLabel.position = Vector2(60 + x_positions[i], 170 + y_positions[i])
		# text and style
		countLabel.set_text("x" +  str(Global._inv[i + (screen * 12)]["owned"]))
		countLabel.add_theme_font_size_override("font_size", 20)
		add_child(countLabel)
		
		# check to break if leaves inventory or else will continue leading to weird results
		if (stop_function == true):
			script_running = false
			stop_function = false
			break
			pass
		# grabbing card from scryfall
		$"../Card_Grabber".create_object_quick(Global._inv[i + (screen * 12)]["url"],  Global._inv[i + (screen * 12)]["foil"], x_positions[i], y_positions[i])
		# waiting for grab from scryfall, causes high lag due to given 
		# ping with scryfall only fix is  async loading or parallel http requests both dont know how to use
		await $"../HTTPRequest2".request_completed
		pass
	# checks to see if inventory is bigger than 12 multiplied by what screen youre currently on
	# if so brings up "next" button, redrawn every time inventory is loaded
	if ((screen + 1) * 12 < len(Global._inv)):
		var forwardButton = Button.new()
		forwardButton.position = Vector2(120, 200)
		forwardButton.size = Vector2(50, 40)
		forwardButton.set_text("next")
		forwardButton.pressed.connect(self._button_pressed)
		add_child(forwardButton)
		pass
	
	# checks if screen is more that one if so generate back button, refreshes every time inventory is redrawn.
	if (screen > 0) :
		var backButton = Button.new()
		backButton.position = Vector2(200, 200)
		backButton.size = Vector2(50, 40)
		backButton.set_text("back")
		backButton.pressed.connect(self._back_button_pressed)
		add_child(backButton)
		pass
	# tells other scripts that this loop is no longer running
	stop_function = false
	script_running = false
	pass


# next button function, cant be drawn until inventory has loaded may bring unwanted results if inventory gets drawn async
func _button_pressed() :
	screen = screen + 1
	loadInv()
	pass

# back button function, same problem with next button if async
func _back_button_pressed () :
	screen = screen - 1 
	loadInv()
	pass

# function to remove all children of this node and of the card grabber node, also stops the 
# http requests to try and help with inventory spamming
func removeInv() :
	for child in $".".get_children():
		child.queue_free()
		pass
		$"../Card_Grabber".deleteChild()
		$"../HTTPRequest".cancel_request()
		$"../HTTPRequest2".cancel_request()
		script_running = false
		stop_function = false
	pass
