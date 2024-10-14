class Account {
  Account(this.id, this.name, this.email, this.phoneNumber);
  int id;
  String name;
  String email;
  String phoneNumber;

  Map<String, Object?> toMap() {
        return {
          'name': name,
          'email': email,
          'phoneNumber' : phoneNumber
        };
      }
  static Account fromMap(Map<String, Object?> objectMap)
   {
    return Account(objectMap['id'] as int, objectMap['name'] as String, objectMap['email'] as String, objectMap['phoneNumber'] as String);
  }
}