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
        lolReactionID: (json["lol_reaction_meta_id"] != null) ? int.parse(json["lol_reaction_meta_id"]) : null,
        likeReactionID: (json["like_reaction_meta_id"] != null) ? int.parse(json["like_reaction_meta_id"]) : null,
        joyReactionID: (json["joy_reaction_meta_id"] != null) ? int.parse(json["joy_reaction_meta_id"]) : null,
        coolReactionID: (json["cool_reaction_meta_id"] != null) ? int.parse(json["cool_reaction_meta_id"]) : null,
        badReactionID: (json["bad_reaction_meta_id"] != null) ? int.parse(json["bad_reaction_meta_id"]) : null,
        angerReactionID: (json["anger_reaction_meta_id"] != null) ? int.parse(json["anger_reaction_meta_id"]) : null,
        amazedReactionID: (json["amazed_reaction_meta_id"] != null) ? int.parse(json["amazed_reaction_meta_id"]) : null
    );
  }
}