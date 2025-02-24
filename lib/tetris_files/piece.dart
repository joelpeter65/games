import 'package:flame_game/tetris_files/values.dart';
import 'package:flutter/material.dart';

import '../games/tetris_game.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  void initalizePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
      case Tetromino.O:
        position = [
          -16,
          -15,
          -6,
          -5,
        ];
      case Tetromino.S:
        position = [
          -15,
          -14,
          -5,
          -6,
        ];
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
    }
  }

  int rotateState = 1;

  void rotatePiece() {
    List<int> newPosition = [];
    switch (type) {
      case Tetromino.L:
        switch (rotateState) {
          case 0:
            /*
            o
            o
            o o
           */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
            o
            o o o
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
            o
            o
            */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
            o o o
            */
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotateState) {
          case 0:
            /*
            o
            o
            o o
           */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
            o
            o o o
            */
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
            o
            o
            */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
            o o o
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.I:
        switch (rotateState) {
          case 0:
            /*
            o
            o
            o o
           */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
            o
            o o o
            */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
            o
            o
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
            o o o
            */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.O:
        switch (rotateState) {
          case 0:
          /*
            o
            o
            o o
           */
        }
        break;

      case Tetromino.S:
        switch (rotateState) {
          case 0:
            /*
            o
            o
            o o
           */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
            o
            o o o
            */
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
            o
            o
            */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
            o o o
            */
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.Z:
        switch (rotateState) {
          case 0:
            // assign new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            // assign new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            // assign new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            // assign new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      // case Tetromino.Z:
      //   switch (rotateState) {
      //     case 0:
      //       newPosition = [
      //         position[0] + rowLength - 2,
      //         position[1],
      //         position[2] + rowLength - 1,
      //         position[3] + 1,
      //       ];
      //       if (piecePositionIsValid(newPosition)) {
      //         position = newPosition;
      //
      //         rotateState = (rotateState + 1) % 4;
      //       }
      //       break;
      //     case 1:
      //       newPosition = [
      //         position[0] - rowLength + 2,
      //         position[1],
      //         position[2] - rowLength + 1,
      //         position[3] - 1,
      //       ];
      //       if (piecePositionIsValid(newPosition)) {
      //         position = newPosition;
      //
      //         rotateState = (rotateState + 1) % 4;
      //       }
      //       break;
      //     case 2:
      //       newPosition = [
      //         position[0] + rowLength - 2,
      //         position[1] + 1,
      //         position[2] + rowLength - 1,
      //         position[3] + 1,
      //       ];
      //       if (piecePositionIsValid(newPosition)) {
      //         position = newPosition;
      //
      //         rotateState = (rotateState + 1) % 4;
      //       }
      //       break;
      //     case 3:
      //       newPosition = [
      //         position[0] - rowLength + 2,
      //         position[1],
      //         position[2] - rowLength + 1,
      //         position[3] - 1,
      //       ];
      //       if (piecePositionIsValid(newPosition)) {
      //         position = newPosition;
      //
      //         rotateState = (rotateState + 1) % 4;
      //       }
      //       break;
      //   }
      //   break;

      case Tetromino.T:
        switch (rotateState) {
          case 0:
            /*
            o
            o
            o o
           */
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            /*
            o
            o o o
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            /*
            o o
            o
            o
            */
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
            o o o
            */
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
    }
  }

  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
