import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/Questions.dart';
import 'package:quiz_app/screens/score/score_screen.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Animation? _animation;
  AnimationController? _animationController;

  Animation? get animation => _animation;
  PageController? _pageController;

  PageController get pageController => _pageController!;
  final List<Question> _questions = sample_data
      .map((question) => Question(
          id: question['id'],
          question: question['question'],
          answer: question['answer_index'],
          options: question['options']))
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswered = false;

  bool get isAnswered => _isAnswered;

  int? _correctAns;

  int get correctAns => _correctAns!;

  int? _selectedAns;

  int get selectedAns => _selectedAns!;

  final RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => _numOfCorrectAns;
  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      _animationController!.reset();
      _animationController!.forward().whenComplete((nextQuestion));
    } else {
      Get.to(const ScorePage());
    }
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        update();
      });

    _animationController!.forward().whenComplete((nextQuestion));

    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    _animationController?.stop();
    update();

    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void updateQheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
