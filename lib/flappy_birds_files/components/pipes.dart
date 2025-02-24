import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_game/games/flappy_bird_game.dart';

import '../constants/constants.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(
          position: position,
          size: size,
        );

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'top_pipe.png' : 'bottom_pipe.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // scroll pipe on the scree
    position.x -= groundScrollingSpeed * dt;

    if (!scored && position.x + size.x <= gameRef.bird.position.x) {
      scored = true;
      if (!isTopPipe) {
        gameRef.incrementScore();
      }
    }

    // past screen remove the pipe
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
