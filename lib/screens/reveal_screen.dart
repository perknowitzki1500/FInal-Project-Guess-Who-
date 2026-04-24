import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import 'discussion_screen.dart';

class RevealScreen extends StatefulWidget {
  const RevealScreen({super.key});

  @override
  State<RevealScreen> createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  int _currentIndex = 0;
  bool _wordVisible = false;

  void _nextPlayer(int totalPlayers) {
    if (_currentIndex < totalPlayers - 1) {
      setState(() {
        _currentIndex++;
        _wordVisible = false;
      });
    } else {
      // all players have seen their word at this point 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DiscussionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final player = gameState.players[_currentIndex];
    final total = gameState.players.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Role Reveal')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pass the phone to:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                player.name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              if (!_wordVisible)
                ElevatedButton(
                  onPressed: () => setState(() => _wordVisible = true),
                  child: const Text('Tap to reveal your word'),
                )
              else ...[
                Text(
                  player.assignedWord ?? '???',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                if (player.isImposter)
                  const Text(
                    'You are the imposter!',
                    style: TextStyle(color: Colors.red),
                  )
                else
                  const Text('You are a crewmate.'),
                const SizedBox( height: 40),
                ElevatedButton(
                  onPressed: () => _nextPlayer(total),
                  child: Text(
                    _currentIndex < total - 1 ? 'Done — pass the phone' : 'Start discussion',
                  ),//AI for organization of if else staments 
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}