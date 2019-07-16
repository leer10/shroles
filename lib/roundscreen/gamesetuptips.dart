import 'package:flutter/material.dart';
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
        title: "Policy Cards",
        info: [
            "For a regular game of Secret Hitler, 6 Liberal cards and 11 Fascist cards are needed.",
            "You may use cards specifically for the game, or just borrow playing cards of two different fronts but the same backs. Uno™ Red and Blue cards work well for this."
        ],
      ),
      InfoCard(
        title: "Liberal Track",
        info: [
          "This is where you put the enacted Liberal Policies.",
          "There should be six spaces: 2 rows and 3 columns.",
          "All spaces should be empty except for the last, which is the Liberal Win space.",
          "If you have experienced players, you may choose to use your 🌈imagination🌈."
        ]
      ),
      InfoCard(
        title: "Fascist Track",
        info: [
          "Same as above, but for fascist policies.",
          "Whilst there are six total spaces, there are different setups depending on the players:",
          "5-6 Players: Blank, Blank, Policy Peek, Kill, Kill (Veto Unlock), Fascist Win",
          "7-8 Players: Blank, Loyalty Check, President selects next Presidential Candidate, Kill, Kill (Veto Unlock), Fascist Win",
          "9-10 Players: Loyalty Check, Loyalty Check, President selects next Presidential Candidate, Kill, Kill (Veto Unlock), Fascist Win",
          "If you have experienced players, you may choose to use your 🌈imagination🌈."
        ]
      ),
      InfoCard(
        title: "Voting",
        info: [
          "Cards with two different fronts but the same back. For example Uno™ yellow (no) and green (yes) cards work well in this case.",
          "In a pinch, a mass thumbs-up/thumbs-down works to settle the matter."
        ]
      ),
      InfoCard(
        title: "President and Chancellor Placards",
        info: ["There needs to be two distinct objects to mark who is the President(ial candidate) and their (would-be) Chancellor.",
              "You may use either the official placards, or folded pieces of paper labeled \"President\" and \"Chancellor\" or even two different items.",
            ]
      ),
      InfoCard(
        title: "Role Cards",
        info: [
          "These aren't really needed in this setting since the app will introduce each player to their role and do the night phase for them.",
          "Using the offical cards is easiest if you wanna go physical.",
          "If you really wanna use cards and don't have the official ones, then an Uno™ deck has enough cards for policies, voting cards, and roles."
        ]
      ),
    ]);
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final List<String> info;
  InfoCard({@required this.title, this.info});
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
            if (!kIsWeb)
            Divider(indent:25, endIndent: 25,),
            if (kIsWeb)
            Divider(),
            if (info != null)
            for (String infobite in info)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(infobite,
                textAlign:TextAlign.justify,
               ),
            ),
          ],
        ),
      )),
    );
  }

}
