import 'package:comfystay/components/PageRouteBuilder.dart';
import 'package:comfystay/screen/auth/Register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 193, 49, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () => {Get.toNamed('/home')},
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Transform.rotate(
            angle: 1.55,
            child: const Text(
              "D",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 140,
              ),
              Center(child: Image.asset('assets/images/yellow.png')),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Find Your \nPerfect Stay",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("From cozy PGs to Lavish Villas"),
              Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: () => {
                            Navigator.push(
                              context,
                              CustomPageRoute(page: const OnBoarding2()),
                            ),
                          },
                      child: _button()))
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.arrow_right_sharp,
        size: 50,
      ),
    );
  }
}

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(121, 212, 217, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [],
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Transform.rotate(
            angle: 1.55,
            child: const Text(
              "D",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 140,
              ),
              Center(child: Image.asset('assets/images/blue.png')),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Your Comfort \nOur Priority",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Get The Best From Us"),
              Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: (){
                        Get.toNamed('/register');
                      },
                      child: _button()))
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.arrow_right_sharp,
        size: 50,
      ),
    );
  }
}
