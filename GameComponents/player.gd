extends CharacterBody2D

@export var speed = 400
@onready var _animated_sprite = $AnimatedSprite2D
@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/InteractLabel
var target = position

func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
		
		# Check the direction of movement and flip the sprite if needed
		if velocity.x < 0:
			_animated_sprite.flip_h = true  # Flip horizontally when moving left
		else:
			_animated_sprite.flip_h = false  # Keep the sprite normal when moving right

		# Play the default animation when moving
		if velocity.length() > 0:  # Check if the character is moving
			_animated_sprite.play("run")
			
	else:
		_animated_sprite.play("idle")

#Interaction Methods
##############################
func _on_interaction_area_area_entered(area: Area2D) -> void:
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area: Area2D) -> void:
	all_interactions.erase(area)
	update_interactions()
	
func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""

	
	
	
