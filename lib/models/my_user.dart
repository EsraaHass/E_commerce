class MyUser {
  static const routeName = 'myUsers';

  String id;
  String email;

  MyUser({required this.id, required this.email});

  MyUser.fromFireStore(Map<String, dynamic> data, String documentId)
      : this(
          id: documentId,
          email: data['email'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': email,
    };
  }
}
