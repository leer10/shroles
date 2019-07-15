main() {
  Game game = Game();
  //game.addPlayer("Bob", Role.liberal);
  //game.PlayerList[0].role = "Liberal";
  //print(game.PlayerList.last.role.toString());
  exampleplayers(game, 5);
  game.assignroles();
  print("Is the first player fascist? ${game.PlayerList[0].isFascist}");
  print("Is Brandon in the game? ${game.containsPlayer("Brandon")}");
  print("There are currently ${game.FascistList.length} fascists.");
  print("There are currently ${game.LiberalList.length} liberals.");
  print(game.PlayerList);
  print("The liberals are:");
  print(game.LiberalList);
  print("The fascists are:");
  print(game.FascistList);
  printplayersandroles(game);
  print("The Hitler is: ${game.hitler}");
  print("The first player, ${game.PlayerList[0].name} (${game.PlayerList[0].roleString}), can see these people:");
  if (game.PlayerList[0].isFascist){
  for (var player in game.viewOthers(game.PlayerList[0])) {print("${player.name} as a ${player.roleString}");}}
  else {print("Nobody");}
}

void printplayersandroles(Game game) {
  print("There are ${game.PlayerList.length} players.");
  for (var player in game.PlayerList){print("$player: ${player.roleString}");}
}

void exampleplayers(Game game, int number) {
  List<String> someplayers = [
    "Brandon",
    "Ashley",
    "Artist Alex",
    "Athlete Alex",
    "Evan",
    "Skylar",
    "Mike",
    "Sage",
    "Dannie",
    "Becca"
  ];
  someplayers.shuffle();
  for (var i = 0; i < number; i++) {
    game.addPlayer(someplayers[i]);
  }
}

class Game {
  List<Player> PlayerList = [];
  bool isSpoiled = false;
  bool okayToKnowHitler;
  bool radicalCentristExists = false;
  List<Player> get LiberalList {
    return PlayerList.where((player) => player.isLiberal == true).toList();
  }

  List<Player> viewOthers (Player player) {
    List<Player> _viewList;
    if (player.isFascist) {
      _viewList = FascistList.where((_aPlayer) => _aPlayer != player).toList();
      if (okayToKnowHitler == false){
        //_viewList.removeWhere((player) => player.role == Role.hitler); //haha
        // misunderstood the mechanics
        if (player.role == Role.hitler){
          _viewList.clear();
        }
      }
    }
    return _viewList;
  }
  List<Player> get FascistList {
    return PlayerList.where((player) => player.isFascist == true).toList();
  }

  void addPlayer(String name, [Role role]) {
    PlayerList.add(Player(name, role));
  }

  void deletePlayer(Player player){
    PlayerList.remove(player);
  }

  void wipePlayers(){
    PlayerList.clear();
  }

  bool containsPlayer(String name) {
    if (fetchPlayer(name) != null) {
      return true;
    } else {
      return false;
    }
  }

  Player fetchPlayer(String name) {
    try {
      return PlayerList.firstWhere((player) => player.name == name);
    } on StateError {
      return null;
    }
  }

  bool get readyToPlay {
    if ((PlayerList.length < 11) && (PlayerList.length > 4)) {
      return true;
    } else {
      return false;
    }
  }

  Player get hitler {
    return PlayerList.firstWhere((player) => player.role == Role.hitler);
  }

  void assignroles() {
    if (readyToPlay) {
      List<Role> roleshuffle = [Role.hitler, Role.fascist];
      for (var i = 0; i < ((PlayerList.length + 2) ~/ 2); i++) {
        // Adds liberals
        // so that 5 players: 3 liberals, 6 & 7 players: 4 liberals,
        // 7 & 8 players: 5 liberals, 9 and 10 players: 6 liberals
        roleshuffle.add(Role.liberal);
      }
      if (PlayerList.length <= 6) {
        okayToKnowHitler = true;
      } else {
        okayToKnowHitler = false;
      }
      if (PlayerList.length >= 7) {
        roleshuffle.add(Role.fascist);
      }
      if (PlayerList.length >= 9) {
        roleshuffle.add(Role.fascist);
      }
      assert(PlayerList.length == roleshuffle.length);
      roleshuffle.shuffle();
      for (var player in PlayerList){player.role = roleshuffle.removeLast();}
    } else {
      print("not enough players!");
    }
  }
}

enum Role { liberal, fascist, hitler, radicalcentrist }

class Player {
  String name;
  Role role;
  bool spoiled;
  bool isDead;
  Player(String name, [Role role]) {
    this.name = name;
    this.role = role;
    this.spoiled = false;
  }
  bool get isFascist {
    switch (this.role) {
      case Role.fascist:
      case Role.hitler:
        return true;
      case Role.liberal:
      case Role.radicalcentrist:
        return false;
    }
  }

  String get roleString {
    switch (this.role) {
      case Role.fascist:
        return "Fascist";
      case Role.hitler:
        return "Hitler";
      case Role.liberal:
        return "Liberal";
      case Role.radicalcentrist:
        return "Radical Centrist";
    }
  }

  bool get isLiberal {
    return !this.isFascist;
  }

  @override
  String toString() {
    return this.name;
  }
}
