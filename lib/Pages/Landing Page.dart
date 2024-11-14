import 'package:blog/Pages/Login%20Page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:blog/Widgets/AppWidget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Text(""),
            ),
            const SizedBox(height: 30),
            AppWidget.customTitle(text: 'Bienvenue sur BlogMaster'),
            const SizedBox(height: 10),
            Text(
              'Gérez facilement vos posts, suivez les interactions et connectez-vous avec votre audience.',
              style: AppWidget.customTextStyle(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Lottie.asset(
              'assets/json/Animation1.json',
              width: 350,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            AppWidget.customButton(
              text: 'Commencer',
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous avez déjà un compte?",
                  style: TextStyle(color: Colors.black87),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                  child: const Text(
                    "Connectez-vous",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
