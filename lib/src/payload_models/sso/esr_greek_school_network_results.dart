class ESRGreekSchoolNetworkGetCallbackResults {
  String status = "";
  String url = "";

  ESRGreekSchoolNetworkGetCallbackResults({
    required this.status,
    required this.url
  });

  factory ESRGreekSchoolNetworkGetCallbackResults.fromJson(Map<String, dynamic> json){
    return ESRGreekSchoolNetworkGetCallbackResults(
      status: json['status'],
      url: json['url']
    );
  }
}

class ESRGreekSchoolNetworkGetLogoutResults {
  String status = "";
  String url = "";

  ESRGreekSchoolNetworkGetLogoutResults({
    required this.status,
    required this.url
  });

  factory ESRGreekSchoolNetworkGetLogoutResults.fromJson(Map<String, dynamic> json){
    return ESRGreekSchoolNetworkGetLogoutResults(
      status: json['status'],
      url: json['url']
    );
  }
}