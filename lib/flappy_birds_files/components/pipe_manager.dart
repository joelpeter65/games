import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_game/games/flappy_bird_game.dart';

import '../constants/constants.dart';
import 'pipes.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  // update the spawn of pipes
  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;
    const double pipeInterval = 2;

    if (pipeSpawnTimer >= pipeInterval) {
      pipeSpawnTimer = 0;
      // spawn pipes
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    // calculate pipe height
    // 1 get max possible height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    // height of the bottom pipe randomly select between min and max
    double bottomPipeHeight =
        maxPipeHeight + Random().nextDouble() * maxPipeHeight - minPipeHeight;

    // height of the top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    // create bottom pipe
    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    // create top pipe
    final topPipe = Pipe(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    // add both pipes to the game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
