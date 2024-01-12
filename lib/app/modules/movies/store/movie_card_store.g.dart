// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_card_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieCardState on _MovieCardState, Store {
  late final _$isFavoritedAtom =
      Atom(name: '_MovieCardState.isFavorited', context: context);

  @override
  bool get isFavorited {
    _$isFavoritedAtom.reportRead();
    return super.isFavorited;
  }

  @override
  set isFavorited(bool value) {
    _$isFavoritedAtom.reportWrite(value, super.isFavorited, () {
      super.isFavorited = value;
    });
  }

  late final _$isUserAuthenticatedAtom =
      Atom(name: '_MovieCardState.isUserAuthenticated', context: context);

  @override
  bool get isUserAuthenticated {
    _$isUserAuthenticatedAtom.reportRead();
    return super.isUserAuthenticated;
  }

  @override
  set isUserAuthenticated(bool value) {
    _$isUserAuthenticatedAtom.reportWrite(value, super.isUserAuthenticated, () {
      super.isUserAuthenticated = value;
    });
  }

  late final _$_MovieCardStateActionController =
      ActionController(name: '_MovieCardState', context: context);

  @override
  void toggleFavorite() {
    final _$actionInfo = _$_MovieCardStateActionController.startAction(
        name: '_MovieCardState.toggleFavorite');
    try {
      return super.toggleFavorite();
    } finally {
      _$_MovieCardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFavorited: ${isFavorited},
isUserAuthenticated: ${isUserAuthenticated}
    ''';
  }
}
