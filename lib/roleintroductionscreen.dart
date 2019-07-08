import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/hitlerrolechooser.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';

class RoleIntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Player Introduction"),
        ),
        body: GridView.builder(
            itemCount: Provider.of<GameState>(context).game.PlayerList.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    child: Text(
                      Provider.of<GameState>(context)
                          .game
                          .PlayerList[index]
                          .name,
                      style: TextStyle(fontSize: 32),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                    onPressed: (!Provider.of<GameState>(context)
                            .game
                            .PlayerList[index]
                            .spoiled)
                        ? () {
                            print("added");

                            Future<void> _presentRole() async {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text(
                                            "${Provider.of<GameState>(context).game.PlayerList[index].name}"),
                                        content: SingleChildScrollView(
                                            child: ListBody(children: <Widget>[
                                          if (Provider.of<GameState>(context)
                                                  .game
                                                  .PlayerList[index]
                                                  .role ==
                                              Role.fascist)
                                            Text("You're a fascist."),
                                          if (Provider.of<GameState>(context)
                                                  .game
                                                  .PlayerList[index]
                                                  .role ==
                                              Role.hitler)
                                            Text("You're Hitler."),
                                          if (Provider.of<GameState>(context)
                                              .game
                                              .PlayerList[index]
                                              .isLiberal)
                                            Text("You're a liberal."),
                                          if (Provider.of<GameState>(context)
                                                  .game
                                                  .viewOthers(
                                                      Provider.of<GameState>(
                                                              context)
                                                          .game
                                                          .PlayerList[index]) !=
                                              null)
                                            for (Player player
                                                in Provider.of<GameState>(
                                                        context)
                                                    .game
                                                    .viewOthers(
                                                        Provider.of<GameState>(
                                                                context)
                                                            .game
                                                            .PlayerList[index]))
                                              Text(
                                                  "${player.name} is ${player.roleString}.")
                                        ])),
                                        actions: <Widget>[
                                          FlatButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ]);
                                  });
                            }

                            _presentRole();
                            Provider.of<GameState>(context).introducePlayer(
                                Provider.of<GameState>(context)
                                    .game
                                    .PlayerList[index]);
                            if (Provider.of<GameState>(context).introduced == true) {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Everyone's in!"), backgroundColor: Colors.green,action: SnackBarAction(
                                label: "Back to the Menu", textColor: Colors.white,
                                onPressed: () {Navigator.popUntil(context, ModalRoute.withName("/roundscreen"));}
                              )));
                            }
                          }
                        : null),
              );
            }));
  }
}
