extends Node2D

@onready var pos : Array[Marker2D] = [$"Positions/(0,0)", $"Positions/(1,0)",
$"Positions/(2,0)", $"Positions/(3,0)", $"Positions/(0,1)", $"Positions/(1,1)",
 $"Positions/(2,1)", $"Positions/(3,1)"]
@onready var hud_1 = $"new hud"
@onready var hud_2 = $"new_hud_2"
@onready var Enemy = preload("res://Scenes/enemy.tscn")
@onready var p1 = $"Player_1"
@onready var p2 = $"player_2"
var num_of_enemies =0

var isenemies = false
var p1_score:
	set(value):
		p1_score = value
		hud_1.score = p1_score

var p1_health:
	set(value):
		p1_health = value
		hud_1.health = p1_health

var p2_score:
	set(value):
		p2_score = value
		hud_2.score = p2_score

var p2_health:
	set(value):
		p2_health = value
		hud_2.health = p2_health
		
func _ready():
	
	#p1.change_health.connect()
	p1_score=0
	p2_score=0
	p1_health = p1.health
	p2_health = p2.health
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
		#print("isenemies is not false")


#func _on_enemy_despawn_area_entered(area):
	#area.parent().despawn()


func _on_enemy_despawn_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Enemy"):
		area.kill()
		decrease_enemy()

func decrease_enemy():
	num_of_enemies -=1
	print(num_of_enemies)


func _on_player_1_change_health(health):
	p1_health = health
	#print("health of p1:" + str(p1_health))


func _on_player_2_change_health(health):
	p2_health = health
