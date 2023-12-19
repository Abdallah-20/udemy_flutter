import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: emailController,
                    label: 'Email',
                    prefix: Icons.email,

                    type: TextInputType.text,
                    validate: (String? value)
                    {
                      if (value!.isEmpty)
                      {
                        print("email must not be empty");
                        return 'email must not be empty';
                      }
                      print("email not empty");

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    label: 'Password',
                    prefix: Icons.lock,
                    suffix:
                    isPassword2 ? Icons.visibility : Icons.visibility_off,
                    isPassword: isPassword2,
                    suffixPressed: () {
                      setState(() {
                        isPassword2 = !isPassword2;
                      });
                    },
                    type: TextInputType.visiblePassword,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        String a = 'password is too short';
                        print(a);
                        return a;
                      }
                      print("2");
                      // return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    text: 'login',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
