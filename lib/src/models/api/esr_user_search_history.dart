class ESRUserSearchHistory {
  int id = 0;
  String searchTerm = "";

  ESRUserSearchHistory({
    required this.id,
    required this.searchTerm
  });

  factory ESRUserSearchHistory.fromJson(Map<String, dynamic> json){
    return ESRUserSearchHistory(
      id: json['id'],
      searchTerm: json['search_term']
    );
  }
}