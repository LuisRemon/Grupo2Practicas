import 'package:flutter/material.dart';
import 'package:proyecto_sm/view/login_view.dart';
import 'package:proyecto_sm/viewmodel/login_viewmodel.dart';
import 'login.dart';

class MyAppSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePageSplash(),
    );
  }
}
class MyHomePageSplash extends StatefulWidget
{
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}
class _MyHomePageState extends State<MyHomePageSplash>
{
  @override
  void initState()
  { super.initState();
  _navigatetohome();
  }
  _navigatetohome() async
  {  await Future.delayed(const Duration(milliseconds: 2000), () {});
  final loginViewModel = LoginViewModel();

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LoginAppView()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B39EF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 294,
              height: 400,
              child: Image.asset('assets/images/logo_reservatech.png') ,
            ),
          ],
        ),
      ),
    );
  }
}