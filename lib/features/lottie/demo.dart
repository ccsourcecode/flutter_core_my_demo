import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../design_system/app_colors.dart';
import 'LottieAppModel.dart';

class LottieApp extends HookWidget {
  const LottieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();

    return ViewModelBuilder<LottieAppModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcPrimaryColor,
        body: Center(
          // 1. Only navigate if the animation has completed
          child: Lottie.asset(
            'assets/lottie/bunny_new_mouth.json',
            controller: animationController,
            onLoaded: (composition) {
              // we need to know when the animation has completed
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  model.indicateAnimationComplete();
                }
              });

              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              animationController
                ..duration = composition.duration
                // start the animation
                ..forward();
            },
          ),
        ),
      ),
      // loading animation until the initialise function is complete.
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
      viewModelBuilder: () => LottieAppModel(),
    );
  }
}
