extends Button

func _ready():
	size = Vector2(200, 60)
	position = Vector2(0, 60)
	text = "upgrades"
	pass

# this could possibly be removed but i aint touching this spaghetti code in negative ways (this code works souly works off of vibes)
var i = 0

# func for when button is pushed
func _pressed():
	deleteChild()
	$"../Money_Clicker".visible = false
	$"../Combo_Counter".visible = false
	$"../ShopButton".deleteChild()
	$"../Inventory_handler".removeInv()
	$"../Packs_Inventory".deleteChild()
	if $"../Inventory_handler".script_running:
		$"../Inventory_handler".stop_function = true
		pass
	createButton()
	text = "upgrades"
	pass

# function that creates upgrade boxes when clicked, also changes screens, should probably be multiple functions but what you call
# "messy" and "hard to read" i call streamlined
# note i kinda fixed above message so let that be known
func createButton():
	# checks amount of upgrades in upgrades unlocked and makes an upgrade button for each
	# a bit of a janky way to do it, basically relates the id number of the upgrade (i) and uses that as an id for grabbing data 
	# and connecting functionality to clicking the upgrade
	var x = 0
	if float(Global._upgradesUnlocked.size()) != 0:
		while x < float(Global._upgradesUnlocked.size()):
			i = float(Global._upgradesUnlocked[x])
			var button = Button.new()
			button.pressed.connect(self._button_pressed.bind(float(x), float(i)))
			button.position = Vector2(210, 20 + x * 70)
			button.size = Vector2(700, 65)
			add_child(button)
			var label = Label.new()
			label.text = Global._upgrades[i].name
			label.position.y = 25 + x * 70
			label.position.x = 230
			add_child(label)
			var labeldes = Label.new()
			labeldes.text = str(Global._upgrades[i].des)
			labeldes.position = Vector2(230, 50 + x * 70)
			add_child(labeldes)
			var price = Label.new()
			price.text = "$" +  str(Global._upgrades[i].price)
			price.position = Vector2(800, 42 + x * 70)
			add_child(price)
			print("button made", x, i)
			x = x + 1
			pass
		pass
	pass

# function that connects each button with a specific upgrade (i) when pressed. possibly a better way to do this maybe...?
# i do not remember what x does and im scared to remove it
func _button_pressed(x, i):
	if float(Global._money) >= float(Global._upgrades[i].price):
		Global._money = float(Global._money) - float(Global._upgrades[i].price)
		if i == 0:
			Global._automoney = float(Global._automoney) + 0.01
			pass
		if i == 1:
			Global._moneyClick = float(Global._moneyClick) + 0.01
			pass
		if i == 2:
			# adds packs to being able to be purchased, need to change this to a dictionary or even change the way to get packs
			Global._packsUnlocked.push_back(0)
			pass
		if i == 3:
			Global._packsUnlocked.push_back(1)
			pass
		# redraws menu with one less upgrade possibly
		for child in $".".get_children():
			child.queue_free()
			pass
		# removes upgrade from list
		Global._upgradesUnlocked.remove_at(x)
		createButton()
		pass
	pass

# i dont remember why this is hear i just remember godot was being a bitch and i did this to try and help
func changeText(text) :
	set_text((str(text))) 
	pass
# deletes all children from this node
func deleteChild():
	for child in $".".get_children():
			child.queue_free()
	pass
