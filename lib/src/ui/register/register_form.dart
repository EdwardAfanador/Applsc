import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lsc/src/bloc/authentication/authentication_bloc.dart';
import 'package:lsc/src/bloc/authentication/authentication_event.dart';
import 'package:lsc/src/bloc/register/register_event.dart';
import 'package:lsc/src/bloc/register/register_state.dart';
import 'package:lsc/src/bloc/register/registerbloc.dart';
import 'package:lsc/src/repository/user_repository.dart';
import 'package:lsc/src/ui/register/register_button.dart';
import 'package:lsc/src/ui/register/registeryet.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Dos variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;
  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
      // Si estado es submitting
      if (state.isSubmitting) {
        Scaffold.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Registering'),
                CircularProgressIndicator()
              ],
            ),
          ));
      }
      // Si estado es success
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        Navigator.of(context).pop();
      }
      // Si estado es failure
      if (state.isFailure) {
        Scaffold.of(context)
          // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Registration Failure'),
                Icon(Icons.error)
              ],
            ),
            backgroundColor: Colors.red,
          ));
      }
    }, child: BlocBuilder<RegisterBloc, RegisterState>(
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
                  child: SingleChildScrollView(
                      child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 260, bottom: 20),
                    // Un textForm para email
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            controller: _emailController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (_) {
                              return !state.isEmailValid
                                  ? 'Invalid Email'
                                  : null;
                            },
                          ),
                          // Un textForm para password

                          TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock), labelText: 'Password'),
                            obscureText: true,
                            autocorrect: false,
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? 'Invalid Password'
                                  : null;
                            },
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                //Un button
                                RegisterButton(
                                  onPressed: isRegisterButtonEnabled(state)
                                      ? _onFormSubmitted
                                      : null,
                                ),
                                yetAccountButton(
                                  userRepository: _userRepository,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  void _onEmailChanged() {
    _registerBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
