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
            RaisedButton(
                child: Text("Perform Loyalty Check"),
                onPressed: (Provider.of<GameState>(context).introduced)
                    ? () {
                        print("hey!");
                      }
                    : null),
          ],
        )));
  }
}
