// ignore_for_file: non_constant_identifier_names

class User {
  int Id = 0;
  bool IsAdmin = false;
  String Email = '';
  String Password = '';
  String PhoneNumber = '';
  String FacebookLink = '';
  String TwitterLink = '';
  String AboutMe = '';

  User(this.Id, this.IsAdmin, this.Email, this.Password, this.PhoneNumber,
      this.FacebookLink, this.TwitterLink, this.AboutMe);

  User.fromJson(Map<String, dynamic> userMap) {
    Id = userMap['id'] ?? 0;
    IsAdmin = userMap['isAdmin'] ?? false;
    Email = userMap['email'] ?? '';
    Password = userMap['password'] ?? '';
    PhoneNumber = userMap['phoneNumber'] ?? '';
    FacebookLink = userMap['facebookLink'] ?? '';
    TwitterLink = userMap['twitterLink'] ?? '';
    AboutMe = userMap['aboutMe'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'isAdmin': IsAdmin,
        'email': Email,
        'password': Password,
        'phoneNumber': PhoneNumber,
        'facebookLink': FacebookLink,
        'twitterLink': TwitterLink,
        'aboutMe': AboutMe
      };
}
