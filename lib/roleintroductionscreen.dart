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
        itemCount:
            Provider.of<GameState>(context).game.PlayerList.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(child: Text(Provider.of<GameState>(context).game.PlayerList[index].name, style: TextStyle(fontSize: 32), textAlign: TextAlign.center, overflow: TextOverflow.fade,), onPressed: (){print("i'm pressed");}),
          );
        }
      )
    );
  }
}
