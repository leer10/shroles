import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/hitlerrolechooser.dart';
import 'package:provider/provider.dart';
import 'package:hitlerrolechooserflutter/addplayerscreen.dart';

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
        '/addplayer': (context) => AddPlayerScreen(),
      }
    );
  }
}

class GameState with ChangeNotifier {
  Game game = Game();
void addPlayer(String name, [Role role]){
  game.addPlayer(name, role);
  notifyListeners();
}
void deletePlayer(Player player){
  game.deletePlayer(player);
  notifyListeners();
}
GameState(){
//  addPlayer("Brandon");
//  addPlayer("Mike");
//  addPlayer("Evan");
//  addPlayer("Enrico");
//  addPlayer("Becca");
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
class PlayerListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.pushNamed(context, '/addplayer');},
        child: Icon(Icons.add),
        //backgroundColor: Colors.redAccent,
      ) ,
      body: Material(
        child: Column(
          children: <Widget>[
            PlayerNumberWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: Provider.of<GameState>(context).game.PlayerList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(color: Colors.red),
                    key: Key(Provider.of<GameState>(context).game.PlayerList[index].name),
                    onDismissed: (direction) {
                      Provider.of<GameState>(context).deletePlayer(Provider.of<GameState>(context).game.PlayerList[index]);
                      //print(Provider.of<GameState>(context).game.PlayerList);
                    },
                    child: Card(child: ListTile(title: Text("${index+1}. ${Provider.of<GameState>(context).game.PlayerList[index].name}"))));
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerNumberWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MaterialAccentColor backgroundColor;
    String text;
    if (!Provider.of<GameState>(context).game.readyToPlay) {
      backgroundColor = Colors.redAccent;
      if (Provider.of<GameState>(context).game.PlayerList.length < 5) {
        text = "Not enough players!";
      }
      if (Provider.of<GameState>(context).game.PlayerList.length > 10) {
        text = "Too many players!";
      }
      return Card(color: backgroundColor, child: ListTile(title: Text(text, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))), );
    }
    else {
      //return Icon(Icons.sentiment_satisfied);
      return Card(color: Colors.green, child: InkWell(onTap: () {print("pressed!");}, child: ListTile(title: Text("Ready to Play!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)))), );
    }
  }
}
