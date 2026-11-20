class RewardStatus {
  const RewardStatus({
    required this.points,
    required this.rankLabel,
    required this.showRank,
    required this.pointsPerReport,
    required this.nextRank,
    required this.pointsToNextRank,
  });

  final int points;
  final String rankLabel;
  final bool showRank;
  final int pointsPerReport;
  final String? nextRank;
  final int pointsToNextRank;

  factory RewardStatus.fromJson(Map<String, dynamic> json) => RewardStatus(
    points: json['points'] as int,
    rankLabel: json['rank_label'] as String,
    showRank: json['show_rank'] as bool,
    pointsPerReport: json['points_per_report'] as int,
    nextRank: json['next_rank'] as String?,
    pointsToNextRank: json['points_to_next_rank'] as int,
  );
}
