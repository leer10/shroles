import 'package:flutter_web/material.dart';
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
        body: OrientationBuilder(builder: (context, orientation) {
          return GridView.builder(
              itemCount: Provider.of<GameState>(context).game.PlayerList.length,
              gridDelegate: (orientation == Orientation.portrait)
                  ? SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)
                  : SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _PlayerButton(
                      player: Provider.of<GameState>(context)
                          .game
                          .PlayerList[index]),
                );
              });
        }));
  }
}

class _PlayerButton extends StatefulWidget {
  const _PlayerButton({Key key, this.player}) : super(key: key);
  final Player player;

  @override
  _PlayerButtonState createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<_PlayerButton> {
  bool isAvailable;
  @override
  Widget build(BuildContext context) {
    isAvailable = widget.player.spoiled;
    return RaisedButton(
        child: Text(
          widget.player.name,
          style: TextStyle(fontSize: 32),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis, //not fade because that's broken by flutter_web
        ),
        onPressed: (!widget.player.spoiled)
            ? () async {
                print("added");

                Future<void> _presentRole() async {
                  return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("${widget.player.name}"),
                            content: SingleChildScrollView(
                                child: ListBody(children: <Widget>[
                              Text("You're a ${widget.player.roleString}."),
                              if (Provider.of<GameState>(context)
                                      .game
                                      .viewOthers(widget.player).isNotEmpty)
                                for (var player
                                    in Provider.of<GameState>(context)
                                        .game
                                        .viewOthers(widget.player).entries)
                                  Text(
                                      "${player.key.name} is a ${player.value}.")
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

                await _presentRole();
                setState(() {
                  Provider.of<GameState>(context, listen: false)
                      .introducePlayer(widget.player);
                  isAvailable = false;
                });
                if (Provider.of<GameState>(context).introduced == true) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Everyone's in!"),
                      backgroundColor: Colors.green,
                    //  action: (!kIsWeb) ? SnackBarAction(
                    //      label: "Back to the Menu", textColor: Colors.white,
                    //      onPressed: () {
                    //        Navigator.popUntil(
                    //            context, ModalRoute.withName("/roundscreen"));
                    //      }) : null // eventually use this code when textColor is supported by flutter_web
                        ));
                }
              }
            : null);
  }
}
