import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'player.dart';
import '../data/word_packs.dart';

class GameState extends ChangeNotifier {
  final List<Player> players = [];
  final _uuid = const Uuid();
  final _random = Random();
  int _imposterIndex = -1;
  String currentPack = 'Animals';

  int get imposterIndex => _imposterIndex;

  GameState() {
    loadPlayers();
  }

  // Save players to device
  Future<void> savePlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final playerList = players.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('players', playerList);
  }

  // Load players from device
  Future<void> loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final playerList = prefs.getStringList('players') ?? [];
    players.clear();
    for (var playerJson in playerList) {
      players.add(Player.fromJson(jsonDecode(playerJson)));
    }
    notifyListeners();
  }

  // Save scores to device
  Future<void> saveScores() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = {for (var p in players) p.id: p.score};
    await prefs.setString('scores', jsonEncode(scores));
  }

  void addPlayer(String name) {
    players.add(Player(id: _uuid.v4(), name: name));
    savePlayers();
    notifyListeners();
  }

  void removePlayer(String id) {
    players.removeWhere((p) => p.id == id);
    savePlayers();
    notifyListeners();
  }

  void updateScores(bool crewWon) {
    for (var player in players) {
      if (crewWon && !player.isImposter) {
        player.score += 1;
      } else if (!crewWon && player.isImposter) {
        player.score += 1;
      }
    }
    saveScores();
    notifyListeners();
  }

  void resetGame() {
    for (var player in players) {
      player.assignedWord = null;
      player.isImposter = false;
    }
    _imposterIndex = -1;
    notifyListeners();
  }

  void assignRoles() {
    final words = wordPacks[currentPack] ?? wordPacks.values.first;
    final word = words[_random.nextInt(words.length)];
    _imposterIndex = _random.nextInt(players.length);

    for (int i = 0; i < players.length; i++) {
      players[i].isImposter = (i == _imposterIndex);
      players[i].assignedWord = (i == _imposterIndex) ? '???' : word;
    }
    notifyListeners();
  }

  void setPack(String packName) {
    currentPack = packName;
    notifyListeners();
  }
}