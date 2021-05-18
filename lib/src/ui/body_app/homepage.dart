import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lsc/src/bloc/words/words_bloc.dart';
import 'package:lsc/src/model/words.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<words> wordsList = [];

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();

    Future _speak(String text) async {
      await flutterTts.setLanguage("es-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }

    return BlocBuilder<WordsBloc, WordsState>(builder: (context, state) {
      if (state is WordLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is WordNoLoaded) {
        return Center(
          child: Column(
            children: <Widget>[Icon(Icons.error), Text('Cannot load words')],
          ),
        );
      }
      if (state is WordLoaded) {
        wordsList = state.word;
        return Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purple[300], Colors.purple[900]],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter)),
            child: wordsList.length == 0
                ? Center(
                    child: Text('No Blog Avaliable'),
                  )
                : ListView.builder(
                    itemCount: wordsList.length,
                    itemBuilder: (_, index) {
                      return Card(
                        elevation: 10.0,
                        margin: EdgeInsets.all(14.0),
                        child: Container(
                          padding: EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    wordsList[index].palabra,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Image.network(
                                wordsList[index].urlimagen,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 250),
                                    child: Text(
                                      wordsList[index].desc,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(CupertinoIcons.volume_up),
                                      onPressed: () => _speak(
                                          wordsList[index].desc.toString()))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
      }
      return Container();
    });
  }
}
