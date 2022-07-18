import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uconverse/constants/color.dart';
import '../screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'AuthScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _obscure = true;
  bool isSignIn = true;

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        
      });
    });
    super.initState();
  }

  void _authSign(
    String email,
    String username,
    String password,
    BuildContext context,
  ) {
    var valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    }
    if (isSignIn) {
      // signin
    } else {
      // signup
    }
    // ...
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .65,
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70, bottom: 20),
                    child: Column(children: const [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/images/uconverse.jpg',
                        ),
                      ),
                      Text(
                        'Uconverse',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        '...conversing without limits',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .35,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        99,
                      ),
                      topRight: Radius.circular(
                        120,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 170, right: 10, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isSignIn
                                ? 'Don\'t have an account?'
                                : 'Already have an account?',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () => setState(() {
                              isSignIn = !isSignIn;
                            }),
                            child: Text(
                              isSignIn ? 'SIGN UP' : 'SIGN IN',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: accentColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .35,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            isSignIn ? 'Signin Account' : 'Signup Account ',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          !isSignIn
                              ? TextFormField(
                                  textInputAction: TextInputAction.next,
                                  autofocus: true,
                                  controller: _usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: 'placeholder',
                                    labelText: 'Username',
                                    icon: Icon(Icons.account_box),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Username can not be empty!';
                                    }
                                    return null;
                                  },
                                )
                              : const Text(''),
                          SizedBox(height: isSignIn ? 0 : 20),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'placeholder@gmail.com',
                              labelText: 'Email',
                              icon: Icon(
                                Icons.email,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email can not be empty!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onFieldSubmitted: (value) {},
                            obscureText: _obscure,
                            textInputAction: TextInputAction.done,
                            autofocus: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: _passwordController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscure = !_obscure;
                                        });
                                      },
                                      icon: Icon(
                                        _obscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    )
                                  : const Text(''),
                              hintText: '********',
                              labelText: 'Password',
                              icon: const Icon(
                                Icons.key,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password can not be empty!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => _authSign(
                              _emailController.text,
                              _usernameController.text,
                              _passwordController.text,
                              context,
                            ),
                            child: Card(
                              color: accentColor,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 80,
                                ),
                                child: Text(
                                  isSignIn ? 'Sign in' : 'Sign up',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('OR'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Chip(
                                elevation: 2,
                                backgroundColor:
                                    Color.fromARGB(255, 2, 85, 153),
                                label: Icon(
                                  Icons.facebook,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Chip(
                                elevation: 2,
                                backgroundColor: buttonColor,
                                label: Icon(
                                  Icons.g_mobiledata,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
