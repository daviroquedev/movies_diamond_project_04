import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double maxRating = 10.0;
  final int totalStars = 5;

  RatingStars({required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    double starPercentage = (voteAverage / maxRating) * totalStars;
    int fullStars = starPercentage.floor();
    double halfStar = starPercentage - fullStars;
    int emptyStars = totalStars - fullStars - (halfStar > 0 ? 1 : 0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildStar(Icons.star, fullStars),
            if (halfStar > 0) _buildStar(Icons.star_half, 1),
            _buildStar(Icons.star_border, emptyStars),
          ],
        ),
        SizedBox(width: 4), // Espaçamento entre as estrelas e os valores
        Text(
          '(${voteAverage.toStringAsFixed(1)})', // Formatação para uma casa decimal
          style: TextStyle(color: Colors.white), // Estilo do texto
        ),
      ],
    );
  }

  Widget _buildStar(IconData icon, int count) {
    return Row(
      children: List.generate(
        count,
        (index) => Icon(
          icon,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }
}
