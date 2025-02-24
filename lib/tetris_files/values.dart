import 'package:flutter/material.dart';

int rowLength = 10;
int columnLength = 15;

enum Direction {
  left,
  right,
  down,
}

enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Colors.orange,
  Tetromino.J: Colors.purple,
  Tetromino.I: Colors.blueAccent,
  Tetromino.O: Colors.amber,
  Tetromino.S: Colors.red,
  Tetromino.Z: Colors.brown,
  Tetromino.T: Colors.teal,
};
