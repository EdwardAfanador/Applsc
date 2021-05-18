import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lsc/src/bloc/words/words_bloc.dart';
import 'package:lsc/src/repository/wordrepository.dart';
import 'package:lsc/src/ui/body_app/homepage.dart';
import 'package:lsc/src/ui/body_app/search.dart';

class Home extends StatelessWidget {
  final wordrepository _wordrepository = wordrepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WordsBloc>(
        create: (context) =>
            WordsBloc(wordrepository: _wordrepository)..add(Loadword()),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Palabras"),
            backgroundColor: Colors.purple[900],
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Search()),
                  );
                  //showSearch(context: context, delegate: WordSearchDelegate());
                  //BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              )
            ],
          ),
          body: HomePage(),
        ));
  }
}
