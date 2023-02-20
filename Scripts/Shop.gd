extends CanvasLayer

onready var animals_panel = get_node("Shop/Ui1/Control/TabContainer/Animals/ScrollContainer/Control/HBoxContainer")
#onready var powerup_panel = get_node("Shop/Ui1/Control/TabContainer/PowerUps/ScrollContainer/VBoxContainer")
onready var display_coins = get_node("Shop/Ui1/Control/CoinsDisplay")

func _ready():
	Globals.shop_load()
	Globals.data_load()
	display_coins.text = str(Globals.save_data.total_meat)
	
	for item in range (animals_panel.get_child_count()-1):
		if Globals.store.bought[item] == true:
			animals_panel.get_node("Panel" + str(item + 1)).get_node("VBoxContainer/Button").text = 'Select'
	animals_panel.get_node("Panel" + str(Globals.store.selected + 1)).get_node("VBoxContainer/Button").text = ' selected '
	animals_panel.get_node("Panel" + str(Globals.store.selected + 1)).get_node("VBoxContainer/Button").add_to_group('selected')
	

func _selected(node, no):
	#Globals.loadstore()
	Globals.shop_load()
	for buttons in get_tree().get_nodes_in_group('selected'):
		buttons.text =  'select'
		buttons.remove_from_group('selected')
	node.text = ' selected '
	node.add_to_group('selected')
	Globals.store.selected = no
	Globals.save_shop.store = Globals.store
	Globals.shop_save()
	#Globals.savestore() 

func _buy(price, item_no):
	#Globals.loadstore()
	Globals.shop_load()
	if Globals.store.bought[item_no] == false:
		if Globals.meat >= price:
			Globals.meat -= price
			Globals.store.bought[item_no] = true
			animals_panel.get_node("Panel" + str(item_no + 1)).get_node("VBoxContainer/Button").text = 'Select'
			Globals.save_shop.store = Globals.store
			Globals.shop_save()
			#Globals.savestore()
		else:
			var rem = price - Globals.meat
	else:
		_selected(animals_panel.get_node("Panel" + str(item_no + 1)).get_node("VBoxContainer/Button"), item_no)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/UI/Menu.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/UI/Menu.tscn")
	pass # Replace with function body.

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().change_scene("res://Scenes/UI/Menu.tscn")

func _on_Button1_pressed():
	_buy(0, 0)
	pass # Replace with function body.

func _on_Button2_pressed():
	_buy(0, 1)
	pass # Replace with function body.


func _on_Button3_pressed():
	_buy(0, 2)
	pass # Replace with function body.


func _on_Button4_pressed():
	_buy(0, 3)
	pass # Replace with function body.

