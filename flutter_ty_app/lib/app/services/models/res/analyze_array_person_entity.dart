class AnalyzeArrayPersonEntity {
  String? homeFormation;
  String? awayFormation;
  List<Up>? up;
  List<Up>? down;
  List<Up>? layOff;
  AnalyzeArrayPersonEntity({this.homeFormation, this.up, this.down});

  AnalyzeArrayPersonEntity.fromJson(Map<String, dynamic> json) {
    homeFormation = json['homeFormation'];
    awayFormation = json['awayFormation'];

    if (json['up'] != null) {
      up = <Up>[];
      json['up'].forEach((v) {
        up!.add(new Up.fromJson(v));
      });
    }

    if (json['layOff'] != null) {
      layOff = <Up>[];
      json['layOff'].forEach((v) {
        layOff!.add(new Up.fromJson(v));
      });
    }


    if (json['down'] != null) {
      down = <Up>[];
      json['down'].forEach((v) {
        down!.add(new Up.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homeFormation'] = this.homeFormation;
    data['awayFormation'] = this.awayFormation;
    if (this.up != null) {
      data['up'] = this.up!.map((v) => v.toJson()).toList();
    }

    if (this.layOff != null) {
      data['layOff'] = this.layOff!.map((v) => v.toJson()).toList();
    }


    if (this.down != null) {
      data['down'] = this.down!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Up {
  static final int GRAY=0;
  static final int BLUE=1;
  static final int YELLOW=2;
  static final int RED=3;




  /**
   * 0  灰色
   * 1  蓝色
   * 2  黄色
   * 3  红色
   *
   */
  int? colorType;
  String? awayFormation;
  String? createTime;
  String? dataSourceCode;
  num? homeAway;
  String? homeFormation;
  String? id;
  num? invalid;
  String? matchInfoId;
  String? modifyTime;
  num? position;
  String? positionEnName;
  String? positionName;
  num? shirtNumber;
  String? sportId;
  num? substitute;
  String? thirdPlayerEnName;
  String? thirdPlayerName;
  String? thirdPlayerPicUrl;
  String? thirdPlayerSourceId;
  String? thirdTeamSourceId;

  String? playTime;
  String? assist;
  String? rebound;
  String? points;
  String? playerName;




  Up(
      {this.awayFormation,
        this.createTime,
        this.dataSourceCode,
        this.homeAway,
        this.homeFormation,
        this.id,
        this.invalid,
        this.matchInfoId,
        this.modifyTime,
        this.position,
        this.positionEnName,
        this.positionName,
        this.shirtNumber,
        this.sportId,
        this.substitute,
        this.thirdPlayerEnName,
        this.thirdPlayerName,
        this.thirdPlayerPicUrl,
        this.thirdPlayerSourceId,
        this.thirdTeamSourceId,
        this.playTime,
        this.assist,
        this.rebound,
        this.points,
        this.playerName
      });

  Up.fromJson(Map<String, dynamic> json) {
    awayFormation = json['awayFormation'];
    createTime = json['createTime'];
    dataSourceCode = json['dataSourceCode'];
    playerName = json['playerName'];

    homeAway = json['homeAway'];
    homeFormation = json['homeFormation'];
    id = json['id'];
    invalid = json['invalid'];
    matchInfoId = json['matchInfoId'];
    modifyTime = json['modifyTime'];
    position = json['position'];
    positionEnName = json['positionEnName'];
    positionName = json['positionName'];
    shirtNumber = json['shirtNumber'];
    sportId = json['sportId'];
    substitute = json['substitute'];
    thirdPlayerEnName = json['thirdPlayerEnName'];
    thirdPlayerName = json['thirdPlayerName'];
    thirdPlayerPicUrl = json['thirdPlayerPicUrl'];
    thirdPlayerSourceId = json['thirdPlayerSourceId'];
    thirdTeamSourceId = json['thirdTeamSourceId'];

    playTime = json['playTime'];
    assist = json['assist'];
    rebound = json['rebound'];
    points = json['points'];
    playerName = json['playerName'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['awayFormation'] = this.awayFormation;
    data['createTime'] = this.createTime;
    data['dataSourceCode'] = this.dataSourceCode;
    data['homeAway'] = this.homeAway;
    data['homeFormation'] = this.homeFormation;
    data['id'] = this.id;
    data['invalid'] = this.invalid;
    data['matchInfoId'] = this.matchInfoId;
    data['modifyTime'] = this.modifyTime;
    data['position'] = this.position;
    data['positionEnName'] = this.positionEnName;
    data['positionName'] = this.positionName;
    data['shirtNumber'] = this.shirtNumber;
    data['sportId'] = this.sportId;
    data['substitute'] = this.substitute;
    data['thirdPlayerEnName'] = this.thirdPlayerEnName;
    data['thirdPlayerName'] = this.thirdPlayerName;
    data['thirdPlayerPicUrl'] = this.thirdPlayerPicUrl;
    data['thirdPlayerSourceId'] = this.thirdPlayerSourceId;
    data['thirdTeamSourceId'] = this.thirdTeamSourceId;

    data['playTime'] = this.playTime;
    data['assist'] = this.assist;
    data['rebound'] = this.rebound;
    data['points'] = this.points;
    data['playerName'] = this.playerName;
    return data;
  }
}

