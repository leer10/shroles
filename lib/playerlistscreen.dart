import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';

class PlayerListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/playerlist/addplayer');
        },
        child: Icon(Icons.add),
        //backgroundColor: Colors.redAccent,
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            PlayerNumberWidget(),
            Expanded(
              child: ListView.builder(
                  itemCount:
                      Provider.of<GameState>(context).game.PlayerList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        background: Container(color: Colors.red),
                        key: Key(Provider.of<GameState>(context)
                            .game
                            .PlayerList[index]
                            .name),
                        onDismissed: (direction) {
                          Provider.of<GameState>(context).deletePlayer(
                              Provider.of<GameState>(context)
                                  .game
                                  .PlayerList[index]);
                          //print(Provider.of<GameState>(context).game.PlayerList);
                        },
                        child: Card(
                            child: ListTile(
                                title: Text(
                                    "${index + 1}. ${Provider.of<GameState>(context).game.PlayerList[index].name}"))));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerNumberWidget extends StatelessWidget {
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
      return Card(
        color: backgroundColor,
        child: ListTile(
            title: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold))),
      );
    } else {
      //return Icon(Icons.sentiment_satisfied);
      return Card(
        color: Colors.green,
        child: InkWell(
            onTap: () async {
              //print("pressed!");
              if (Provider.of<GameState>(context).game.PlayerList.length == 6) {
                Future<void> _askIfWantMod() async {
                return showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text("Balance"),
                          content: Text("There are 6 players in the game. Do you want to add a balancing player role called Radical Centrist?"),
                          actions: <Widget>[
                            FlatButton(
                                child: Text('Vanilla'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                                FlatButton(
                                    child: Text('Add Role'),
                                    onPressed: () {
                                      Provider.of<GameState>(context).game.radicalCentristExists = true;
                                      Navigator.of(context).pop();
                                    })
                          ]);
                    });
              }

              await _askIfWantMod();}
              Provider.of<GameState>(context).game.assignroles();
              Navigator.pushNamedAndRemoveUntil(context, '/roundscreen', (_) => false);
            },
            child: ListTile(
                title: Text("Ready to Play!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)))),
      );
    }
  }
}
