import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uconverse/constants/color.dart';
import '../screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'AuthScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _obscure = true;
  bool isSignIn = true;
  var _isLoading = false;

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: primaryColor,
        ),
      ),
      backgroundColor: accentColor,
      action: SnackBarAction(
        onPressed: () => Navigator.of(context).pop(),
        label: 'Dismiss',
        textColor: buttonColor,
      ),
    ));
  }

  // google auth
  Future<UserCredential> _googleauth() async {
    setState(() {
      _isLoading = true;
    });

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      await FirebaseFirestore.instance
          .collection('users')
          .doc(googleUser!.id)
          .set({
        "email": googleUser.email,
        "username": googleUser.displayName,
        "image": googleUser.photoUrl,
        "login-mode": 'google',
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!);
    } catch (e) {
      showSnackBar('An error occured. Try again!');
    }

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  // facebook auth
  Future<UserCredential> _facebookauth() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );
    setState(() {
      _isLoading = true;
    });
    if (loginResult.status == LoginStatus.success) {
      Map<String, dynamic> user;
      final userData = FacebookAuth.instance.getUserData();
      user = await userData;

      if (user['email'] != "") {
        // sending credential to firebase when email account is associated
        await FirebaseFirestore.instance
            .collection('users')
            .doc(loginResult.accessToken!.userId)
            .set(
          {
            "username": user['name'],
            "email": user['email'],
            "image": user['picture']['data']['url'],
            "login-mode": 'facebook',
          },
        );
      } else {
        showSnackBar(
          'No email assigned to facebook account! Account can not be used',
        ); // showSnackBar will show error if any
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      showSnackBar(loginResult.message!); // showSnackBar will show error if any
      setState(() {
        _isLoading = false;
      });
    }

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // email password authentication (signin and signup)
  void _authSign(BuildContext context) async {
    final valid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!valid) {
      return;
    }
    _formKey.currentState!.save();
    // ignore: unused_local_variable
    UserCredential credential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isSignIn) {
        // signin
        credential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // signup
        credential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // sending username and email to firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          "username": _usernameController.text.trim(),
          "email": _emailController.text.trim(),
          "image": '',
          "login-mode": 'email',
        });
      }
    } on FirebaseAuthException catch (e) {
      var error = 'An error occured. Check credentials!';
      if (e.message != null) {
        error = e.message!;
      }

      showSnackBar(error); // showSnackBar will show error if any
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      setState(() {
        _isLoading = false;
      });
    }
    // ...
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
                    child: Column(
                      children: const [
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
                      ],
                    ),
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
                      padding: const EdgeInsets.only(
                        top: 170,
                        right: 10,
                        left: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!_isLoading) ...[
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
                              onPressed: () => setState(
                                () {
                                  isSignIn = !isSignIn;
                                  _emailController.clear();
                                  _usernameController.clear();
                                  _passwordController.clear();
                                },
                              ),
                              child: Text(
                                isSignIn ? 'SIGN UP' : 'SIGN IN',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: accentColor,
                                ),
                              ),
                            )
                          ] else ...[
                            const CircularProgressIndicator(color: primaryColor)
                          ]
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              isSignIn ? 'Signin Account' : 'Signup Account ',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              autofocus: isSignIn ? true : false,
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
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Enter valid email address!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: isSignIn ? 0 : 20),
                            !isSignIn
                                ? TextFormField(
                                    textInputAction: TextInputAction.next,
                                    autofocus: true,
                                    controller: _usernameController,
                                    decoration: const InputDecoration(
                                      hintText: 'placeholder',
                                      labelText: 'Username',
                                      icon: Icon(Icons.account_box),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Username can not be empty!';
                                      } else if (value.length < 3) {
                                        return 'Username should be up 3 characters!';
                                      }
                                      return null;
                                    },
                                  )
                                : const Text(''),
                            SizedBox(height: isSignIn ? 0 : 20),
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
                                } else if (value.length < 8) {
                                  return 'Password is not strong enough!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () => _authSign(context),
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
                              children: [
                                GestureDetector(
                                  onTap: () => _facebookauth(),
                                  child: const Chip(
                                    elevation: 2,
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      2,
                                      85,
                                      153,
                                    ),
                                    label: Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => _googleauth(),
                                  child: const Chip(
                                    elevation: 2,
                                    backgroundColor: buttonColor,
                                    label: Icon(
                                      Icons.g_mobiledata,
                                      color: Colors.white,
                                    ),
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
            ),
          )
        ],
      ),
    );
  }
}
