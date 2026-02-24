import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:bonfire/bonfire.dart';

class Level extends World{

  late TiledComponent level;


  @override
  FutureOr<void> onLoad() async{

    level = await TiledComponent.load(fileName, destTileSize)

    return super.onLoad();
  }
}