import 'package:flutter/material.dart';
import 'dart:async';
import 'voting_screen.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State <DiscussionScreen> {
  int _seconds = 120;
  late Timer _timer;

  @override
    void initState() { 
      super.initState();
      _startTimer();
    }

    void _startTimer() {
      _timer = Timer.periodic(const Duration(seconds:1), (timer) {
        if (_seconds == 0 ) {
          _timer.cancel();
          _goToVoting();
        } else {
          setState(() => _seconds --);
        }
      });
    }

    void _goToVoting() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VotingScreen()),
      );
    }

    @override
    void dispose() {
      _timer.cancel();
      super.dispose();
    }
    String get _formattedTime {
      final minutes =_seconds ~/ 60;
      final seconds = _seconds % 60;
      return ' $minutes:${ seconds.toString().padLeft(2,'0')}';
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold( 
        appBar:AppBar(title: const Text('Discussion')),
        body: Center(
          child: Padding (
            padding: const EdgeInsets.all(24),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Discuss who you think the imposter is ',
                  textAlign: TextAlign.center, 
                  style: TextStyle(fontSize:18),
                ),
                const SizedBox(height:40),
                Text(
                  _formattedTime,
                  style: const TextStyle(
                    fontSize: 80, 
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  const SizedBox(height:40),
                  ElevatedButton(
                    onPressed: _goToVoting,
                    child: const Text('Skip to voting'),
                  )
              ]
            )
          )
        )
      );
    }
    
  }
  

