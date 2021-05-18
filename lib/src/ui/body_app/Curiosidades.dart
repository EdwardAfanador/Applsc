import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class Curiosidades extends StatefulWidget {
  Curiosidades({Key key}) : super(key: key);

  @override
  _CuriosidadesState createState() => _CuriosidadesState();
}

class _CuriosidadesState extends State<Curiosidades> {
  final List<String> _links = [
    "https://www.eltiempo.com/vida/educacion/curiosidades-de-la-lengua-de-senas-185256",
    "https://www.eltiempo.com/tecnosfera/novedades-tecnologia/centro-de-relevo-de-mintic-el-call-center-de-las-personas-con-discapacidad-auditiva-150866",
    "https://www.fenascol.org.co/cursos-lsc/",
    "https://cultura-sorda.org/tag/lsc/",
    "https://www.insor.gov.co/home/la-lengua-de-senas-colombiana-hace-parte-del-patrimonio-inmaterial-cultural-y-linguistico-del-pais/",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Curiosidades'),
          backgroundColor: Colors.purple[900],
        ),
        body: Container(
          width: double.infinity,
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple[300], Colors.purple[900]],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter)),
          child: ListView.builder(
              itemCount: _links.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 10.0,
                  margin: EdgeInsets.all(14.0),
                  child: Column(children: [
                    SizedBox(
                      height: 250,
                      child: AnyLinkPreview(
                        link: _links[index],
                      ),
                    ),
                  ]),
                );
              }),
        ));
  }
}
