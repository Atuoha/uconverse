import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uconverse/constants/color.dart';

class EditProfile extends StatefulWidget {
  static const routeName = 'edit-profile';
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var obscure = true;
  final _formkey = FormState();
  File? image;

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
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child:
                    // image != null? Image.file(image!.path):
                    Image.asset(
                  'assets/images/default.png',
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                // key:,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      controller: usernameController,
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
                      controller: emailController,
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
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: passwordController.text.isNotEmpty
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
