import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../games/flappy_bird_game.dart';
import '../constants/constants.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Ground() : super();

  // Base speed that will be multiplied by the game's speed multiplier
  final double baseScrollingSpeed = groundScrollingSpeed;
  double currentScrollingSpeed = groundScrollingSpeed;

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);
    sprite = await Sprite.load('ground.png');
    add(RectangleHitbox());
  }

  void updateSpeed(double multiplier) {
    currentScrollingSpeed = baseScrollingSpeed * multiplier;
  }

  @override
  void update(double dt) {
    if (!gameRef.isGameOver) {
      position.x -= currentScrollingSpeed * dt;

      if (position.x + size.x / 2 <= 0) {
        position.x = 0;
      }
    }
  }
}
// class Ground extends SpriteComponent
//     with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
//   Ground() : super();
//
//
//   @override
//   FutureOr<void> onLoad() async {
//     size = Vector2(2 * gameRef.size.x, groundHeight);
//     position = Vector2(0, gameRef.size.y - groundHeight);
//     sprite = await Sprite.load('ground.png');
//
//     // add colission box
//     add(RectangleHitbox());
//   }
//
//   // move ground
//   @override
//   void update(double dt) {
//     // move ground left
//     position.x -= groundScrollingSpeed * dt;
//
//     // reset ground if it goes off screen for infinite scrolling
//     // if half of the ground has been passed reset
//     if (position.x + size.x / 2 <= 0) {
//       position.x = 0;
//     }
//   }
// }
