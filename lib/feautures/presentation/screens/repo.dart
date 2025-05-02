class AuthRepository {
  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return email == "admin@test.com" && password == "123456";
  }
}
