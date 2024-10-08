import 'package:flutter/material.dart';
class AccountPage extends StatelessWidget{
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Icon(Icons.account_circle, size: 200.0),
            SizedBox(height: 10,),
            Text("Даниил Столяров", style: TextStyle(
              fontSize: 22
            ),),
            SizedBox(height: 10,),
            Text("22T0318@gmail.com"),
            SizedBox(height: 10,),
            Text("+79876543210"),
            SizedBox(height: 20,),
            TextButton(onPressed: (){}, child: Text("Сменить пароль", style: TextStyle(fontSize: 18),),),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox.expand(child: TextButton(onPressed: (){}, child: Text("Выйти", style: TextStyle(fontSize: 18),),))
      ],
    );
  }
}