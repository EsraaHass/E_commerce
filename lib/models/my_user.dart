class MyUser {
  static const routeName = 'myUsers';

  String? id;
  String? email;

  MyUser({this.id, this.email});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          email: data['email'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': email,
    };
  }
}
