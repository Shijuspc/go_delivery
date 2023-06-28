import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_delivery/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmpassword = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
              child: SizedBox(
                height: 250,
                width: 300,
                child: Image.asset('lib/image/signup.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 50, bottom: 10),
              child: TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Email";
                  }
                  if (!value.contains("@")) {
                    return "Enter Valid Email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('E-mail',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 94, 94, 1),
                          fontWeight: FontWeight.w500)),
                  contentPadding: EdgeInsets.only(left: 30),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(255, 94, 94, 1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(255, 94, 94, 1)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Password";
                  } else if (value.length < 6) {
                    return "atleast 6 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Password',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 94, 94, 1),
                          fontWeight: FontWeight.w500)),
                  contentPadding: EdgeInsets.only(left: 30, right: 30),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(255, 94, 94, 1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(255, 94, 94, 1)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 30),
              child: TextFormField(
                controller: confirmpassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Confirm Password";
                  }
                  if (value != password.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Confirm Password',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 94, 94, 1),
                          fontWeight: FontWeight.w500)),
                  contentPadding: EdgeInsets.only(left: 30, right: 30),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(255, 94, 94, 1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(255, 94, 94, 1)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45,
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color.fromRGBO(255, 94, 94, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an account? "),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 94, 94, 1),
                      ),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
