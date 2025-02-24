import 'dart:async';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../math_games_screens/math_sabtraction_screen.dart';
import '../math_games_screens/math_screen.dart';
import '../tetris_files/piece.dart';
import '../tetris_files/pixel.dart';
import '../tetris_files/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  columnLength,
  (i) => List.generate(rowLength, (j) => null),
);

class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  bool gameOver = false;
  bool isPaused = false;
  Timer? _gameTimer;
  Duration currentFrameRate = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('tetrisBackground.mp3', volume: 0.2);
    startGame();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void startGame() {
    currentPiece.initalizePiece();
    gameLoop(currentFrameRate);
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
      if (isPaused) {
        _gameTimer?.cancel();
      } else {
        gameLoop(currentFrameRate);
      }
    });
  }

  void updateSpeed() {
    _gameTimer?.cancel();

    // Check highest score threshold first
    if (currentScore >= 15) {
      currentFrameRate = const Duration(milliseconds: 100);
    } else if (currentScore >= 10) {
      currentFrameRate = const Duration(milliseconds: 200);
    } else if (currentScore >= 5) {
      currentFrameRate = const Duration(milliseconds: 300);
    } else {
      currentFrameRate = const Duration(milliseconds: 400); // Default speed
    }

    gameLoop(currentFrameRate);
  }

  void gameLoop(Duration frameRate) {
    _gameTimer = Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          clearLines();
          checkLanding();
          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text('Game Over'),
        ),
        content: Text(
          "Score: $currentScore",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                gameBoard = List.generate(
                    columnLength, (i) => List.generate(rowLength, (j) => null));
                gameOver = false;
                currentScore = 0;
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
                gameBoard = List.generate(
                    columnLength, (i) => List.generate(rowLength, (j) => null));
                gameOver = false;
                currentScore = 0;
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

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      if (direction == Direction.down) {
        row++;
      } else if (direction == Direction.right) {
        col++;
      } else if (direction == Direction.left) {
        col--;
      }

      if (col < 0 || col >= rowLength || row >= columnLength) {
        return true;
      }

      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random random = Random();

    Tetromino randomType =
        Tetromino.values[random.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initalizePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveDown() {
    setState(() {
      currentPiece.movePiece(Direction.down);
    });
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void clearLines() {
    for (int row = columnLength - 1; row >= 0; row--) {
      bool lineFilled = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          lineFilled = false;
          break;
        }
      }

      if (lineFilled) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        FlameAudio.play('smallRockBreak.mp3', volume: 0.2);
        gameBoard[0] = List.generate(rowLength, (index) => null);
        currentScore++;
        if (currentScore == 5) {
          updateSpeed();
        }
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        FlameAudio.bgm.play('gameOver.mp3', volume: 0.2);
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tetris",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: togglePause,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                    child: Row(
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.pause,
                          color: Colors.black,
                        ),
                        Text(
                          isPaused ? 'Resume' : 'Pause',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: rowLength * columnLength,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.311, crossAxisCount: rowLength),
                    itemBuilder: (context, index) {
                      int row = (index / rowLength).floor();
                      int col = index % rowLength;
                      if (currentPiece.position.contains(index)) {
                        return Pixel(
                          color: currentPiece.color,
                        );
                      } else if (gameBoard[row][col] != null) {
                        final Tetromino? tetrominoType = gameBoard[row][col];
                        return Pixel(
                          color: tetrominoColors[tetrominoType],
                        );
                      } else {
                        return Pixel(
                          color: Colors.grey[900],
                        );
                      }
                    },
                  ),
                  if (isPaused)
                    Container(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.7),
                      child: Center(
                        child: Text(
                          'PAUSED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              'Score: $currentScore',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 50),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: isPaused ? null : moveLeft,
                      child: Container(
                        height: 70,
                        color: Colors.white,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: isPaused ? null : rotatePiece,
                      child: Container(
                        height: 70,
                        color: Colors.white,
                        child: Icon(
                          Icons.rotate_right,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: isPaused ? null : moveRight,
                      child: Container(
                        height: 70,
                        color: Colors.white,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
