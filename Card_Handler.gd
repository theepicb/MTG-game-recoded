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

# kinda a bad name, more of a card data generator for inventory. pretty sure it had different inteded use
func checkItem(set, foil, choice, priceSet, setName):
	var card = {
				"foil": foil,
				"id": str(set) + str(choice),
				"set": setName,
				"num": choice,
				"price": 0,
				"owned": 0
				}
	if foil == true:
		card.price = priceSet[choice].foil
	else:
			card.price = priceSet[choice].nf
			pass
	print(card.set)
	if foil == true :
		card.id = str(set) + str(choice) + "f"
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
		
		await unicard(2, i, Global._matu, 0, Global._matPrice, "mat")
		i = 2
		if getLuck(66) :
			await unicard(1, i, Global._matr, 0, Global._matPrice, "mat")
			i = 3
		else:
			await unicard(1, i, Global._matm, 0, Global._matPrice, "mat")
			i = 3
			pass
		if getLuck(66):
			await unicard(1, i, Global._matm, 100, Global._matPrice, "mat")
		elif getLuck(66):
			await unicard(1, i, Global._matr, 100, Global._matPrice, "mat")
		else:
			await unicard(1, i, Global._matu, 100, Global._matPrice, "mat")
		
		i = 4
		if getLuck(66):
			await unicard(1, i, Global._matsm, 16, Global._matPrice, "mat")
		elif getLuck(66):
			await unicard(1, i, Global._matsr, 16, Global._matPrice, "mat")
		else:
			await unicard(1, i, Global._matsu, 16, Global._matPrice, "mat")
			pass
		pass
		pass
		Global._xp += 10
		backbutton()
		pass
	if x == 1 :
		await unicard(2, i, Global._matu, 100, Global._matPrice, "mat")
		backbutton()
		pass
		
		



# creates back button after pack contents is drawn
func backbutton ():
		var back = Button.new()
		var text = Label.new()

		var posx = get_viewport_rect().size.x
		var position_y = 500

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
func getPrice (set, num, foil, x) :
	var price = Label.new()
	if foil == true :
		price.text = "$" + (str(set[num]["foil"]))
	else:
		price.text = "$" + (str(set[num]["nf"]))
		pass
	price.position.x = 230 + (floor(x % 5) * 245) - (price.size.x)
	price.position.y = 400 + (floor(x / 5) * 350)
	add_child(price)
	pass
	
# function that gets and draws cards, also adds it to inventory
func unicard (amount, i, set, foilchance, priceset, setName) :
	for x in range(amount) :
		var foil = false
		if randf_range(1, 100) <= foilchance :
			foil = true
			pass
		var choice = set.pick_random()
		# after 5 cards moves down a y layer
		var posx = 260 + ((i % 5) * 240)
		var posy = 230 + (floor(i / 5) * 500)
		# card grab request from scryfall
		$"../Card_Grabber".create_object(setName, choice, foil, posx, posy)
		await $"../HTTPRequest2".request_completed
		# creates temp variable that will be used to add items to inventory
		var card = checkItem(setName, foil, choice, priceset, setName)
		# checks if item is aready in inventory, if it is adds 1 to amount owned (-1 means new card)
		var cardpos = itemPositionWithValue("id", card.id)
		getPrice(priceset, choice, foil, i)
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
