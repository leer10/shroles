import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/hitlerrolechooser.dart';
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
          children: <Widget>[
            RaisedButton(
                child: Text("Introduce Players"),
                onPressed: () {
                  Navigator.pushNamed(context, '/roundscreen/roleintroduction');
                }),
            Builder(builder: (BuildContext context) {
              return RaisedButton(
                  child: Text("Perform Loyalty Check"),
                  onPressed: (Provider.of<GameState>(context).introduced)
                      ? () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Not implemented yet"),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      : null);
            }),
            RaisedButton(
                  child: Text("Show all Players with Roles"),
                  onPressed: (Provider.of<GameState>(context).introduced)
                      ? () {Navigator.pushNamed(context, '/roundscreen/allplayers');}
                      : null),
          ],
        )));
  }
}
