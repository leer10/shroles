import 'package:flutter/material.dart';
import 'package:hitlerrolechooserflutter/main.dart';
import 'package:provider/provider.dart';
import 'package:hitlerrolechooserflutter/hitlerrolechooser.dart';
import 'package:hitlerrolechooserflutter/roundscreen/showallplayerswithrolesscreen.dart';


class RoleDescriptionScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Role Descriptions")),
      body: RoleDescriptionContent()
    );
  }

}

class RoleDescriptionContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Game game = Provider.of<GameState>(context).game;
    final List<RoleInfo> roleInfoList = buildRoleInfoList();
    return ListView.builder(
      itemCount: roleInfoList.length,
      itemBuilder: (context, index) {
        return RoleInfoWidget(roleInfoList[index]);}
    );}

}

List<RoleInfo> buildRoleInfoList() {
  List<RoleInfo> interimList = [];
  interimList.add(
    RoleInfo(
      role: Role.liberal,
      name: "Liberal",
      tips: [
        "Never give your Chancellor a choice between Liberal and Fascist cards",
        "Keep talking. Liberals win when information is shared",
        "Never claim to be a Fascist nor do anything that seems fashy"
      ],
      description: "Liberals are the good guys in the game. Identify your fellow liberals, pass as many Liberal policies as possible, don't elect facsists, and definitely don't elect Hitler.")
  );
  interimList.add(
    RoleInfo(
      role: Role.fascist,
      name: "Fascist",
      tips: [
        "Later in the game, throw Liberals under the bus by giving them two Fascist policies and claiming you gave them a choice.",

      ],
      description: "Create discord among the government and use that to enact Fascist policies as you can. Once 3 fascist policies are in place, try to install Hitler as Chancellor."
    )
  );
  interimList.add(
    RoleInfo(
      role: Role.hitler,
      name: "Hitler",
      tips: [
        "Play as Liberal as possible. This avoids you being scrutinized and can lead you being elected Chancellor.",
        "Cast attention to a Fascist friend if too much attention is put on you"
      ],
      description: "The leader of the Fascist team. Become Chancellor after 3 fascist polices have been passed. If you are killed, the Liberals win."
    )
  );
  interimList.add(
    RoleInfo(
      role: Role.radicalcentrist,
      name: "Radical Centrist",
      tips: [
        "Use your knowledge to quickly identify the Liberal and Fascist sides",
        "Pick a side to ally quickly, and shoot down Liberal governments when it's safe",
        "Other players may lie and claim to be you, or claim to be one of the revealed players",
      ],
      description: "Your loyalty is to yourself. You're given a name from the Liberal side and the Fascist side. You win if Liberals win after 5 Fascist policies have been passed. Any other way, you lose. (6 player rounds only)"
    )
  );
  return interimList;
}

class RoleInfoWidget extends StatelessWidget {
  final RoleInfo roleinfo;
  RoleInfoWidget(this.roleinfo);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(child: Container(child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(roleinfo.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), ),
              RoleLabel(role: roleinfo.role)
            ],
          ),
        ),
        if (roleinfo.description != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(roleinfo.description, textAlign: TextAlign.left ,),
        ),
        //if (roleinfo.tips != null)
        //Text("Tips", style:TextStyle(fontSize: 20)),
        if (roleinfo.tips != null)
        Divider(indent:24 ,endIndent: 24, ),
        if (roleinfo.tips != null)
        for (String tip in roleinfo.tips)  Padding(child: Text(tip, textAlign: TextAlign.center ,), padding: const EdgeInsets.all(4))
      ],
    )));
  }
}

class RoleInfo {
  String name, description;
  Role role;
  List<String> tips = [];
  RoleInfo({@required this.role, @required this.name, this.description, this.tips});
}
