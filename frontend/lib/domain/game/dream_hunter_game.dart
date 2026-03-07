import 'dart:async';
import 'package:dreamhunter/domain/game/actor/player.dart';
import 'package:dreamhunter/domain/game/level/level.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class DreamHunterGame extends FlameGame
    with HasCollisionDetection, DragCallbacks {
  late final CameraComponent cam;
  @override
  final World world = World();
  late Player player;
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    // Load all assets into cache
    await images.loadAllImages();

    final level = Level(
      fileName: 'map/map 1.json',
      destTileSize: Vector2.all(32),
    );

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: Paint()..color = Colors.white.withOpacity(0.5)),
      background: CircleComponent(radius: 50, paint: Paint()..color = Colors.white.withOpacity(0.2)),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    player = Player(position: Vector2(100, 100), joystick: joystick);

    await world.addAll([level, player]);

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.center;
    cam.follow(player);

    addAll([cam, world, joystick]);

    return super.onLoad();
  }
}
