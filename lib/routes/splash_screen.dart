// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_locale_app/db/database.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isError = false;

  @override
  void initState() {
    initDB();
    super.initState();
  }

  void initDB() async {
    var db = await DatabaseHelper.instance.initDb();
    if (db.isOpen) {
      await Future.delayed(Duration(seconds: 2, milliseconds: 500), () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/home");
      });
    } else {
      setState(() {
        isError = !isError;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Возникли технические неполадки'),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, toolbarHeight: 0),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Lottie.asset(
                        isError
                            ? "lib/assets/splash/Error.json"
                            : "lib/assets/splash/TaskLoader.json",
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
