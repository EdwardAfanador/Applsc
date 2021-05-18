import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  int vali;

  onExitFullScreen() {
    // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  final List<String> _ids = [
    'JMraBJsA9oI',
    "EOcVvy1mcYI",
    "q8j1aXIRCv8",
    "-8e3FaA-Rak",
  ];

  List<String> Canal = [
    'Felipe Betancur Ayudas para Todos',
    'Felipe Betancur Ayudas para Todos',
    'Felipe Betancur Ayudas para Todos',
    'Felipe Betancur Ayudas para Todos',
  ];

  List<String> titulo = [
    'Vocabulario Básico 1 - Abecedario Lengua de Señas Colombiana LSC',
    'Vocabulario Básico 2 - Lengua de Señas Colombiana LSC',
    'Vocabulario Básico 3 - Lengua de Señas Colombiana LSC',
    'Vocabulario Básico 4 - Verbos Curso Lengua de Señas Colombiana',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aprende'),
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple[300], Colors.purple[900]],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter)),
        child: Column(
          children: [
            Flexible(
                child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _ids.length,
                itemBuilder: (context, index) => Center(
                  child: ExpansionCard(
                    title: Row(
                      children: [
                        SizedBox(
                          width: 288,
                          child: Container(
                            child: YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: _ids[index],
                                  flags: YoutubePlayerFlags(
                                    autoPlay: false,
                                  )),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.white,
                              progressColors: ProgressBarColors(
                                  playedColor: Colors.white,
                                  handleColor: Colors.white70),
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      _space,
                      _text('Title', titulo[index]),
                      _space,
                      _text('Channel', Canal[index]),
                      _space,
                      _text('Video Id', _ids[index]),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

  void cargar() {
    _controller.load(
        _ids[(_ids.indexOf(_controller.metadata.videoId) - 1) % _ids.length]);
  }
}
