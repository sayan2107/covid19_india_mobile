class PostLoginData {
  String userId;
  String password;

  PostLoginData({this.userId, this.password});

  PostLoginData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['password'] = this.password;
    return data;
  }
}
