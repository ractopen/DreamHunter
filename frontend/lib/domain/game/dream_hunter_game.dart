import 'dart:async';
import 'package:dreamhunter/domain/game/actor/player.dart';
import 'package:dreamhunter/domain/game/level/level.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class DreamHunterGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final CameraComponent cam;
  @override
  final World world = World();
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    // Load all assets into cache
    await images.loadAllImages();

    final level = Level(
      fileName: 'map/map 1.json',
      destTileSize: Vector2.all(32),
    );

    player = Player(position: Vector2(100, 100));

    await world.addAll([level, player]);

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.center;
    cam.follow(player);

    addAll([cam, world]);

    return super.onLoad();
  }
}
