//Players input their name and pick a category 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../data/word_packs.dart';
import '../screens/reveal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

//Add player to the game if the field is not empty
  void _addPlayer(GameState gameState) {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    gameState.addPlayer(name);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    //Watch Game state for UI rebilds when adding or removing player (4/20 problems with this) 
    final gameState = context.watch<GameState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Guess Who ???')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Player name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addPlayer(gameState),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addPlayer(gameState),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: gameState.players.length,
                itemBuilder: (context, index) {
                  final Player player = gameState.players[index];
                  return ListTile(
                    title: Text(player.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => gameState.removePlayer(player.id),
                    ),
                  );
                },
              ),
            ),
            DropdownButton<String>(
              value: gameState.currentPack,
              items: wordPacks.keys
                  .map((pack) => DropdownMenuItem(
                        value: pack,
                        child: Text(pack),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) context.read<GameState>().setPack(value);
              },
            ),
            const SizedBox(height: 16),
            //
            if (gameState.players.length >= 3)
              ElevatedButton(
                onPressed: () {
                  context.read<GameState>().assignRoles();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RevealScreen()),
                  );
                },
                child: const Text('Start Game'),
              ),
          ],
        ),
      ),
    );
  }
}