extends Node2D

@onready var pos : Array[Marker2D] = [$"Positions/(0,0)", $"Positions/(1,0)",
$"Positions/(2,0)", $"Positions/(3,0)", $"Positions/(0,1)", $"Positions/(1,1)",
 $"Positions/(2,1)", $"Positions/(3,1)"]
@onready var hud = $"new hud"
@onready var Enemy = preload("res://Scenes/enemy.tscn")
var num_of_enemies =0

var isenemies = false
var score = 0:
	set(value):
		score = value
		hud.score = score

var health = 0:
	set(value):
		health = value
		hud.health = health
		
func _ready():
	var enemy = Enemy.instantiate()
	enemy.position = Vector2(1000,1000)
	enemy.speed = 0
	get_parent().add_child(enemy)
	enemy.dead.connect(decrease_enemy)
	#Enemy.dead.connect(decrease_enemy)
	pass
func _process(delta):
	if isenemies == false:
		spawn_enemies()
	check_enemies()
	pass

func spawn_enemies():
	for location in pos:
		var enemy = Enemy.instantiate()
		enemy.position = location.position
		get_parent().add_child(enemy)
	num_of_enemies = 8

func check_enemies():
	if num_of_enemies > 0:
		isenemies = true
	else:
		isenemies = false
		print("isenemies is not false")


#func _on_enemy_despawn_area_entered(area):
	#area.parent().despawn()


func _on_enemy_despawn_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Enemy"):
		area.kill()
		decrease_enemy()
	

func decrease_enemy():
	num_of_enemies -=1
	print(num_of_enemies)
