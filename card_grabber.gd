extends Sprite2D

var thread: Thread

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
	$"../HTTPRequest2".request_completed.connect(_on_request_completed2)
	#create_object("xln", 2, true, 100, 100)
	thread = Thread.new()
	pass
var url
var posxy
var cardname = ""
var isfoil = false

func create_object(setname, number, foil, posx, posy):
	posxy = Vector2(posx, posy)
	isfoil = foil
	url = ("https://api.scryfall.com/cards/" + str(setname)+ "/" + str(number))
	$"../HTTPRequest".request(url)
	
	pass

func _on_request_completed(result, response_code, headers, body):
	if headers[1] == "Content-Type: application/json; charset=utf-8" :
		var json = JSON.parse_string(body.get_string_from_utf8())
		cardname = (json["name"])
		print(json["image_uris"].png)
		$"../HTTPRequest2".request(json["image_uris"].png)
			
	pass
	
func _on_request_completed2(result, response_code, headers, body):
	var tempcard = Sprite2D.new()
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		print(error);
	else:
		var texture = ImageTexture.create_from_image(image)
		tempcard.texture = texture;
		
		tempcard.position = posxy
		tempcard.scale = Vector2(0.27, 0.27)
		tempcard.name = cardname
		print(tempcard.position)
		if isfoil == true:
			tempcard.material = shader_material
			pass
		add_child(tempcard)
		pass
	pass
	
func deleteChild():
	for child in $".".get_children():
			child.queue_free()
	pass
