extends Sprite2D

var shader_material = preload("res://new_shader_material.tres")

func itemPositionWithValue(key_to_check, value_to_check):
	for i in range(Global._inv.size()):
		var item = Global._inv[i]
		if item.has(key_to_check) and item[key_to_check] == value_to_check:
			return i
	return -1
	
func checkItem(set, foil, choice, priceSet, setName):
	var card = {
				"foil": foil,
				"id": str(set) + str(choice),
				"set": setName,
				"num": choice,
				"price": 0
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
	var position = itemPositionWithValue("id", str(card.id))
	$"../Inventory_handler".createCard(card, choice)
	
	pass
	
func openpack(x):
	$"../Clickscreen".visible = false
	$"../upgrades".visible = false
	$"../Packs_Inventory".visible = false
	$"../ShopButton".visible = false
	#$"../ColorRect".visible = false
	#$"../Button4".visible = false
	if x == 0:
		Global.dir_contents("res://sprites/motm-e/")
		var i = 0
		unicard(2, i, Global._matu, 100, Global._matPrice, "Matu")
		Global._xp += 10
		backbutton()
		pass
	if x == 1 :
		var i = 0
		unicard(2, i, Global._matu, 100, Global._matPrice, "Matu")
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
	#$"../Button4".visible = true
	$"../Packs_Inventory"._pressed()
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
	price.position.x = 260 + ((x % 5) * 300) - (price.size.x)
	price.position.y = 450 + (floor(x / 5) * 500)
	add_child(price)
	pass
	

func unicard (amount, i, set, foilchance, priceset, setName) :
	for x in range(amount) :
		var foil = false
		var choice = set.pick_random()
		var packsprite = Sprite2D.new()
		packsprite.texture = load(Global._imageram[choice - 1]) 
		packsprite.scale = Vector2(0.38, 0.38)
		packsprite.position.x = 290 + ((i % 5) * 300)
		packsprite.position.y = 230 + (floor(i / 5) * 500)
		if randf_range(1, 100) <= foilchance :
			foil = true
			packsprite.material = shader_material
			pass
		
		add_child(packsprite)
		checkItem(setName, foil, choice, priceset, setName)
		getPrice(priceset, choice, foil, i)
		x += 1
		i += 1
		pass
	
	pass

