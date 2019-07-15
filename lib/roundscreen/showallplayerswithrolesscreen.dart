import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/hitlerrolechooser.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';

class ShowPlayersWithRolesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Provider.of<GameState>(context).game.isSpoiled = true;
    return Scaffold(
    appBar: AppBar(title:Text("All Players") ,),
    body: Material(
      child:
      ListView.separated(
        itemCount: Provider.of<GameState>(context).game.PlayerList.length,
        separatorBuilder:(context, index) => Divider(),
        itemBuilder: (context, index) {
          Player currentPlayer = Provider.of<GameState>(context).game.PlayerList[index];
          return ListTile(title:Text(currentPlayer.name),
        trailing: Container(
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (currentPlayer.marked) Icon(Icons.visibility),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoleLabel(role: currentPlayer.role),
              ),
            ],
          ),
        ), );
        }
      )
    ),
    );
  }
}

class RoleLabel extends StatelessWidget{
  RoleLabel({this.role});
  final Role role;

  @override
  Widget build(BuildContext context) {
    if (role == Role.liberal){
      return Container(child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Liberal"),
      ), color: Colors.blue,);
    }
    else if (role == Role.radicalcentrist){
      return Container(child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Radical Centrist"),
      ), color: Colors.purple,);
    }
    else if (role == Role.fascist){
      return Container(child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Fascist"),
      ), color: Colors.red,);
    }
    else if (role == Role.hitler){
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white), color: Colors.black),
        child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Hitler"),
      ));
    }
  }

}
