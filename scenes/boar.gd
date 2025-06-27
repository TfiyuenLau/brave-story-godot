class_name Boar
extends Enemy

enum State {
	IDLE,
	WALK,
	RUN,
	HURT,
	DYING,
}

const KNOCKBACK_AMOUNT := 512.0

var pending_damage: Damage

@onready var walk_checker: RayCast2D = $Graphics/WalkChecker
@onready var floor_checker: RayCast2D = $Graphics/FloorChecker
@onready var player_checker: RayCast2D = $Graphics/PlayerChecker
@onready var calm_down_timer: Timer = $CalmDownTimer


func tick_physics(state: State, delta: float) -> void:
	match state:
		State.IDLE, State.HURT, State.DYING:
			move(0.0, delta)

		State.WALK:
			move(max_speed / 3, delta)

		State.RUN:
			if walk_checker.is_colliding() or not floor_checker.is_colliding():
				direction = (direction * -1) as Direction

			move(max_speed, delta)
			if player_checker.is_colliding():
				calm_down_timer.start()


func get_next_state(state: State) -> int:
	if status.health == 0:
		return StateMachine.KEEP_CURRENT if state == State.DYING else State.DYING

	if pending_damage:
		return State.HURT

	match state:
		State.IDLE:
			if can_see_player():
				return State.RUN

			if state_machine.state_time > 2:
				return State.WALK

		State.WALK:
			if can_see_player():
				return State.RUN

			if walk_checker.is_colliding() or not floor_checker.is_colliding():
				return State.IDLE

		State.RUN:
			if not can_see_player() and calm_down_timer.is_stopped():
				return State.WALK

		State.HURT:
			if not animation_player.is_playing():
				return State.RUN

		State.DYING:
			pass

	return StateMachine.KEEP_CURRENT


func transition_state(from: State, to: State) -> void:
	print("Boar [%s] %s => %s" % [
		Engine.get_physics_frames(),
		State.keys()[from] if from != -1 else "<START>",
		State.keys()[to],
	])

	match to:
		State.IDLE:
			animation_player.play("idle")
			if walk_checker.is_colliding():
				direction = (direction * -1) as Direction

		State.WALK:
			animation_player.play("walk")
			if not floor_checker.is_colliding():
				direction = (direction * -1) as Direction
				floor_checker.force_raycast_update()

		State.RUN:
			animation_player.play("run")

		State.HURT:
			animation_player.play("hurt")
			status.health -= pending_damage.amount

			# 击退
			var dir := pending_damage.source.global_position.direction_to(global_position)
			velocity = dir * KNOCKBACK_AMOUNT

			if dir.x > 0:
				direction = Direction.LEFT
			else:
				direction = Direction.RIGHT

			pending_damage = null

		State.DYING:
			animation_player.play("dying")


func can_see_player() -> bool:
	if not player_checker.is_colliding():
		return false

	return player_checker.get_collider() is Player


func _on_hurtbox_hurt(hitbox: Hitbox) -> void:
	pending_damage = Damage.new()
	pending_damage.amount = 1
	pending_damage.source = hitbox.owner
