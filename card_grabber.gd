extends Sprite2D

var shader_material = preload("res://new_shader_material.tres")
var shader_time = 0.0
func _process(delta):
	# Accumulate delta time to update shader time
	shader_time += delta
	# Update the time uniform in the shader material
	material.set_shader_parameter("time", shader_time)
	shader_material = preload("res://new_shader_material.tres")
	pass


func _ready ():
	material = shader_material
	material.set_shader_parameter("time", shader_time)
	$"../HTTPRequest".request_completed.connect(_on_request_completed)
	#create_object("xln", 2, true, 100, 100)
	pass

var posxy
var cardname = ""
var isfoil = false
signal script_finished
func create_object(setname, number, foil, posx, posy):
	posxy = Vector2(100, 100)
	isfoil = foil
	print("https://api.scryfall.com/cards/" + str(setname)+ "/" + str(number))
	$"../HTTPRequest".request("https://api.scryfall.com/cards/" + str(setname)+ "/" + str(number))
	
	pass

func _on_request_completed(result, response_code, headers, body):
	if headers[1] == "Content-Type: application/json; charset=utf-8" :
		var json = JSON.parse_string(body.get_string_from_utf8())
		cardname = (json["name"])
		print(json["image_uris"].small)
		$"../HTTPRequest".request(json["image_uris"].png)
	elif headers[1] == "Content-Type: image/png" :
		var tempcard = Sprite2D.new()
		var image = Image.new()
		var error = image.load_png_from_buffer(body)
		if error != OK:
			print(error);
		else:
			var texture = ImageTexture.create_from_image(image)
			tempcard.texture = texture;
			add_child(tempcard)
			tempcard.position = posxy
			tempcard.scale = Vector2(0.27, 0.27)
			tempcard.name = cardname
			print(tempcard.position)
			if isfoil == true:
				tempcard.material = shader_material
				pass
			
			pass
	pass
