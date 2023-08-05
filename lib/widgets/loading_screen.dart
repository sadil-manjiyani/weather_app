import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/widgets/space.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0x44ffffff),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Lottie.
                asset('assets/animations/weather_loading.json',
                height: 500,
                ),
              ),
              addVerticalSpace(30),
              const Text("Hold On ! While we load your Data",style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: textColorSecondary,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
