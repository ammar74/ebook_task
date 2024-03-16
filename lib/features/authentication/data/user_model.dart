class UserModel {
  String? id;
  String? email;
  String? password;
  bool isAdmin;
  bool isActivated;

  UserModel(
      {this.id,
      this.email,
      this.password,
      this.isAdmin = false,
      this.isActivated = false});
}
