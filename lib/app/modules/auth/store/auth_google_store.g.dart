// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_google_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$isLoggedAtom =
      Atom(name: '_UserStore.isLogged', context: context);

  @override
  bool get isLogged {
    _$isLoggedAtom.reportRead();
    return super.isLogged;
  }

  @override
  set isLogged(bool value) {
    _$isLoggedAtom.reportWrite(value, super.isLogged, () {
      super.isLogged = value;
    });
  }

  late final _$userNameAtom =
      Atom(name: '_UserStore.userName', context: context);

  @override
  String? get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String? value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_UserStore.userEmail', context: context);

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$userPhotoUrlAtom =
      Atom(name: '_UserStore.userPhotoUrl', context: context);

  @override
  String? get userPhotoUrl {
    _$userPhotoUrlAtom.reportRead();
    return super.userPhotoUrl;
  }

  @override
  set userPhotoUrl(String? value) {
    _$userPhotoUrlAtom.reportWrite(value, super.userPhotoUrl, () {
      super.userPhotoUrl = value;
    });
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  void setUserDetails(
      {required String name, required String email, required String photoUrl}) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setUserDetails');
    try {
      return super.setUserDetails(name: name, email: email, photoUrl: photoUrl);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.logout');
    try {
      return super.logout();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogged: ${isLogged},
userName: ${userName},
userEmail: ${userEmail},
userPhotoUrl: ${userPhotoUrl}
    ''';
  }
}
