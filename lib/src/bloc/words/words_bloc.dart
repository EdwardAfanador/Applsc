import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lsc/src/model/words.dart';
import 'package:lsc/src/repository/wordrepository.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  final wordrepository _wordrepository;

  WordsBloc({@required wordrepository wordrepository})
      : assert(wordrepository != null),
        _wordrepository = wordrepository;

  @override
  WordsState get initialState => WordLoading();

  @override
  Stream<WordsState> mapEventToState(
    WordsEvent event,
  ) async* {
    if (event is Loadword) {
      yield* _maploadwordtostate();
    }
  }

  Stream<WordsState> _maploadwordtostate() async* {
    yield WordLoading();
    try {
      final List<words> word = await _wordrepository.getwords().first;
      yield WordLoaded(word);
    } catch (_) {
      yield WordNoLoaded();
    }
  }
}
