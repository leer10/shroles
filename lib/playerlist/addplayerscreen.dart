import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/hitlerrolechooser.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';

class AddPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Player"),
      ),
      body: Center(
        child: PlayerForm(),
      )
    );
  }
}

class PlayerForm extends StatefulWidget {
  @override
  PlayerFormState createState(){
    return PlayerFormState();
  }
}
class PlayerFormState extends State<PlayerForm>{
  final _myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _myController,
              textCapitalization: TextCapitalization.words,
              onFieldSubmitted: (term) {
              if (_formKey.currentState.validate()) {print("Player ${_myController.text} added");
              Provider.of<GameState>(context).addPlayer(_myController.text);
              Navigator.pop(context);}
              },
              validator: (value) {
                if (value.isEmpty) {return 'Enter a name';}
                if (Provider.of<GameState>(context).game.containsPlayer(value)) {return 'Can\'t have duplicate players';}
                return null;
              }
            ),
            RaisedButton(
              onPressed: (){
                if (_formKey.currentState.validate()) {
                  print("Player ${_myController.text} added");
                  Provider.of<GameState>(context).addPlayer(_myController.text);
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        ),
      )
    );
  }
}
