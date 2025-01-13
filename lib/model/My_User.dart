class MyUser {
  static const String collectionName = 'users';
  String? id;
  String? userName;
  String? fullName;
  String? email;

  MyUser({this.id, this.userName, this.fullName, this.email});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          userName: data['userName'],
          fullName: data['fullName'],
          email: data['email'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "userName": userName,
      "fullName": fullName,
      "email": email
    };
  }
}
