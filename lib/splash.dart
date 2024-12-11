import 'package:flutter/material.dart';
import 'package:student_with_getx/screens/show_student.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    hold(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage(
                'assets/aluno.jpeg',
                ),
                fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LinearProgressIndicator(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  hold(BuildContext context)async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ShowStudent()));
  }
}