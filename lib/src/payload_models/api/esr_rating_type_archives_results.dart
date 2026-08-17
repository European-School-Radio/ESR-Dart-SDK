class ESRRatingTypeArchiveByUserArchiveResults {
  String status = "";
  List<bool> ratingTypeHasVote = [];
  List<double> ratingTypeVoteValue = [];
  List<int> ratingTypeVoteID = [];

  ESRRatingTypeArchiveByUserArchiveResults({
    required this.status,
    required this.ratingTypeHasVote,
    required this.ratingTypeVoteValue,
    required this.ratingTypeVoteID
  });

  factory ESRRatingTypeArchiveByUserArchiveResults.fromJson(Map<String, dynamic> json) {
    return ESRRatingTypeArchiveByUserArchiveResults(
      status: json['status'],
      ratingTypeHasVote: List<bool>.from(json['rating_type_has_vote'] ?? []),
      ratingTypeVoteValue: (json['rating_type_vote_value'] as List? ?? []).map((e) => (e as num).toDouble()).toList(),
      ratingTypeVoteID: List<int>.from(json['rating_type_vote_id'] ?? []),
    );
  }
}