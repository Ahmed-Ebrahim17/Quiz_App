import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/quiz/components/progress_bar.dart';
import 'package:quiz_app/screens/quiz/components/question_card.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
    return Stack(
      children: [
        WebsafeSvg.asset('assets/icons/bg.svg', fit: BoxFit.fill),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              const SizedBox(
                height: kDefaultPadding / 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                        text:
                            'Question ${questionController.questionNumber.value}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: kSecondaryColor),
                        children: [
                          TextSpan(
                              text: '/${questionController.questions.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: kSecondaryColor))
                        ]),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Expanded(
                  child: PageView.builder(
                controller: questionController.pageController,
                itemCount: questionController.questions.length,
                onPageChanged: questionController.updateQheQnNum,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => QuestionCard(
                  question: questionController.questions[index],
                ),
              )),
            ],
          ),
        )
      ],
    );
  }
}
