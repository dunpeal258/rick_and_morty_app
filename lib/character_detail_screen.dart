import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:rick_and_morty_app/episode_card.dart';
import 'package:rick_and_morty_app/info_item.dart';
import 'rick_and_morty_service.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Map<String, dynamic> character;

  const CharacterDetailScreen({required this.character, Key? key})
      : super(key: key);

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  final RickAndMortyService _service = RickAndMortyService();
  List<dynamic> episodes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    final fetchedEpisodes = await _service.fetchEpisodes(widget.character['episode']);
    setState(() {
      episodes = fetchedEpisodes;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.character;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1E2D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1E2D),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  // Бэкграунд с изображением персонажа
                  Image.network(
                    character['image'],
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ).blurred(
                    blur: 2,
                    blurColor: Color(0x650B1E2D),
                    colorOpacity: 0.6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      // Аватарка персонажа
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: const Color(0xFF0B1E2D),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(character['image']),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Имя персонажа
                      Text(
                        character['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // Статус
                      Text(
                        character['status'] == 'Alive' ? 'ЖИВОЙ' : 'МЕРТВЫЙ',
                        style: TextStyle(
                          color: character['status'] == 'Alive'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // Описание персонажа
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          character['description'] ?? 'Описание отсутствует.',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Пол и раса
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoItem(title: 'Пол', value: character['gender']),
                            InfoItem(title: 'Раса', value: character['species']),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        color: Colors.white24,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      const SizedBox(height: 16),
                      // Эпизоды
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Эпизоды',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...episodes.asMap().entries.map((entry) {
                              final index = entry.key + 1;
                              final episode = entry.value;

                              return EpisodeCard(
                                episode: episode,
                                episodeIndex: index,
                                fallbackImage: widget.character['image'] ?? 'https://via.placeholder.com/150',
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
