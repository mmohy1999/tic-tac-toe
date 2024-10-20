import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<int> winningLine;

  WinningLinePainter(this.winningLine);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black38
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // Coordinates of each cell in the grid
    final cellSize = size.width / 3;
    final points = winningLine.map((index) {
      final row = index ~/ 3;
      final col = index % 3;
      return Offset(
        col * cellSize + cellSize / 2,
        row * cellSize + cellSize / 2,
      );
    }).toList();

    if (points.length == 3) {
      // Draw line from first to last point of the winning combination
      canvas.drawLine(points[0], points[2], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
