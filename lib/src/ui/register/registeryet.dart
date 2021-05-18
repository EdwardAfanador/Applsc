import 'package:flutter/material.dart';
import 'package:lsc/src/repository/user_repository.dart';
import 'package:lsc/src/ui/login/loginscreen.dart';

class yetAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  yetAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text("¿Ya esta registrado?"),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Iniciar Sesion'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginScreen(
                userRepository: _userRepository,
              );
            }));
          },
        ),
      ],
    );
  }
}
