class User {
  final int idx;
  final String userId;
  final String password;
  final String nickname;

  User({
    required this.idx,
    required this.userId,
    required this.password,
    required this.nickname
  });

  Map<String, dynamic> toMap() {
    return {'idx': idx, 'user_id': userId, 'password': password, 'nickname': nickname};
  }
}