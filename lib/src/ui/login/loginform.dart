import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lsc/src/bloc/authentication/authentication_bloc.dart';
import 'package:lsc/src/bloc/authentication/authentication_event.dart';
import 'package:lsc/src/bloc/login/login_doc.dart';
import 'package:lsc/src/bloc/login/login_event.dart';
import 'package:lsc/src/bloc/login/login_state.dart';
import 'package:lsc/src/repository/user_repository.dart';
import 'package:lsc/src/ui/login/createacount.dart';
import 'package:lsc/src/ui/login/googlebuttom.dart';

import 'loginbuttom.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      // tres casos, tres if:
      if (state.isFailure) {
        Scaffold.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Login Failure'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
      if (state.isSubmitting) {
        Scaffold.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()

          // ignore: deprecated_member_use
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Logging in... '),
                CircularProgressIndicator(),
              ],
            ),
          ));
      }
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Form(
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 60),
                  decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.purple[300], Colors.purple[900]],
                          begin: FractionalOffset.bottomCenter,
                          end: FractionalOffset.topCenter)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 350),
                    child: Image.asset(
                      "assets/images/Logo.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -25),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 260, bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.email),
                                    labelText: 'Email'),
                                keyboardType: TextInputType.emailAddress,
                                autovalidate: true,
                                autocorrect: false,
                                validator: (_) {
                                  return !state.isEmailValid
                                      ? 'Invalid Email'
                                      : null;
                                },
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.lock),
                                    labelText: 'Contraseña'),
                                obscureText: true,
                                autovalidate: true,
                                autocorrect: false,
                                validator: (_) {
                                  return !state.isPasswordValid
                                      ? 'Invalid Password'
                                      : null;
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    // Tres botones:
                                    // LoginButton
                                    LoginButton(
                                      onPressed: isLoginButtonEnabled(state)
                                          ? _onFormSubmitted
                                          : null,
                                    ),
                                    // GoogleLoginButton
                                    GoogleLoginButton(),
                                    // CreateAccountButton
                                    CreateAccountButton(
                                      userRepository: _userRepository,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
