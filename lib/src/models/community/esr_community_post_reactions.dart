class ESRCommunityPostReactions{
  int? lolReactionID;
  int? likeReactionID;
  int? joyReactionID;
  int? coolReactionID;
  int? badReactionID;
  int? angerReactionID;
  int? amazedReactionID;

  ESRCommunityPostReactions({
    this.lolReactionID,
    this.likeReactionID,
    this.joyReactionID,
    this.coolReactionID,
    this.badReactionID,
    this.angerReactionID,
    this.amazedReactionID
  });

  factory ESRCommunityPostReactions.fromJson(Map<String, dynamic> json){
    if (json["status"] == "error"){
      return ESRCommunityPostReactions();
    }
    return ESRCommunityPostReactions(
        lolReactionID: json["lol_reaction_meta_id"],
        likeReactionID: json["like_reaction_meta_id"],
        joyReactionID: json["joy_reaction_meta_id"],
        coolReactionID: json["cool_reaction_meta_id"],
        badReactionID: json["bad_reaction_meta_id"],
        angerReactionID: json["anger_reaction_meta_id"],
        amazedReactionID: json["amazed_reaction_meta_id"]
    );
  }
}