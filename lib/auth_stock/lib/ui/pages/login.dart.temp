import 'package:flutter/material.dart';
import '../../model/user_repository.dart';
import '../widgets/auth_dialog.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _authVisible;
  int _selectedTab;

  @override
  void initState() {
    super.initState();
    _authVisible = false;
    _selectedTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    UserRepository user = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
            ),
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: kToolbarHeight),
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.display2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Frank"),
              ),
              Text(
                "Our awesome login app",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        elevation: 0,
                        highlightElevation: 0,
                        child: Text("Login"),
                        onPressed: () => setState(() {
                          _authVisible = true;
                          _selectedTab = 0;
                        }),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: OutlineButton(
                        textColor: Colors.white,
                        child: Text("Signup"),
                        onPressed: () => setState(() {
                          _authVisible = true;
                          _selectedTab = 1;
                        }),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              OutlineButton(
                textColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                borderSide: BorderSide(color: Colors.red),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Continue with Google"),
                    const SizedBox(width: 10.0),
                    Text("G"),
                  ],
                ),
                onPressed: () async {
                  if (!await user.signInWithGoogle())
                    _key.currentState.showSnackBar(SnackBar(
                      content: Text("Something is wrong"),
                    ));
                },
              ),
              OutlineButton(
                textColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                borderSide: BorderSide(color: Colors.white),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Skip login"),
                    const SizedBox(width: 10.0),
                    Icon(
                      Icons.arrow_forward,
                      size: 16.0,
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 10.0),
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _authVisible
                ? Container(
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AuthDialog(
                        selectedTab: _selectedTab,
                        onClose: () {
                          setState(() {
                            _authVisible = false;
                          });
                        },
                      ),
                    ),
                  )
                : null,
          )
        ],
      ),
    );
  }
}
