class AuthData {
  AuthData({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
  });
  late final String token;
  late final String refreshToken;
  late final int expiresAt;

  AuthData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['expiresAt'] = expiresAt;
    return data;
  }
}
