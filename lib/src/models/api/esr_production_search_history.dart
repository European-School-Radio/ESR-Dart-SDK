class ESRProductionSearchHistory {
  int id = 0;
  String model = "";
  String searchTerm = "";

  ESRProductionSearchHistory({
    required this.id,
    required this.model,
    required this.searchTerm
  });

  factory ESRProductionSearchHistory.fromJson(Map<String, dynamic> json){
    return ESRProductionSearchHistory(
      id: json['id'],
      model: json['model'],
      searchTerm: json['search_term']
    );
  }
}