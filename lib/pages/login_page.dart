import 'package:chat_app_version_one/pages/chat_page.dart';
import 'package:chat_app_version_one/pages/register_page.dart';
import 'package:chat_app_version_one/widgets/custom_button.dart';
import 'package:chat_app_version_one/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../helper/snackbar.dart';

class LonginPage extends StatefulWidget {
  LonginPage({super.key});
  static String id='LoginPage';

  @override
  State<LonginPage> createState() => _LonginPageState();
}

class _LonginPageState extends State<LonginPage> {
  String? email,password;

  bool isLoading=false;
  bool isShow=false;

  GlobalKey<FormState>formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset('assets/images/scholar.png'),
                const Text('Scholar Chat',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  children: const [
                    Text('Sign in',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                CustomTextFormField(hintText: 'Username',
                  onChanged: (data){
                  email=data;
                  },
                ),
                const SizedBox(height: 10,),
                CustomTextFormField(hintText: 'Password',
                  pass: true,
                  onChanged: (data){
                  password=data;
                  },
                ),
                const SizedBox(height: 10,),
                CustomButton(text: 'Sign in',
                onTap: ()async{
                  if(formKey.currentState!.validate())
                    {
                      setState(() {
                        isLoading=true;
                      });
                      try
                          {
                            await loginUser();
                            Navigator.pushNamed(context,ChatPage.id,arguments: email);
                          }
                          on FirebaseAuthException catch (e)
                          {

                                showSnackBar(context,e.code);
                          }
                    }
                },
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        ' register',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth
        .signInWithEmailAndPassword(email: email!,
      password: password!,);
  }
}
