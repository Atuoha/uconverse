import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uconverse/components/image_uploader.dart';
import 'package:uconverse/constants/color.dart';
import 'package:uconverse/screens/profile_screen.dart';

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
  File? selectedImage;

  void selectImage(File image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _updateProfile(
    String email,
    String username,
    String password,
    BuildContext context,
  ) {
    var valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    }

    // ...
    Navigator.of(context).pushNamed(ProfileScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

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
            onPressed: () {},
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
              ImageUploader(selectImage: selectImage),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
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
                          return 'Username can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
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
                          return 'Email can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
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
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _updateProfile(
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
                            'Update Profile',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
