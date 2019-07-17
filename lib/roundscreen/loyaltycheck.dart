import 'package:flutter_web/material.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';

class LoyaltyCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Loyalty Check"),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.builder(
                itemCount: Provider.of<GameState>(context).game.PlayerList.length,
                gridDelegate:
                    (orientation == Orientation.portrait) ? SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) : SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
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
                          overflow: TextOverflow.ellipsis, // also fade broken by flutter_web
                        ),
                        onPressed: () async {
                                print("added");

                                Future<void> _presentRole() async {
                                  return showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text(
                                                "${Provider.of<GameState>(context).game.PlayerList[index].name}'s Loyalty"),
                                            content: SingleChildScrollView(
                                                child: ListBody(children: <Widget>[
                                              if (Provider.of<GameState>(context)
                                                      .game
                                                      .PlayerList[index]
                                                      .isFascist)
                                                Text("Fascist"),
                                              if (Provider.of<GameState>(context)
                                                  .game
                                                  .PlayerList[index]
                                                  .isLiberal)
                                                Text("Liberal"),
                                            ])),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    //Navigator.of(context).popAndPushNamed('/roundscreen');
                                                    Navigator.of(context).popUntil(ModalRoute.withName('/roundscreen'));
                                                  })
                                            ]);
                                      });
                                }

                                await _presentRole();
                              }
                            ),
                  );
                });
          }
        ));
  }
}
