import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_game/flappy_birds_files/components/pipes.dart';
import 'package:flame_game/games/flappy_bird_game.dart';

import '../constants/constants.dart';
import 'ground.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  Bird()
      : super(
          position: Vector2(birdStartX, birdStartY),
          size: Vector2(birdWidth, birdHeight),
        );
  double velocity = 0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('bird.png');

    // add hit box
    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  //updates every second
  @override
  void update(double dt) {
    // gravity
    velocity += gravity * dt;
    //update position based on current velocity
    position.y += velocity * dt;
    // super.update(dt);
  }

// collission with another item
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }
    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
