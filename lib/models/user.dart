class User {
  String _userName;
  String _password;
  int _id;

  User(this._userName, this._password);

  User.map(dynamic obj) {
    this._userName = obj['username'];
    this._password = obj['password'];
    this._id = obj['id'];
  }

  String get userName => _userName;
  String get password => _password;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['username'] = _userName;   
    map['password'] = _password;   
    
    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._userName = map['username'];
    this._password = map['password'];
    this._id = map['id'];
  }
}