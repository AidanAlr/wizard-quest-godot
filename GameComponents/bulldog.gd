extends Node2D

@onready var interactable: Area2D = $Sprite2D/Interactable
@onready var sprite: Sprite2D = $Sprite2D
@onready var bulldog_speech: Label = $BulldogSpeech

var bu_strong = false

func _ready() -> void:
	visible = false  # Moved inside _ready()
	interactable.interact = on_interact
	
func on_interact():
	visible = true
	
	if bu_strong:
		bulldog_speech.text = "CS622 ROCKS!"
		interactable.is_interactable = false

	bu_strong = true
	update_interaction_name("Which class is best?")

	
func update_interaction_name(new_text: String):
	interactable.interact_name = new_text
