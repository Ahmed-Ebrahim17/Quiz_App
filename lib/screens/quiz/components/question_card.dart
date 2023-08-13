import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';

import '../../../constants.dart';
import '../../../models/Questions.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
  });
  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController questionContrller = Get.put(QuestionController());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.white),
        child: Column(children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: kBlackColor),
          ),
          ...List.generate(
            question.options.length,
            (index) => Option(
              text: question.options[index],
              index: index,
              press: () => questionContrller.checkAns(question, index),
            ),
          ),
        ]),
      ),
    );
  }
}
