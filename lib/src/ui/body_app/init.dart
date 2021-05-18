import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lsc/src/bloc/authentication/authentication_bloc.dart';
import 'package:lsc/src/bloc/authentication/authentication_event.dart';
import 'package:lsc/src/ui/body_app/Aprende.dart';
import 'package:lsc/src/ui/body_app/Curiosidades.dart';
import 'package:lsc/src/ui/body_app/home.dart';

class initial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 60),
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple[300], Colors.purple[900]],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: ExpansionCard(
                        title: Row(
                          children: [
                            Text(
                              "Palabras",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: RaisedButton(
                                    color: Color.fromRGBO(24, 6, 2, 0.5),
                                    child: Text('Ver mas',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        )),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    }),
                              ),
                            ],
                          )
                        ],
                        background: Image.network(
                            "https://media.giphy.com/media/6AEYizERoB17i/giphy.gif"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: ExpansionCard(
                        title: Row(
                          children: [
                            Text(
                              "Curiosidades",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                                color: Color.fromRGBO(24, 6, 2, 0.5),
                                child: Text('Ver mas',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Curiosidades()),
                                  );
                                }),
                          ),
                        ],
                        background: Image.network(
                            "https://media.giphy.com/media/14w6a2el22HMek/giphy.gif"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: ExpansionCard(
                        title: Row(
                          children: [
                            Text(
                              "Aprende",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RaisedButton(
                                color: Color.fromRGBO(24, 6, 2, 0.5),
                                child: Text('Ver mas',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                  );
                                }),
                          ),
                        ],
                        background: Image.network(
                            "https://media.giphy.com/media/D6UkkERfVZx1S/giphy.gif"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: ExpansionCard(
                        title: Row(
                          children: [
                            Text(
                              "Salir",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RaisedButton(
                                color: Color.fromRGBO(24, 6, 2, 0.5),
                                child: Text('Salir',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedOut());
                                }),
                          ),
                        ],
                        background: Image.network(
                            "https://media.giphy.com/media/3D3Rb2IhQeeqzttVZZ/giphy.gif"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
