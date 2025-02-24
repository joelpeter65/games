import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../flappy_birds_files/components/background.dart';
import '../flappy_birds_files/components/bird.dart';
import '../flappy_birds_files/components/ground.dart';
import '../flappy_birds_files/components/pipe_manager.dart';
import '../flappy_birds_files/components/pipes.dart';
import '../flappy_birds_files/components/score.dart';
import '../flappy_birds_files/constants/constants.dart';
import '../math_games_screens/math_sabtraction_screen.dart';
import '../math_games_screens/math_screen.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  @override
  FutureOr<void> onLoad() {
    //music
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('background.mp3', volume: 0.2);

    //load background
    background = Background(size);
    add(background);

    // load bird
    bird = Bird();
    add(bird);

    //load ground
    ground = Ground();
    add(ground);

    //load pipeManager
    pipeManager = PipeManager();
    add(pipeManager);

    //load Score
    scoreText = ScoreText();
    add(scoreText);
  }

  //on Tap
  @override
  void onTap() {
    bird.flap();
  }

  // score
  int score = 0;

  void incrementScore() {
    FlameAudio.play('collectPoints.mp3', volume: 0.2);
    score += 1;
  }

  // Game over
  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;
    isGameOver = true;
    pauseEngine();
    FlameAudio.bgm.play('gameOver.mp3', volume: 0.2);

    // show Game Over dialog
    showDialog(
      context: buildContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text('Game Over'),
        ),
        content: Text(
          "Score: $score",
          textAlign: TextAlign.center,
        ),
        actions: [
          // Center(
          //   child: TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //       resetGame();
          //     },
          //     child: Text('Restart'),
          //   ),
          // ),
          Center(
            child: TextButton(
              onPressed: () {
                FlameAudio.bgm.stop();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MathGameScreen(),
                  ),
                );
              },
              child: Text('Answer addition maths'),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                FlameAudio.bgm.stop();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MathGameSabtractionScreen(),
                  ),
                );
              },
              child: Text('Answer subtraction maths'),
            ),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    isGameOver = false;
    score = 0;

    // remove the pipes
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());

    resumeEngine();
  }
}
