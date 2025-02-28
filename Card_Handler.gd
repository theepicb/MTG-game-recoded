extends Sprite2D
# checks to see if an array of dictionaries has a specific key with a specific value,
# mostly just used to check if inventory already has new items
func itemPositionWithValue(key_to_check, value_to_check):
	for i in range(Global._inv.size()):
		var item = Global._inv[i]
		if item.has(key_to_check) and item[key_to_check] == value_to_check:
			return i
	return -1

# function that outputs true or false based on chance and increased by global luck multiplier. used for foil or increased rares/mythics ect
func getLuck (chance):
	return randf_range(0, 100) * Global._luck >= chance
# data grabbed from json file, url is direct url link to png to speed up inventory generation
var url: String
var price = 0;
# kinda a bad name, more of a card data generator for inventory. pretty sure it had different inteded use
func checkItem(set, foil, choice, setName):
	var card = {
				"foil": foil,
				"id": str(set) + str(choice),
				"set": setName,
				"num": choice,
				"price": price,
				"owned": 0,
				"url": url
				}
	
	print(card.set)
	if foil == 1 :
		card.id = str(set) + str(choice) + "f"
		pass
	elif foil == 2:
		card.id = str(set) + str(choice) + "ef"
		pass
	elif foil == 3 :
		card.id = str(set) + str(choice) + "hf"
		pass
	
	
	
	return card


# yet another kinda janky way to do things, basically unicard is a way to grab any card from an array of numbers. could probably
# do the setting of (i) better but thats for another day
# call function goes await unicard((amount of cards to draw from set),(i),(foil chance in %),(price list),(3 letter set code))
# should possibly move to seperate node as will get quite big after adding more packs
func openpack(x):
	$"../Clickscreen".visible = false
	$"../upgrades".visible = false
	$"../Packs_Inventory".visible = false
	$"../ShopButton".visible = false
	$"../Card_Inventory".visible = false
	var i = 0
	if x == 0:
		
		await unicard(2, i, Global._matu, 0, "mat")
		i = 2
		if getLuck(66) :
			await unicard(1, i, Global._matr, 0, "mat")
			i = 3
		else:
			await unicard(1, i, Global._matm, 0, "mat")
			i = 3
			pass
		if getLuck(66):
			await unicard(1, i, Global._matm, 100, "mat")
		elif getLuck(66):
			await unicard(1, i, Global._matr, 100, "mat")
		else:
			await unicard(1, i, Global._matu, 100, "mat")
		
		i = 4
		if getLuck(66):
			await unicard(1, i, Global._matsm, 16, "mat")
		elif getLuck(66):
			await unicard(1, i, Global._matsr, 16, "mat")
		else:
			await unicard(1, i, Global._matsu, 16, "mat")
			pass
		pass
		pass
		Global._xp += 10
		backbutton()
		pass
	if x == 1 :
		await unicard(5, i, Global._matu, 100,  "mat")
		i = 5
		await unicard(1, i, Global._mateu, -1, "mat")
		backbutton()
		pass
		
		



# creates back button after pack contents is drawn
func backbutton ():
		var back = Button.new()
		var text = Label.new()

		var posx = get_viewport_rect().size.x
		var position_y = 950

		back.size = Vector2(140, 60)
		back.position = Vector2((posx - back.size.x) / 2, position_y)
		add_child(back)

		text.text = "back"
		text.position = Vector2((posx / 2) - 17 , position_y + 15)
		add_child(text)
		back.pressed.connect(self.goback)
		pass
		
# functionality for back button
func goback():
	for child in $".".get_children():
		child.queue_free()
		pass
	$"../Clickscreen".visible = true
	$"../upgrades".visible = true
	$"../Packs_Inventory".visible = true
	$"../ShopButton".visible = true
	$"../Card_Inventory".visible = true
	$"../Packs_Inventory"._pressed()
	$"../Card_Grabber".deleteChild()
	pass
func _ready():

	pass

func _process(delta):

	pass

# function to make label for card value
func getPrice (x) :
	var priceLabel = Label.new()
	priceLabel.text = "$" + str(price)
	priceLabel.position.x = 230 + (floor(x % 5) * 270) - (priceLabel.size.x)
	priceLabel.position.y = 400 + (floor(x / 5) * 350)
	add_child(priceLabel)
	pass
	
# function that gets and draws cards, also adds it to inventory
func unicard (amount, i, set, foilchance, setName) :
	for x in range(amount) :
		var foil = 0
		if foilchance == -1 :
			foil = 2
			pass
		elif foilchance == -2 :
			foil = 3
			pass
		elif randf_range(1, 100) <= foilchance :
			foil = 1
			pass
		var choice = set.pick_random()
		# after 5 cards moves down a y layer
		var posx = 260 + ((i % 5) * 270)
		var posy = 230 + (floor(i / 5) * 500)
		# card grab request from scryfall
		$"../Card_Grabber".create_object(setName, choice, foil, posx, posy)
		await $"../HTTPRequest2".request_completed
		# creates temp variable that will be used to add items to inventory
		var card = checkItem(setName, foil, choice, setName)
		# checks if item is aready in inventory, if it is adds 1 to amount owned (-1 means new card)
		var cardpos = itemPositionWithValue("id", card.id)
		getPrice(i)
		if cardpos == -1:
			card.owned = 1
			Global._inv.push_back(card)
			pass
		else:
			Global._inv[cardpos].owned = Global._inv[cardpos].owned + 1
			print("item in array")
			pass
		x += 1
		i += 1
		pass
	print(Global._inv)
	pass
