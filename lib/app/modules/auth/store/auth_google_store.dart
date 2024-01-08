import 'package:mobx/mobx.dart';

part 'auth_google_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  bool isLogged = false;

  @observable
  String? userName;

  @observable
  String? userEmail;

  @observable
  String? userPhotoUrl;

  @action
  void setUserDetails(
      {required String name, required String email, required String photoUrl}) {
    userName = name;
    userEmail = email;
    userPhotoUrl = photoUrl;
    isLogged = true;
  }

  @action
  void logout() {
    userName = null;
    userEmail = null;
    userPhotoUrl = null;
    isLogged = false;
  }
}
