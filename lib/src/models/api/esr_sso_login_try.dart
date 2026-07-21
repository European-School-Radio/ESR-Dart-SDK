class ESRSSOLoginTry {
  int id = 0;
  String ssoModel = "";
  String firstName = "";
  String lastName = "";
  String username = "";
  String email = "";
  String phoneNumber = "";
  String ssoRolePosition = "";
  String ssoProfileUrl = "";
  int errorCode = 0;
  String ipAddress = "";
  String userAgent = "";
  bool fromMobile = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRSSOLoginTry({
    required this.id,
    required this.ssoModel,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.ssoRolePosition,
    required this.ssoProfileUrl,
    required this.errorCode,
    required this.ipAddress,
    required this.userAgent,
    required this.fromMobile,
    required this.created,
    required this.updated,
  });

  factory ESRSSOLoginTry.fromJson(Map<String, dynamic> json){
    return ESRSSOLoginTry(
      id: json['id'],
      ssoModel: json['sso_model'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      ssoRolePosition: json['sso_role_position'],
      ssoProfileUrl: json['sso_profile_url'],
      errorCode: json['error_code'],
      ipAddress: json['ip_address'],
      userAgent: json['user_agent'],
      fromMobile: json['from_mobile'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}