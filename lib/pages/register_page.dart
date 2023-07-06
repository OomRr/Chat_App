import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';
class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});
    static String id='registerPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
    String? email,password;
    GlobalKey<FormState>formKey=GlobalKey();
    bool isLoading=false;
    @override
    Widget build(BuildContext context) {
      return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
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
                        Text('Register',
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
                    CustomButton(text: 'Register',
                      onTap: ()async {
                      if(formKey.currentState!.validate()){
                        setState(() {
                          isLoading=true;
                        });
                        try
                        {
                          await registerUser();
                          Navigator.pushNamed(context,ChatPage.id,arguments: email);
                        }
                        on FirebaseAuthException catch (e)
                        {
                          if(e.code=='weak-password')
                          {
                          showSnackBar(context,'weak password');
                          }
                          else if(e.code=='email-already-in-use')
                          {
                            showSnackBar(context, 'The email address is already in use by another account');
                          }
                        }
                        setState(() {
                          isLoading=false;
                        });
                        }
                      }
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Text(
                            ' Sign in',
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
        ),
      );
    }
    Future<void> registerUser() async {
      var auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(email: email!,
        password: password!,);
    }

}
