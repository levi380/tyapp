class AnalyzeVSInfoVersion3Entity {
	int? drawTotal;
	int? goalDiffTotal;
	int? goalsAgainstTotal;
	int? goalsForTotal;
	int? lossTotal;
	int? matchCount;
	int? matchGroup;
	String? matchesCompleted;
	int? pointsTotal;
	int? positionTotal;
	String? promotionCnName;
	String? promotionEnName;
	String? promotionId;
	String? rankingCnName;
	String? rankingEnName;
	String? rankingId;
	String? teamBadge;
	String? teamCnName;
	String? teamEnName;
	String? teamFlag;
	String? teamLogo;
	String? teamName;
	String? thirdTeamSourceId;
	Null totalMatches;
	String? tournamentName;
	int? tournamentType;
	int? winTotal;

	AnalyzeVSInfoVersion3Entity(
			{this.drawTotal,
				this.goalDiffTotal,
				this.goalsAgainstTotal,
				this.goalsForTotal,
				this.lossTotal,
				this.matchCount,
				this.matchGroup,
				this.matchesCompleted,
				this.pointsTotal,
				this.positionTotal,
				this.promotionCnName,
				this.promotionEnName,
				this.promotionId,
				this.rankingCnName,
				this.rankingEnName,
				this.rankingId,
				this.teamBadge,
				this.teamCnName,
				this.teamEnName,
				this.teamFlag,
				this.teamLogo,
				this.teamName,
				this.thirdTeamSourceId,
				this.totalMatches,
				this.tournamentName,
				this.tournamentType,
				this.winTotal});

	AnalyzeVSInfoVersion3Entity.fromJson(Map<String, dynamic> json) {
		drawTotal = json['drawTotal'];
		goalDiffTotal = json['goalDiffTotal'];
		goalsAgainstTotal = json['goalsAgainstTotal'];
		goalsForTotal = json['goalsForTotal'];
		lossTotal = json['lossTotal'];
		matchCount = json['matchCount'];
		matchGroup = json['matchGroup'];
		matchesCompleted = json['matchesCompleted'];
		pointsTotal = json['pointsTotal'];
		positionTotal = json['positionTotal'];
		promotionCnName = json['promotionCnName'];
		promotionEnName = json['promotionEnName'];
		promotionId = json['promotionId'];
		rankingCnName = json['rankingCnName'];
		rankingEnName = json['rankingEnName'];
		rankingId = json['rankingId'];
		teamBadge = json['teamBadge'];
		teamCnName = json['teamCnName'];
		teamEnName = json['teamEnName'];
		teamFlag = json['teamFlag'];
		teamLogo = json['teamLogo'];
		teamName = json['teamName'];
		thirdTeamSourceId = json['thirdTeamSourceId'];
		totalMatches = json['totalMatches'];
		tournamentName = json['tournamentName'];
		tournamentType = json['tournamentType'];
		winTotal = json['winTotal'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['drawTotal'] = this.drawTotal;
		data['goalDiffTotal'] = this.goalDiffTotal;
		data['goalsAgainstTotal'] = this.goalsAgainstTotal;
		data['goalsForTotal'] = this.goalsForTotal;
		data['lossTotal'] = this.lossTotal;
		data['matchCount'] = this.matchCount;
		data['matchGroup'] = this.matchGroup;
		data['matchesCompleted'] = this.matchesCompleted;
		data['pointsTotal'] = this.pointsTotal;
		data['positionTotal'] = this.positionTotal;
		data['promotionCnName'] = this.promotionCnName;
		data['promotionEnName'] = this.promotionEnName;
		data['promotionId'] = this.promotionId;
		data['rankingCnName'] = this.rankingCnName;
		data['rankingEnName'] = this.rankingEnName;
		data['rankingId'] = this.rankingId;
		data['teamBadge'] = this.teamBadge;
		data['teamCnName'] = this.teamCnName;
		data['teamEnName'] = this.teamEnName;
		data['teamFlag'] = this.teamFlag;
		data['teamLogo'] = this.teamLogo;
		data['teamName'] = this.teamName;
		data['thirdTeamSourceId'] = this.thirdTeamSourceId;
		data['totalMatches'] = this.totalMatches;
		data['tournamentName'] = this.tournamentName;
		data['tournamentType'] = this.tournamentType;
		data['winTotal'] = this.winTotal;
		return data;
	}
}
