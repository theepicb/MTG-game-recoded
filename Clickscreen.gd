extends Button
func _ready():
	size = Vector2(200, 60)
	position = Vector2(0, 0)
	pass
func _pressed():
	if $"../Inventory_handler".script_running:
		$"../Inventory_handler".stop_function = true
		pass
	$"../upgrades".deleteChild()
	$"../Packs_Inventory".deleteChild()
	$"../ShopButton".deleteChild()
	$"../Money_Clicker".visible = true
	$"../Combo_Counter".visible = true
	$"../Inventory_handler".removeInv()
	pass
