# Guess Who? — Imposter Party Game

A mobile party game built with Flutter where players try to identify the imposter among the group. One player is secretly assigned a different word while everyone else shares the same word. Can the crew figure out who doesn't belong?

---

##  Features

- **Pass-the-phone gameplay** — each player privately views their word one at a time
- **6 word pack categories** — Animals, Food, Sports, TV Shows & Movies, Celebrities, and Jobs
- **Role assignment** — one player is randomly chosen as the imposter each round
- **Discussion timer** — 10 minute countdown with option to skip to voting early
- **Secret voting** — each player votes privately for who they think the imposter is
- **Scoreboard** — tracks points across multiple rounds and saves them between sessions
- **Data persistence** — player names and scores are saved even when the app is closed
- **Pink & teal dark theme** — custom UI with gradient accents and glowing effects

---

##  Architecture Overview

The app follows a Provider-based state management pattern with a clean folder structure:

###  Folder Structure

| File | Purpose |
|---|---|
| `lib/main.dart` | App entry point, theme setup, Provider initialization |
| `lib/models/player.dart` | Player data model with JSON serialization |
| `lib/models/game_state.dart` | Core game logic, role assignment, score tracking |
| `lib/screens/home_screen.dart` | Player name entry and category selection |
| `lib/screens/reveal_screen.dart` | Pass-the-phone word reveal screen |
| `lib/screens/discussion_screen.dart` | Countdown timer discussion screen |
| `lib/screens/voting_screen.dart` | Secret voting screen |
| `lib/screens/results_screen.dart` | Results and scoreboard screen |
| `lib/data/word_packs.dart` | All word categories and word lists |

###  State Management
- Uses **Provider** with `ChangeNotifier` to manage game state across all screens
- `GameState` holds the player list, current word pack, imposter index, and score data
- `shared_preferences` saves player names and scores locally on the device

###  Screen Flow

| Step | Screen | Description |
|---|---|---|
| 1 | Home Screen | Add players and pick a word category |
| 2 | Reveal Screen | Each player privately sees their word |
| 3 | Discussion Screen | Group discusses with a countdown timer |
| 4 | Voting Screen | Each player secretly votes for the imposter |
| 5 | Results Screen | Reveals the imposter and updates scores |
| 6 | Home Screen | Play again with updated scores |

##  Flutter Build & Run Instructions

### Prerequisites
- Flutter SDK installed (3.0.0 or higher)
- Android Studio installed with Android SDK
- VS Code with Flutter extension (recommended)

### Setup
1. Clone the repository:
```bash
git clone https://github.com/perknowitzki1500/FInal-Project-Guess-Who-.git
cd FInal-Project-Guess-Who-
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build APK for Android
```bash
flutter build apk --release
```
### Other Run Options
```bash
flutter run -d chrome        # Run in Chrome browser
flutter run -d macos         # Run on macOS desktop
flutter clean                # Clear build cache if issues arise
flutter doctor               # Check Flutter environment setup
```

---

##  Dependencies

| Package | Version | Purpose |
|---|---|---|
| `provider' | ^6.1.0 | State management across screens |
| `uuid' | ^4.0.0 | Generating unique player IDs |
| `shared_preferences' | ^2.2.0 | Saving player names and scores locally |
| `firebase_core' | ^3.6.0 | Firebase initialization |
| `firebase_auth' | ^5.3.0 | User authentication |

---

##  How to Play

1. **Add players** — enter each player's name on the home screen (minimum 3 players)
2. **Pick a category** — select a word pack from the dropdown
3. **Start the game** — tap START GAME
4. **Reveal roles** — pass the phone to each player privately so they can see their word
5. **Discuss** — talk as a group and try to figure out who the imposter is before the timer runs out
6. **Vote** — each player secretly votes for who they think the imposter is
7. **Results** — see if the crew caught the imposter and check the updated scoreboard
8. **Play again** — scores carry over between rounds

---

## 🤖 AI Usage Notes

AI (Claude) was used for organization with code and files along with some contents including:
- `pubspec.yaml` dependency setup
- Word pack content and category suggestions
- UI construction with pink and teal color theme
- Discussion screen timer logic and structure
- Voting screen player selection logic
- APK build instructions and commands
- File and folder organization

### Example Prompts Used
- *"What dependencies do I need for my project?"*
- *"Construct a special UI for my Imposter game app while keeping the contents the same. Use a color theme that uses Pink and Teal colors that complement each other and add emojis when making announcements in the app."*
- *"How can I construct a voting screen for my imposter game app that allows users to pick and choose a player that is not themselves and display the results?"*
- *"How can I make a discussion screen that has a timer and allows players to skip to voting?"*
- *"Give me possible words for crewmates to use in my imposter game. Use common word categories (6) such as animals, celebrities, sports, and food."*
- *"How do I get an APK for my app using Android Studio? (What commands do I use?)"*

---

##  Download APK

The latest release APK can be downloaded directly from this repository:
[guess-whom.apk](./guess-whom.apk)

---

##  Author

**Scoot Taylor**
COSC-355 — Mobile App Development


