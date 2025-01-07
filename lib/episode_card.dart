import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final Map<String, dynamic> episode;
  final int episodeIndex;
  final String fallbackImage;

  const EpisodeCard({
    required this.episode,
    required this.episodeIndex,
    required this.fallbackImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70, 
            height: 70, 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(fallbackImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Текстовая информация
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Серия $episodeIndex',
                  style: const TextStyle(
                    color: Color(0x8722A2BD),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Название эпизода
                Text(
                  episode['name'] ?? 'Название отсутствует',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Дата выхода эпизода
                Text(
                  episode['air_date'] ?? 'Дата отсутствует',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
