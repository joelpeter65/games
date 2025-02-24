import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../flappy_birds_files/constants/constants.dart';
import '../games/flappy_bird_game.dart';
import '../games/tetris_game.dart';

class MathGameScreen extends StatefulWidget {
  const MathGameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MathGameScreenState createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> {
  int number1 = Random().nextInt(10);
  int number2 = Random().nextInt(10);
  int score = 0;
  final TextEditingController _controller = TextEditingController();

  void checkAnswer() {
    int userAnswer = int.tryParse(_controller.text) ?? -1;
    if (userAnswer == number1 + number2) {
      score++;
    }
    if (score == 5) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text('Congratulations'),
          ),
          content: Text(
            "Score: $score",
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => GameWidget(game: FlappyBirdGame()),
                    ),
                  );
                },
                child: Text('Play Flappy Bird'),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TetrisGame(),
                    ),
                  );
                },
                child: Text('Play Tetris'),
              ),
            ),
          ],
        ),
      );
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => GameWidget(game: FlappyBirdGame()),
      //   ),
      // );
    }
    setState(() {
      number1 = Random().nextInt(10);
      number2 = Random().nextInt(10);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Math - Addition',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: CustomColors.snColors,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$number1 + $number2',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter your answer",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkAnswer,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: CustomColors.snColors,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Score: $score',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
