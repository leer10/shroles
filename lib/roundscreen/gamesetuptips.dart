import 'package:flutter_web/material.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';

class GameSetupTipsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Setup Tips")),
      body: GameSetupContent()
    );
  }

}

class GameSetupContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("For the MacGyvering Fascist in you.", textAlign: TextAlign.center, style:TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
      ),
      InfoCard(
        title: "Note",
        info : [
          "Please buy the official Secret Hitler game if you can to support the creators",
          "If you cannot, you can also use their official Print and Play PDFs on their website",
          "At worst, use the info below to help you set up an impromptu version"
        ]
      ),
      InfoCard(
        title: "Policy Cards",
        info: [
            "For a regular game of Secret Hitler, 6 Liberal cards and 11 Fascist cards are needed.",
        ],
      ),
      InfoCard(
        title: "Liberal Track",
        info: [
          "Liberals win when they fill all their spaces, or if they kill Hitler.",
          "Hint: there are as many liberal cards in the deck as there are spaces in the track.",
        ],
        trailing: [
          TrackWidget(
            row1: [
              PolicySpace(color: Colors.blue,),
              PolicySpace(color: Colors.blue,),
              PolicySpace(color: Colors.blue,),
            ],
            row2: [
              PolicySpace(color: Colors.blue,),
              PolicySpace(color: Colors.blue,),
              PolicySpace(color: Colors.blue, text: "Liberals Win"),
            ],
          ),
        ],
      ),
      InfoCard(
        title: "Fascist Track",
        info: [
          "Fascists must fill the track in order to win, OR make Hitler an elected chancellor after 3 facsist cards have been played.",
          "When a fascist card is played, it is the President's responsibility to enact the policy. It must be followed.",
          "An alternative to 6 player balancing is to place a fascist card at the beginning of the game",
        ],
        trailing: [
          TrackWidget(
            title: "5-6 Players",
            row1: [
              PolicySpace(color: Colors.red,),
              PolicySpace(color: Colors.red,),
              PolicySpace(color: Colors.red, text: "Policy Peek"),
            ],
            row2: [
              PolicySpace(color: Colors.red, text: "Kill a player"),
              PolicySpace(color: Colors.red, text: "Kill a player\n\nVeto Unlocked"),
              PolicySpace(text: "Fascists Win", color: Colors.red),
            ]
          ),
          TrackWidget(
            title: "7-8 Players",
            row1: [
              PolicySpace(color: Colors.red,),
              PolicySpace(color: Colors.red, text: "Loyalty Check"),
              PolicySpace(color: Colors.red, text: "President picks next candidate"),
            ],
            row2: [
              PolicySpace(color: Colors.red, text: "Kill a player"),
              PolicySpace(color: Colors.red, text: "Kill a player\n\nVeto Unlocked"),
              PolicySpace(text: "Fascists Win", color: Colors.red),
            ]
          ),
          TrackWidget(
            title: "9-10 Players",
            row1: [
              PolicySpace(color: Colors.red, text: "Loyalty Check"),
              PolicySpace(color: Colors.red, text: "Loyalty Check"),
              PolicySpace(color: Colors.red, text: "President picks next candidate"),
            ],
            row2: [
              PolicySpace(color: Colors.red, text: "Kill a player"),
              PolicySpace(color: Colors.red, text: "Kill a player\n\nVeto Unlocked"),
              PolicySpace(text: "Fascists Win", color: Colors.red),
            ]
          ),
        ],
      ),
      InfoCard(
        title: "Voting",
        info: [
          "Ja (Yes) and Nein (No) cards help the entire group make a consensus without taksies-backsies"
        ]
      ),
      InfoCard(
        title: "President and Chancellor Placards",
        info: ["These mark who is the President(ial candidate) and their (would-be) Chancellor.",
            ]
      ),
      InfoCard(
        title: "Role Cards",
        info: [
          "These aren't really needed in this setting since the app will introduce each player to their role and do the night phase for them.",
          "Players are handed an envelope with two cards. The first one declares their Role, and a second one shows if they're a member of the Fascist or Liberal party."
        ]
      ),
    ]);
  }
}

class TrackWidget extends StatelessWidget{
  final String title;
  final List<Widget> row1;
  final List<Widget> row2;
  final Color color;
  TrackWidget({this.title, @required this.row1, @required this.row2, this.color});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          if (title != null)
          Text(title, textAlign:TextAlign.center , style: TextStyle(fontSize: 18),),
          Table(
            defaultColumnWidth: FixedColumnWidth(75),
            children: [
              TableRow(
                children: row1
              ),
              TableRow(
                children: row2
              ),
            ]
          ),
        ],
      ),
    );
  }

}

class PolicySpace extends StatelessWidget{
  final Color color;
  final Widget child;
  final String text;
  PolicySpace({this.color, this.child, this.text});
  @override
  Widget build(BuildContext context) {
    Widget content;
    if ((child != null) && (text != null)){
      content = Column(children: [child, Text(text, textAlign: TextAlign.center,)]);
    }
    else if (child != null) {
      content = child;
    } else if (text != null) {
      content = Text(text, textAlign: TextAlign.center,);
    } else {content = null;}
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(height: 100, child: Center(child: content), color: color ?? Colors.grey),
    );
  }

}

class InfoCard extends StatelessWidget {
  final String title;
  final List<String> info;
  final List<Widget> trailing;
  InfoCard({@required this.title, this.info, this.trailing});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card( child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(title, textAlign:TextAlign.center , style: TextStyle(fontSize: 24),),
            //if (!kIsWeb)
            //Divider(indent:25, endIndent: 25,),
            //if (kIsWeb) // eventually use above code when endIndent is supported by flutter_web
            Divider(),
            if (info != null)
            for (String infobite in info)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(infobite,
                textAlign:TextAlign.justify,
               ),
            ),
            if (trailing != null)
            ...trailing,
          ],
        ),
      )),
    );
  }

}
