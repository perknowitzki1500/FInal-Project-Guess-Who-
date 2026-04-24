import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class ResultsScreen extends StatefulWidget {
  final String mostVotedId;

  const ResultsScreen({super.key, required this.mostVotedId});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool _scoresUpdated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameState = context.read<GameState>();
      final players = gameState.players;
      final mostVoted = players.firstWhere((p) => p.id == widget.mostVotedId);
      final crewWon = mostVoted.isImposter;
      if (!_scoresUpdated) {
        gameState.updateScores(crewWon);
        _scoresUpdated = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final players = gameState.players;
    final mostVoted = players.firstWhere((p) => p.id == widget.mostVotedId);
    final imposter = players.firstWhere((p) => p.isImposter);
    final crewWon = mostVoted.isImposter;

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              crewWon ? 'AYYYEE THE CREW WINS!' : 'IMPOSTER WINS',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'The crew voted out: ${mostVoted.name}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'The imposter was: ${imposter.name}',
              style: TextStyle(
                fontSize: 18,
                color: crewWon ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'The word was: ${players.firstWhere((p) => !p.isImposter).assignedWord}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              'Scores',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...players.map((p) => Text(
              '${p.name}: ${p.score} pts',
              style: const TextStyle(fontSize: 16),
            )),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                gameState.resetGame();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Play again'),
            ),
          ],
        ),
      ),
    );
  }
}