extends Sprite2D

var shader_material = preload("res://new_shader_material.tres")

func itemPositionWithValue(key_to_check, value_to_check):
	for i in range(Global._inv.size()):
		var item = Global._inv[i]
		if item.has(key_to_check) and item[key_to_check] == value_to_check:
			return i
	return -1

func getLuck (chance):
	return randf_range(0, 100) * Global._luck >= chance

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



func openpack(x):
	$"../Clickscreen".visible = false
	$"../upgrades".visible = false
	$"../Packs_Inventory".visible = false
	$"../ShopButton".visible = false
	#$"../ColorRect".visible = false
	$"../Card_Inventory".visible = false
	var i = 0
	if x == 0:
		Global.dir_contents("res://sprites/motm-e/")
		
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
		unicard(2, i, Global._matu, 100, Global._matPrice, "mat")
		backbutton()
		pass
		
		


func goback():
	for child in $".".get_children():
		child.queue_free()
		pass
	$"../Clickscreen".visible = true
	$"../upgrades".visible = true
	$"../Packs_Inventory".visible = true
	$"../ShopButton".visible = true
	#$"../ColorRect".visible = true
	$"../Card_Inventory".visible = true
	$"../Packs_Inventory"._pressed()
	$"../Card_Grabber".deleteChild()
	pass
	
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
		
var shader_time = 0.0
func _ready():
	material = shader_material
	# Make sure the Label has a ShaderMaterial
	if material.shader == null:
		print("No ShaderMaterial assigned to the Label.")
		return

	# Set the initial value of the time parameter in the shader
	material.set_shader_parameter("time", shader_time)
	pass

func _process(delta):
	# Accumulate delta time to update shader time
	shader_time += delta
	# Update the time uniform in the shader material
	material.set_shader_parameter("time", shader_time)
	shader_material = preload("res://new_shader_material.tres")
	pass
	
func getPrice (set, num, foil, x) :
	var price = Label.new()
	if foil == true :
		price.text = "$" + (str(set[num]["foil"]))
	else:
		price.text = "$" + (str(set[num]["nf"]))
		pass
	price.position.x = 230 + (floor(x % 5) * 245) - (price.size.x)
	price.position.y = 440 + (floor(x / 5) * 350)
	add_child(price)
	pass
	

func unicard (amount, i, set, foilchance, priceset, setName) :
	for x in range(amount) :
		var foil = false
		if randf_range(1, 100) <= foilchance :
			foil = true
			pass
		var choice = set.pick_random()
		var posx = 260 + ((i % 5) * 240)
		var posy = 230 + (floor(i / 5) * 500)
		print("I" + str(i))
		$"../Card_Grabber".create_object(setName, choice, foil, posx, posy)
		await $"../HTTPRequest2".request_completed
		var card = checkItem(setName, foil, choice, priceset, setName)
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
