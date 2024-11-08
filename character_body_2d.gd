extends CharacterBody2D


@export var SPEED = 100
@export var JUMP_VELOCITY = -230.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $hitbox


func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY
        
    if Input.is_action_just_pressed("attack"):
        animation_player.play("attack")
        
    
        
    if is_on_floor() and not animation_player.is_playing():
        animation_player.play("idle")
        
        

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction := Input.get_axis("ui_left", "ui_right")
    if direction:
        velocity.x = direction * SPEED
        #sprite_2d.flip_h = direction - 1
        scale.x = scale.y * direction
        
        if is_on_floor() and animation_player.current_animation == "idle":
            animation_player.play("run")
    else:
        if animation_player.current_animation == "run":
            animation_player.stop()
        velocity.x = move_toward(velocity.x, 0, SPEED)
        
    if animation_player.current_animation != "attack" and not is_on_floor():
         animation_player.play("jump")
        
    if is_on_floor() and not animation_player.is_playing():
        animation_player.play("idle")

    move_and_slide()
    
    
func hit_enemies():
    
    for a in hitbox.get_overlapping_areas():
        print(a)
        a.get_parent().queue_free()
    
     
