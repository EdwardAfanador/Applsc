import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lsc/src/ui/util/datacontroller.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchcontroller = TextEditingController();
  QuerySnapshot snapshotData;
  FlutterTts flutterTts = FlutterTts();
  SpeechToText _speechToText = SpeechToText();
  bool _islistening = false;

  Future _speak(String text) async {
    await flutterTts.setLanguage("es-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  bool isexecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchData() {
      return Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple[300], Colors.purple[900]],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter)),
        child: ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 10.0,
              margin: EdgeInsets.all(14.0),
              child: Container(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          snapshotData.docs[index].get("Palabra"),
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Image.network(
                      snapshotData.docs[index].get("urlimage"),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text(
                            snapshotData.docs[index].get("desc"),
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                            icon: Icon(CupertinoIcons.volume_up),
                            onPressed: () => _speak(snapshotData.docs[index]
                                .get("desc")
                                .toString()))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              val.queryData(searchcontroller.text).then((value) {
                snapshotData = value;
                setState(() {
                  isexecuted = true;
                });
              });
              return Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchcontroller.text = "";
                        setState(() {
                          isexecuted = false;
                        });
                      }),
                  IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.mic), onPressed: () => funcionlisten()),
                ],
              );
            },
          )
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
              hintText: "Buscar", hintStyle: TextStyle(color: Colors.white)),
          controller: searchcontroller,
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: isexecuted
          ? searchData()
          : Container(
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple[300], Colors.purple[900]],
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter)),
              child: Center(
                child: Text("Buscar Palabras"),
              ),
            ),
    );
  }

  void funcionlisten() async {
    if (!_islistening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print("onStatus : $val"),
        onError: (val) => print("onError : $val"),
      );

      print(available.toString());

      if (available) {
        setState(() {
          _islistening = true;
        });
        _speechToText.listen(
            onResult: (val) => setState(() {
                  searchcontroller.text = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _islistening = false;
        _speechToText.stop();
      });
    }
  }
}
