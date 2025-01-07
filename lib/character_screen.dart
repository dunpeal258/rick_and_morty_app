import 'package:flutter/material.dart';
import 'character_detail_screen.dart';
import 'rick_and_morty_service.dart';

class CharacterScreen extends StatefulWidget {
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final RickAndMortyService _service = RickAndMortyService();
  List<dynamic> characters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final fetchedCharacters = await _service.getCharacters();
    setState(() {
      characters = fetchedCharacters;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1E2D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1E2D),
        elevation: 0,
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Найти персонажа',
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            suffixIcon: const Icon(Icons.filter_list, color: Colors.white),
            filled: true,
            fillColor: const Color(0xFF152A3A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ВСЕГО ПЕРСОНАЖЕЙ: ${characters.length}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.grid_view, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        final character = characters[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CharacterDetailScreen(character: character),
                              ),
                            );
                          },
                          child: CharacterCard(character: character),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF152A3A),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Локации',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_outlined),
            label: 'Эпизоды',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final Map<String, dynamic> character;

  const CharacterCard({required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(character['image']),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character['status'] == 'Alive' ? 'ЖИВОЙ' : 'МЕРТВЫЙ',
                  style: TextStyle(
                    color: character['status'] == 'Alive'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  character['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${character['gender']}, ${character['species']}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
