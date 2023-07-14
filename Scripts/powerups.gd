extends Control


var invi_level = 0
var dash_level = 0
var amount = [200, 300, 400, 500, 600, 700]


onready var upgrade_button = get_node("BackgroundView/Pagebg/ScrollContainer/VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/TextureButton")
onready var upgrade_cost = get_node("BackgroundView/Pagebg/ScrollContainer/VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Label")
onready var upgrade_progress = get_node("BackgroundView/Pagebg/ScrollContainer/VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/TextureProgress")

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.shop_load()
	invi_level = Globals.save_shop.powerup1
	dash_level = Globals.save_shop.powerup2
	
	#$ScrollContainer/Control/VBoxContainer/Panel/Button1.text = str(amount[invi_level])
	#$ScrollContainer/Control/VBoxContainer/Panel/ProgressBar.value = invi_level
	#$ScrollContainer/Control/VBoxContainer/Panel2/Button1.text = str(amount[dash_level])
	upgrade_progress.value = dash_level
	pass # Replace with function body.

func _on_Button1_pressed():
	invi_level += 1
	if invi_level <= 4:
		#$ScrollContainer/Control/VBoxContainer/Panel/Button1.disabled = false
		#$ScrollContainer/Control/VBoxContainer/Panel/Button1.text = str(amount[invi_level])
		#$ScrollContainer/Control/VBoxContainer/Panel/ProgressBar.value = invi_level
		Globals.invi_level = invi_level
		Globals.save_shop.powerup1 = invi_level
		Globals.shop_save()
	else:
		#$ScrollContainer/Control/VBoxContainer/Panel/Button1.disabled = true
		#$ScrollContainer/Control/VBoxContainer/Panel/Button1.text = " fully Upgraded "
		pass
	
	#globals.meat - amount[level]
	#
	pass # Replace with function body.

func _on_Button2_pressed():
	dash_level += 1
	if dash_level <= 4:
		upgrade_cost.disabled = false
		#$ScrollContainer/Control/VBoxContainer/Panel2/Button1.text = str(amount[dash_level])
		#$ScrollContainer/Control/VBoxContainer/Panel2/ProgressBar.value = dash_level
		Globals.dash_level = dash_level
		Globals.save_shop.powerup2 = dash_level
		Globals.shop_save()
	else:
		#$ScrollContainer/Control/VBoxContainer/Panel2/Button1.disabled = true
		#$ScrollContainer/Control/VBoxContainer/Panel2/Button1.text = " fully Upgraded "
		pass
	
	pass # Replace with function body.



func _on_DashUpgradeButton_pressed():
	dash_level += 1
	if dash_level <= 5:
		upgrade_button.disabled = false
		upgrade_cost.text = str(amount[dash_level])
		upgrade_progress.value = dash_level
		Globals.dash_level = dash_level
		Globals.save_shop.powerup2 = dash_level
		#Globals.shop_save()
	else:
		upgrade_button.disabled = true
		upgrade_cost.text = " fully Upgraded "
		pass
		
	pass # Replace with function body.
