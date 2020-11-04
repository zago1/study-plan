class User {
  int _id;
  String _email;
  String _password;
  String _name;

  User(this._email, this._password, this._name);

  User.withId(this._id, this._email, this._password, this._name);

  User.fromMap(map) {
    this._id = map["id"];
    this._email = map["email"];
    this._password = map["password"];
    this._name = map["name"];
  }

  int get id => _id;
  String get email => _email;
  String get name => _name;
  String get password => _password;

  set name(String newName) {
    if (newName.length > 0) {
      this._name = newName;
    }
  }

  set email(String newEmail) {
    if (newEmail.length > 0) {
      this._email = newEmail;
    }
  }

  set password(String newPassword) {
    if (newPassword.length > 0) {
      this._password = newPassword;
    }
  }

  toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map["id"] = _id;
    }

    map["email"] = _email;
    map["name"] = _name;
    map["password"] = _password;
    return map;
  }
}
