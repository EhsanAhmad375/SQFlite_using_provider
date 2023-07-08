import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widget/TextFeildCustom.dart';
import 'package:sqflite_provider/View/Register.dart';
import 'package:sqflite_provider/Provider/Data_provider.dart';

class Login extends StatelessWidget {
   Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Consumer<DataProvider>(
          builder: (context,dataProvider,child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFeildCustom(hintText: 'e-mail Adress',textController:dataProvider.emailController,),
                SizedBox(height: 15,),
                TextFeildCustom(hintText: 'Password',textController: dataProvider.passwordController,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Register()));
                  }, child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('Register'),
                  ))
                ],),
                SizedBox(height: 25,),
                 ElevatedButton(onPressed: (){
                      dataProvider.login(dataProvider.emailController.text, dataProvider.passwordController.text, context);
                    }, child: Text('Login'))
                  
                
              ],
            );
          }
        ),
      ),
    );
  }
}