extends Node2D
@onready var interactable: Area2D = $Interactable
@onready var wizard_speech: Label = $WizardSpeech

var sword_delivered = false
var accepted_quest = false
var spoken_to = false

@onready var sword_in_hand = get_node("/root/Game/Sword2")


func _ready() -> void:
	sword_in_hand.visible = false
	interactable.interact = on_interact
	wizard_speech.text = ""  # Start with empty speech
	wizard_speech.z_index = 10  # Higher values appear on top



func on_interact():
	# Get a reference to the sword to check if it's been collected
	var sword = get_node("/root/Game/Sword")
	
	if not spoken_to:
		wizard_speech.text = "I need my sword! Please find it for me."
		spoken_to = true
		return  # Exit function to prevent multiple dialogue lines at once
	
	if spoken_to and not accepted_quest:
		accepted_quest = true
		wizard_speech.text = "Thank you for accepting! Good Luck!"
		return  # Exit function to prevent multiple dialogue lines
		
	if accepted_quest and not sword_delivered:
		if sword.collected:
			wizard_speech.text = "Thank you for delivering the sword!"
			sword_delivered = true			# Optional: Add rewards here
		else:
			wizard_speech.text = "Have you found my sword yet?"
	
	if sword_delivered:
		wizard_speech.text = "Thanks again for your help! You're a true hero"
		sword_in_hand.visible = true
		get_tree().create_timer(2.0).timeout.connect(func(): wizard_speech.text = "explore for an easter egg!")


func _process(delta):
	# Update interaction text based on current state
	var sword = get_node("/root/Game/Sword")
	
	if not spoken_to:
		update_interaction_name("talk to wizard")
	elif spoken_to and not accepted_quest:
		update_interaction_name("accept quest?")
	elif spoken_to and accepted_quest and not sword_delivered:
		if sword.collected:
			update_interaction_name("deliver sword")
		else:
			update_interaction_name("need to find sword")
	elif sword_delivered:
		update_interaction_name("")


func update_interaction_name(new_text: String):
	interactable.interact_name = new_text
