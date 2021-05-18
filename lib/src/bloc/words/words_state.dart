part of 'words_bloc.dart';

abstract class WordsState extends Equatable {
  const WordsState();

  @override
  List<Object> get props => [];
}
// Tres estados
// 1. Blog loading -> los posts del blog estan cargando
// 2. Blog loaded -> los posts del blog han cargado
// 3. Blog No loaded -> no se pudo cargar los posts

class WordLoading extends WordsState {
  @override
  String toString() => 'Blog Loading';
}

class WordLoaded extends WordsState {
  final List<words> word;

  const WordLoaded([this.word]);

  @override
  List<Object> get props => [words];

  @override
  String toString() => 'Blog loaded';
}

class WordNoLoaded extends WordsState {
  @override
  String toString() => 'Blog No Loaded';
}
