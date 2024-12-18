extends Button
func _ready():
	$".".size.x = 200
	$".".size.y = 60
	$".".position.y = 120
	$".".position.x = 0
	$".".text = "shop"
	pass

var totalpacks = 2
func _pressed():
	deleteChild()
	$"../upgrades".deleteChild()
	$"../Packs_Inventory".deleteChild()
	$"../Money_Clicker".visible = false
	$"../Combo_Counter".visible = false
	$"../Inventory_handler".removeInv()
	var x = 0
	var i = 0
	while x != totalpacks:
		
		var button = Button.new()
		button.size.x = 280
		button.size.y = 550
		button.position.x = 250 + i * 300
		button.position.y =((floor(x / 4)) * 430) - 50
		add_child(button)
		if Global._packsUnlocked.has(x):
			var packsprite = Sprite2D.new()
			packsprite.set_texture(load(Global._packid[x])) 
			if x == 0:
				packsprite.scale.x = .45
				packsprite.scale.y = .45
				packsprite.position.x = 390 + i * 230
				packsprite.position.y = 180 + ((floor(x / 4)) * 230)
				var packcost = Label.new()
				packcost.position.x = 365 + i * 300
				packcost.position.y = ((floor(x / 4)) * 430) + 50
				packcost.set_text(str(Global._packscost[x]))
				packcost.add_theme_font_size_override("font_size", 20)
				add_child(packcost)
			elif x == 1:
				packsprite.scale.x = .45
				packsprite.scale.y = .45
				packsprite.position.x = 390 + i * 230
				packsprite.position.y = 180 + ((floor(x / 4)) * 230)
				var packcost = Label.new()
				packcost.position.x = 365 + i * 300
				packcost.position.y = ((floor(x / 4)) * 430) + 50
				packcost.set_text(str(Global._packscost[x]))
				packcost.add_theme_font_size_override("font_size", 20)
				add_child(packcost)
			pass
			add_child(packsprite)
			var packcost = Label.new()
			packcost.position.x = 305 + i * 300
			packcost.position.y =((floor(x / 4)) * 430) + 445
			packcost.set_text("cost per pack: $" + str(Global._packscost[x]))
			packcost.add_theme_font_size_override("font_size", 20)
			add_child(packcost)
			var packsowned = Label.new()
			packsowned.position.x = 345 + i * 300
			packsowned.position.y =((floor(x / 4)) * 430) + 470
			packsowned.set_text("owned: " + str(Global._packsinv[x]))
			packsowned.add_theme_font_size_override("font_size", 20)
			add_child(packsowned)
		else:
			var unknown = Label.new()
			unknown.position.x = 365 + i * 300
			unknown.position.y =((floor(x / 4)) * 430) + 50
			unknown.set_text("?")
			unknown.add_theme_font_size_override("font_size", 100)
			add_child(unknown)
		pass
		
		button.pressed.connect(self._button_pressed.bind(x))
		x = x + 1
		i = i + 1
		if i == 4:
			i = 0
			pass
		print(i)
			
			
		
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func deleteChild():
	for child in $".".get_children():
		child.queue_free()
		pass
	pass

func _button_pressed(x) :
	print(Global._packsUnlocked)
	print(x)
	if Global._packsUnlocked.has(x):
		if Global._money >= Global._packscost[x] :
			Global._money = Global._money - Global._packscost[x]
			Global._packsinv[x] = Global._packsinv[x] + 1
			_pressed()
		pass
	pass
