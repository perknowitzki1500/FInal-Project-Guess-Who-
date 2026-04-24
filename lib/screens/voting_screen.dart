import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import 'results_screen.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  int _voterIndex = 0;
  String? _selectedPlayerId;
  final Map<String, int> _voteTally = {};

  void _submitVote(List<Player> players) {
    if (_selectedPlayerId == null) return;

    _voteTally[_selectedPlayerId!] =
        (_voteTally[_selectedPlayerId!] ?? 0) + 1;

    if (_voterIndex < players.length - 1) {
      setState(() {
        _voterIndex++;
        _selectedPlayerId = null;
      });
    } else {
      _goToResults(players);
    }
  }

  void _goToResults(List<Player> players) {
    String mostVotedId = _voteTally.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultsScreen(mostVotedId: mostVotedId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final players = gameState.players;
    final voter = players[_voterIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Voting')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '${voter.name}, who do you think is the imposter?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final Player candidate = players[index];
                  if (candidate.id == voter.id) return const SizedBox.shrink();
                  return RadioListTile<String>(
                    title: Text(candidate.name),
                    value: candidate.id,
                    groupValue: _selectedPlayerId,
                    onChanged: (value) =>
                        setState(() => _selectedPlayerId = value),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _selectedPlayerId == null
                  ? null
                  : () => _submitVote(players),
              child: Text(
                _voterIndex < players.length - 1
                    ? 'Submit vote — pass the phone'
                    : 'Submit final vote',
              ),
            ),
          ],
        ),
      ),
    );
  }
}