extends Node2D

@onready var pos : Array[Marker2D] = [$"Positions/(0,0)", $"Positions/(1,0)",
$"Positions/(2,0)", $"Positions/(3,0)", $"Positions/(0,1)", $"Positions/(1,1)",
 $"Positions/(2,1)", $"Positions/(3,1)"]
@onready var hud_1 = $"new hud"
@onready var hud_2 = $"new_hud_2"
@onready var Enemy = preload("res://Scenes/enemy.tscn")
@onready var p1 = $"Player_1"
@onready var p2 = $"player_2"
@onready var GOS = $"CanvasLayer/GameOverScreen"
var enemies : Array =[]

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
	
	p1_score=0
	p2_score=0
	p1_health = p1.health
	p2_health = p2.health
	
	#enemy.dead.connect(decrease_enemy)
	#Enemy.dead.connect(decrease_enemy)
	pass
func spawn_initial_enemy():
	var enemy = Enemy.instantiate()
	enemy.position = Vector2(1000,1000)
	enemy.speed = 0
	add_child(enemy)
	#enemy.connect("dead",self, "_on_enemy_died")
	

func _process(delta):
	check_enemies()
	if isenemies == false:
		spawn_enemies()
		
	if p1_health ==0 and p2_health == 0:
		game_over()
	pass

func game_over():
	GOS.set_player1_score(p1_score)
	GOS.set_player2_score(p2_score)
	await get_tree().create_timer(0.5).timeout
	GOS.visible = true

func spawn_enemies():
	if !isenemies:
		for location in pos:
			var enemy = Enemy.instantiate()
			enemy.position = location.position
			enemies.append(enemy)
			get_parent().add_child(enemy)


func check_enemies():
	print("enemies size:" + str(enemies.size()))
	if enemies.size() > 0:
		isenemies = true
		print("is enemies:" + str(isenemies))
	else:
		isenemies = false
		print("is enemies:" + str(isenemies))
		#print("isenemies is not false")


func _on_enemy_despawn_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Enemy"):
		area.kill()
		enemies.erase(area)
		#decrease_enemy()

func on_enemy_died(enemy):
	enemies.erase(enemy)
	check_enemies()

func _on_player_1_change_health(health):
	p1_health = health
	#print("health of p1:" + str(p1_health))


func _on_player_2_change_health(health):
	p2_health = health
