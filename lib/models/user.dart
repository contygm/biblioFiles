class User {
  /* Fields */
  String id;
  String username;
  String email;
  String photoURL;

  /* Constructors */
  User(this.id, this.username, this.email, this.photoURL);

  factory User.fromJson(Map<dynamic, dynamic> record) {
    return User(
        record['id'], record['username'], record['email'], record['photoURL']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'photoURL': photoURL,
      };

  /* Getters */
  String get userId {
    return id;
  }

  String get userUsername {
    return username != null ? username : '';
  }

  String get userEmail {
    return email != null ? email : '';
  }

  String get userPhotoURL {
    return photoURL != null ? photoURL : '';
  }

  /* Setters */

  set userId(String newValue) {
    id = newValue;
  }

  set userUsername(String newValue) {
    username = newValue;
  }

  set userEmail(String newValue) {
    email = newValue;
  }

  set userPhotoURL(String newValue) {
    photoURL = newValue;
  }
}
