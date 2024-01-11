import 'package:mobx/mobx.dart';

part 'movie_card_store.g.dart';

class MovieCardState = _MovieCardState with _$MovieCardState;

abstract class _MovieCardState with Store {
  @observable
  bool isFavorited = false;

  @observable
  bool isUserAuthenticated = false;

  @action
  void toggleFavorite() {
    isFavorited = !isFavorited;
  }
}
