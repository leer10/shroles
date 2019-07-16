import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';

class RoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Main Menu"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                child: Text("Introduce Players"),
                padding: EdgeInsets.all(24),
                onPressed: () {
                  Navigator.pushNamed(context, '/roundscreen/roleintroduction');
                }),
            Builder(builder: (BuildContext context) {
              return RaisedButton(
                  child: Text("Perform Loyalty Check"),
                  padding: EdgeInsets.all(24),
                  onPressed: (Provider.of<GameState>(context).introduced)
                      ? () {
                          if (Provider.of<GameState>(context).game.PlayerList.length <= 6 ) {Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Only for rounds of 7 or more players"),
                            //duration: Duration(seconds: 2),
                          ));}
                          else {Navigator.pushNamed(context, '/roundscreen/loyaltycheck');}
                        }
                      : null);
            }),
            RaisedButton(
                  child: Text("Show all Players with Roles"),
                  padding: EdgeInsets.all(24),
                  color: (Provider.of<GameState>(context).game.isSpoiled) ? Colors.brown : Colors.red,
                  onPressed: (Provider.of<GameState>(context).introduced)
                      ? () {Navigator.pushNamed(context, '/roundscreen/allplayers');}
                      : null),
          Divider(),
          RaisedButton(
            child: Text("Role Descriptions"),
            padding: EdgeInsets.all(14),
            onPressed: (){Navigator.pushNamed(context, '/roundscreen/roledescriptions');},
          ),
          RaisedButton(
            child: Text("Game Setup Tips"),
            padding: EdgeInsets.all(14),
            onPressed: (){Navigator.pushNamed(context, '/roundscreen/gamesetuptips');},
          )
        ],
        )));
  }
}
