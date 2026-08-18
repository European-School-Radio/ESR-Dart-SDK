class ESRSchoolSearchHistory {
  int id = 0;
  String searchTerm = "";

  ESRSchoolSearchHistory({
    required this.id,
    required this.searchTerm
  });

  factory ESRSchoolSearchHistory.fromJson(Map<String, dynamic> json){
    return ESRSchoolSearchHistory(
      id: json['id'],
      searchTerm: json['search_term']
    );
  }
}