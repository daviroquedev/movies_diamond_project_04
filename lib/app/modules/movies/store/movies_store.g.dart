// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MoviesStore on _MoviesStore, Store {
  late final _$movieDetailsFutureAtom =
      Atom(name: '_MoviesStore.movieDetailsFuture', context: context);

  @override
  ObservableFuture<dynamic>? get movieDetailsFuture {
    _$movieDetailsFutureAtom.reportRead();
    return super.movieDetailsFuture;
  }

  @override
  set movieDetailsFuture(ObservableFuture<dynamic>? value) {
    _$movieDetailsFutureAtom.reportWrite(value, super.movieDetailsFuture, () {
      super.movieDetailsFuture = value;
    });
  }

  late final _$popularMoviesFutureAtom =
      Atom(name: '_MoviesStore.popularMoviesFuture', context: context);

  @override
  ObservableFuture<List<dynamic>>? get popularMoviesFuture {
    _$popularMoviesFutureAtom.reportRead();
    return super.popularMoviesFuture;
  }

  @override
  set popularMoviesFuture(ObservableFuture<List<dynamic>>? value) {
    _$popularMoviesFutureAtom.reportWrite(value, super.popularMoviesFuture, () {
      super.popularMoviesFuture = value;
    });
  }

  late final _$randomMoviesFutureAtom =
      Atom(name: '_MoviesStore.randomMoviesFuture', context: context);

  @override
  ObservableFuture<List<dynamic>>? get randomMoviesFuture {
    _$randomMoviesFutureAtom.reportRead();
    return super.randomMoviesFuture;
  }

  @override
  set randomMoviesFuture(ObservableFuture<List<dynamic>>? value) {
    _$randomMoviesFutureAtom.reportWrite(value, super.randomMoviesFuture, () {
      super.randomMoviesFuture = value;
    });
  }

  late final _$oldMoviesFutureAtom =
      Atom(name: '_MoviesStore.oldMoviesFuture', context: context);

  @override
  ObservableFuture<List<dynamic>>? get oldMoviesFuture {
    _$oldMoviesFutureAtom.reportRead();
    return super.oldMoviesFuture;
  }

  @override
  set oldMoviesFuture(ObservableFuture<List<dynamic>>? value) {
    _$oldMoviesFutureAtom.reportWrite(value, super.oldMoviesFuture, () {
      super.oldMoviesFuture = value;
    });
  }

  late final _$searchMoviesFutureAtom =
      Atom(name: '_MoviesStore.searchMoviesFuture', context: context);

  @override
  ObservableFuture<List<dynamic>>? get searchMoviesFuture {
    _$searchMoviesFutureAtom.reportRead();
    return super.searchMoviesFuture;
  }

  @override
  set searchMoviesFuture(ObservableFuture<List<dynamic>>? value) {
    _$searchMoviesFutureAtom.reportWrite(value, super.searchMoviesFuture, () {
      super.searchMoviesFuture = value;
    });
  }

  late final _$fetchMovieDetailsAsyncAction =
      AsyncAction('_MoviesStore.fetchMovieDetails', context: context);

  @override
  Future<dynamic> fetchMovieDetails(int movieId) {
    return _$fetchMovieDetailsAsyncAction
        .run(() => super.fetchMovieDetails(movieId));
  }

  late final _$fetchPopularMoviesAsyncAction =
      AsyncAction('_MoviesStore.fetchPopularMovies', context: context);

  @override
  Future<List<dynamic>> fetchPopularMovies() {
    return _$fetchPopularMoviesAsyncAction
        .run(() => super.fetchPopularMovies());
  }

  late final _$fetchRandomMoviesAsyncAction =
      AsyncAction('_MoviesStore.fetchRandomMovies', context: context);

  @override
  Future<List<dynamic>> fetchRandomMovies() {
    return _$fetchRandomMoviesAsyncAction.run(() => super.fetchRandomMovies());
  }

  late final _$fetchOldMoviesAsyncAction =
      AsyncAction('_MoviesStore.fetchOldMovies', context: context);

  @override
  Future<List<dynamic>> fetchOldMovies() {
    return _$fetchOldMoviesAsyncAction.run(() => super.fetchOldMovies());
  }

  late final _$searchMoviesAsyncAction =
      AsyncAction('_MoviesStore.searchMovies', context: context);

  @override
  Future<List<dynamic>> searchMovies(String query) {
    return _$searchMoviesAsyncAction.run(() => super.searchMovies(query));
  }

  @override
  String toString() {
    return '''
movieDetailsFuture: ${movieDetailsFuture},
popularMoviesFuture: ${popularMoviesFuture},
randomMoviesFuture: ${randomMoviesFuture},
oldMoviesFuture: ${oldMoviesFuture},
searchMoviesFuture: ${searchMoviesFuture}
    ''';
  }
}
