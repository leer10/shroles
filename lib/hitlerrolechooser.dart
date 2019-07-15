main() {
  Game game = Game();
  //game.addPlayer("Bob", Role.liberal);
  //game.PlayerList[0].role = "Liberal";
  //print(game.PlayerList.last.role.toString());
  exampleplayers(game, 6);
  game.radicalCentristExists = true; // set to true to allow radical centrists in 6 player games
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
  //for (var player in game.PlayerList) {
  //  print("Is $player marked? ${player.marked}");
  //}
  print("The first player, ${game.PlayerList[0].name} (${game.PlayerList[0].roleString}), can see these people:");
  if (game.viewOthers(game.PlayerList[0]).isNotEmpty){
  for (var player in game.viewOthers(game.PlayerList[0]).entries) {print("${player.key.name} as a ${player.value}");}}
  else {print("Nobody");}
}

void printplayersandroles(Game game) {
  print("There are ${game.PlayerList.length} players.");
  for (var player in game.PlayerList){print("$player: ${player.roleString}${(player.marked) ? " MARKED" : ""}");}
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

  Map<Player, String> viewOthers (Player player) {
    Map<Player, String> _viewList = {};
    if (player.isFascist) {
      for (var fascist in FascistList.where((_aPlayer) => _aPlayer != player)) {
        _viewList[fascist] = fascist.roleString;
      }
      if (okayToKnowHitler == false){
        //_viewList.removeWhere((player) => player.role == Role.hitler); //haha
        // misunderstood the mechanics
        if (player.role == Role.hitler){
          _viewList.clear();
        }
      }
    }
    if (player.role == Role.radicalcentrist) {
      print(PlayerList.where((_aPlayer1) => _aPlayer1.marked == true));
      for (var _aPlayer in PlayerList.where((_aPlayer1) => _aPlayer1.marked == true)){
        _viewList[_aPlayer] = "player on one of the sides";
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
        if ((PlayerList.length == 6) && radicalCentristExists){
          roleshuffle.remove(Role.liberal);
          roleshuffle.add(Role.radicalcentrist);
        }
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
      if ((PlayerList.length == 6) && radicalCentristExists) {
        List<Player>_randomLiberalList = LiberalList.toList();
        _randomLiberalList.shuffle();
        Player _markedLiberal =_randomLiberalList.first;
        _markedLiberal.marked = true;
        //print(_markedLiberal.name + " is a marked liberal");
        PlayerList.firstWhere((_aPlayer) => _aPlayer.role == Role.fascist).marked = true;
        //print(PlayerList.firstWhere((_aPlayer) => _aPlayer.marked).name + " is a marked fascist");
      }
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
  bool marked;
  Player(String name, [Role role]) {
    this.name = name;
    this.role = role;
    this.spoiled = false;
    this.marked = false;
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
