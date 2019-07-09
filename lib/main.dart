import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/hitlerrolechooser.dart';
import 'package:provider/provider.dart';
import 'package:hitlerrolechooserflutter/addplayerscreen.dart';
import 'package:hitlerrolechooserflutter/playerlistscreen.dart';
import 'package:hitlerrolechooserflutter/roleintroductionscreen.dart';
import 'package:hitlerrolechooserflutter/roundscreen.dart';
import 'package:hitlerrolechooserflutter/showallplayerswithrolesscreen.dart';
import 'package:hitlerrolechooserflutter/loyaltycheck.dart';

void main() => runApp(ChangeNotifierProvider(builder: (context) => GameState(), child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitler Role Chooser',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red, brightness: Brightness.dark, accentColor: Colors.redAccent
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/playerlist': (context) => PlayerListScreen(),
        '/playerlist/addplayer': (context) => AddPlayerScreen(),
        '/roundscreen/roleintroduction': (context) => RoleIntroductionScreen(),
        '/roundscreen': (context) => RoundScreen(),
        '/roundscreen/allplayers': (context) => ShowPlayersWithRolesScreen(),
        '/roundscreen/loyaltycheck': (context) => LoyaltyCheckScreen(),
      }
    );
  }
}

class GameState with ChangeNotifier {
  Game game = Game();
  bool _introduced = false;
void addPlayer(String name, [Role role]){
  game.addPlayer(name, role);
  notifyListeners();
}
void deletePlayer(Player player){
  game.deletePlayer(player);
  notifyListeners();
}

bool get introduced => _introduced;
void introduce() {
  _introduced = true;
  notifyListeners();
}
void introducePlayer(Player player){
  player.spoiled = true;
  if (game.PlayerList.every((aPlayer) => aPlayer.spoiled == true)) {
    _introduced = true;
  }
  notifyListeners();
}

GameState(){
  addPlayer("Brandon");
  addPlayer("Mike");
  addPlayer("Evan");
  addPlayer("Enrico");
  addPlayer("Becca");
  addPlayer("Frank");
  addPlayer("Elijah");
}
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Welcome\nto Secret Hitler", textAlign: TextAlign.center , style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold) ,),
              Text("This is a game of trickery. Be a fascist and sow discord, or be a cunning liberal and catch the fascists on their bluffs. Whatever you do, don't let Hitler win!", textAlign: TextAlign.center,),
              Text("This app will help you set up roles for a 5 to 10 player game of Secret Hitler.", textAlign: TextAlign.center),
              RaisedButton(
                child: Text('START GAME'),
                onPressed: () {
                  // Navigate to the second screen when tapped.
                  Navigator.pushNamed(context, '/playerlist');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
