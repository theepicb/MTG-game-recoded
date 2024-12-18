extends Button
func _ready():
	size = Vector2(200, 60)
	position = Vector2(0, 0)
	pass
func _pressed():
	$"../upgrades".deleteChild()
	$"../Packs_Inventory".deleteChild()
	$"../ShopButton".deleteChild()
	$"../Money_Clicker".visible = true
	$"../Combo_Counter".visible = true
	#$"../Button4".removeInv()
	pass
