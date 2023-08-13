import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          WebsafeSvg.asset('assets/icons/bg.svg', fit: BoxFit.fill),
          Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              Text(
                'Score',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: kSecondaryColor),
              ),
              const Spacer(),
              Text(
                '${questionController.numOfCorrectAns * 10}/${questionController.questions.length * 10}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: kSecondaryColor),
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
