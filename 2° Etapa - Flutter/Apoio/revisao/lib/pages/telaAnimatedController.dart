import 'package:flutter/material.dart';

class TelaAnimationController extends StatefulWidget {
  const TelaAnimationController({super.key});

  @override
  State<TelaAnimationController> createState() {
    return _TelaAnimationControllerState();
  }
}

class _TelaAnimationControllerState
    extends State<TelaAnimationController>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimationController'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}