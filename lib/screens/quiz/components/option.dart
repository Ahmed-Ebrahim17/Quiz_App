import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';

import '../../../constants.dart';

class Option extends StatelessWidget {
  const Option({
    super.key,
    required this.text,
    required this.index,
    required this.press,
  });
  final String text;
  final int index;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (index == qnController.correctAns) {
                return kGreenColor;
              } else if (index == qnController.selectedAns &&
                  index != qnController.correctAns) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          return InkWell(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: kDefaultPadding),
              decoration: BoxDecoration(
                border: Border.all(color: getTheRightColor()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${index + 1}. $text',
                      style: const TextStyle(color: kGrayColor, fontSize: 16),
                    ),
                    Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        color: getTheRightColor() == kGrayColor
                            ? Colors.transparent
                            : getTheRightColor(),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: getTheRightColor(),
                        ),
                      ),
                      child: getTheRightColor() == kGrayColor
                          ? null
                          : Icon(
                              getTheRightIcon(),
                              size: 16,
                            ),
                    ),
                  ]),
            ),
          );
        });
  }
}
