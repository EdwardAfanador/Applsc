
import 'package:flutter/material.dart';
import 'package:lsc/src/repository/user_repository.dart';
import 'package:lsc/src/ui/register/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
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
          child: Text("¿No estas registrado?"),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Registrarse'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return RegisterScreen(
                userRepository: _userRepository,
              );
            }));
          },
        ),
      ],
    );
  }
}
