class UserProfile {
  const UserProfile({
    required this.username,
    required this.roleLabel,
    required this.email,
    required this.points,
    required this.rankLabel,
    required this.showRank,
  });

  final String username;
  final String roleLabel;
  final String email;
  final int points;
  final String rankLabel;
  final bool showRank;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    username: json['username'] as String,
    roleLabel: json['role_label'] as String,
    email: json['email'] as String? ?? '',
    points: json['points'] as int,
    rankLabel: json['rank_label'] as String,
    showRank: json['show_rank'] as bool,
  );
}
