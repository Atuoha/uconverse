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
  // final _formkey = FormState();
  File? image;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    Future avatarSource() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
            child: Text(
              'Select Avatar Source',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              label: const Text(
                'From Camera',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(Icons.camera),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              label: const Text(
                'From Gallery',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(Icons.photo),
            ),
          ],
        ),
      );
    }

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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child:
                    // image != null? Image.file(image!.path):
                    Image.asset(
                  'assets/images/default.png',
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: avatarSource,
                label: const Text(
                  'Change Avatar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.camera),
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
