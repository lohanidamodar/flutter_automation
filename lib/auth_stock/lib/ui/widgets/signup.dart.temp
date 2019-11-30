import 'package:flutter/material.dart';
import '../../model/user_repository.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  FocusNode _passwordField;
  FocusNode _confirmPasswordField;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserRepository user;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _confirmPassword = TextEditingController(text: "");
    _passwordField = FocusNode();
    _confirmPasswordField = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              key: Key("email-field"),
              controller: _email,
              validator: (value) =>
                  (value.isEmpty) ? "Please Enter Email" : null,
              decoration: InputDecoration(
                labelText: "Email",
              ),
              style: style,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_passwordField);
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              focusNode: _passwordField,
              key: Key("password-field"),
              controller: _password,
              obscureText: true,
              validator: (value) =>
                  (value.isEmpty) ? "Please Enter Password" : null,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              style: style,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_confirmPasswordField);
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              key: Key("confirm-password-field"),
              controller: _confirmPassword,
              obscureText: true,
              validator: (value) => (value.isEmpty)
                  ? "Please Enter Confirm Password"
                  : value.isNotEmpty && _password.text != _confirmPassword.text
                      ? "Passwords do not match"
                      : null,
              decoration: InputDecoration(
                labelText: "Confirm Password",
              ),
              style: style,
              focusNode: _confirmPasswordField,
              onEditingComplete: () => _signup(),
            ),
          ),
          SizedBox(height: 10.0),
          if (user.status == Status.Authenticating)
            Center(child: CircularProgressIndicator()),
          if (user.status != Status.Authenticating)
            Center(
              child: RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                onPressed: _signup,
                child: Text("Signup"),
              ),
            ),
        ],
      ),
    );
  }

  _signup() async {
    if (_formKey.currentState.validate()) {
      //signup user
      if (!await user.signup(_email.text, _password.text))
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(user.error),
        ));
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
