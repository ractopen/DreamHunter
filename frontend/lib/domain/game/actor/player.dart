import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dreamhunter/domain/game/dream_hunter_game.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<DreamHunterGame>, CollisionCallbacks {
  final double stepTime = 0.1;
  final double moveSpeed = 200;
  final double gravity = 9.8;
  final double jumpForce = 450;
  final double terminalVelocity = 300;

  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  JoystickComponent joystick;

  Player({
    position,
    required this.joystick,
  }) : super(position: position, size: Vector2.all(32));

  @override
  FutureOr<void> onLoad() async {
    _loadAllAnimations();
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _applyGravity(dt);
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  void _loadAllAnimations() {
    final spriteSheet = game.images.fromCache('sprites/character/char1.png');
    animation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _applyGravity(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(-jumpForce, terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _updatePlayerMovement(double dt) {
    // Joystick horizontal movement
    if (joystick.direction != JoystickDirection.idle) {
      velocity.x = joystick.relativeDelta.x * moveSpeed;
      position.x += velocity.x * dt;

      // Jump if moving up significantly
      if (joystick.relativeDelta.y < -0.5 && isOnGround) {
        _jump();
      }

      // Flip sprite based on direction
      if (joystick.relativeDelta.x < 0 && scale.x > 0) {
        flipHorizontallyAroundCenter();
      } else if (joystick.relativeDelta.x > 0 && scale.x < 0) {
        flipHorizontallyAroundCenter();
      }
    } else {
      velocity.x = 0;
    }
  }

  void _jump() {
    velocity.y = -jumpForce;
    isOnGround = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (velocity.y > 0) {
      if (position.y + size.y > other.position.y &&
          position.y < other.position.y) {
        velocity.y = 0;
        position.y = other.position.y - size.y;
        isOnGround = true;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    isOnGround = false;
    super.onCollisionEnd(other);
  }
}
