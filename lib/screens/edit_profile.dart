import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uconverse/components/image_uploader.dart';
import 'package:uconverse/constants/color.dart';

import 'profile_screen.dart';

class EditProfile extends StatefulWidget {
  static const routeName = 'edit-profile';
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var obscure = true;
  XFile? selectedImage;

  void selectImage(XFile image) {
    setState(() {
      selectedImage = image;
    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var userDetails;
  var user = FirebaseAuth.instance.currentUser;
  var _isLoading = true;

  void loadProfileData() async {
    userDetails = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(
      () {
        _isLoading = false;
        _emailController.text = userDetails['email'];
        _usernameController.text = userDetails['username'];
      },
    );
  }

  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      loadProfileData();
    }
    setState(() {
      isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // snackbar
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

  Future<void> _updateProfile(BuildContext context) async {
    final valid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    if (!valid) {
      return;
    }

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${user!.uid}.jpg');
    File? file;
    if (selectedImage != null) {
      file = File(selectedImage!.path);
    }

    try {
      if (selectedImage != null) {
        await storageRef.putFile(file!);
      }
      var downloadLink = await storageRef.getDownloadURL();
      await user!.updateEmail(_emailController.text.trim());
      await user!.updatePassword(_passwordController.text.trim());
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'image': downloadLink,
        'login-mode': 'email',
      }).then(
          (value) => Navigator.of(context).pushNamed(ProfileScreen.routeName));
    } on FirebaseException catch (e) {
      showSnackBar('Error occurred! ${e.message}');
    } catch (e) {
      showSnackBar('Error occurred! $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    // var loginMode = Provider.of<UserData>(context, listen: false).loginMode;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Editing Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _updateProfile(context),
            icon: const Icon(
              Icons.check,
              color: primaryColor,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isLoading) ...[
                const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              ] else ...[
                ImageUploader(selectImage: selectImage),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: userDetails!['username'],
                          labelText: 'Username',
                          icon: const Icon(Icons.account_box),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username can not be empty!';
                          } else if (value.length < 3) {
                            return 'Username should be up 3 characters!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: userDetails!['email'],
                          labelText: 'Email',
                          icon: const Icon(
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
                      const SizedBox(height: 20),
                      TextFormField(
                        enableSuggestions: true,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        onFieldSubmitted: (value) {},
                        obscureText: obscure,
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: _passwordController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  icon: Icon(
                                    obscure
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
                            return 'Password can\'t be empty';
                          } else if (value.length < 8) {
                            return 'Password is not strong enough!';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
