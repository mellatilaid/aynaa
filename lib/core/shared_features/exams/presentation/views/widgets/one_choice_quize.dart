import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/custom_progress_indicator.dart';
import 'package:atm_app/core/widgets/custom_action_button.dart';
import 'package:flutter/material.dart';

class OneChoiceQuize extends StatefulWidget {
  final List<QuestionEntity> questions;

  const OneChoiceQuize({required this.questions, super.key});

  @override
  _OneChoiceQuizeState createState() => _OneChoiceQuizeState();
}

class _OneChoiceQuizeState extends State<OneChoiceQuize> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final Map<int, String?> _selectedAnswers = {}; // Stores user's answers

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Quiz completed
      _showResults();
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showResults() {
    int correctAnswers = _selectedAnswers.entries
        .where((entry) => entry.value == widget.questions[entry.key].answer)
        .length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("نتيجتك"),
        content: Text(
            "لقد أجبت على $correctAnswers من ${widget.questions.length} بشكل صحيح!"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("موافق")),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentIndex + 1) / widget.questions.length;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomProgressIndicator(progress: progress),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics:
                const NeverScrollableScrollPhysics(), // Prevent manual swiping
            itemCount: widget.questions.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final question = widget.questions[index];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${index + 1}. ${question.question}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ...question.options.map((option) => RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: _selectedAnswers[index],
                          onChanged: (value) {
                            setState(
                              () {
                                _selectedAnswers[index] = value;
                              },
                            );
                          },
                        )),
                    const SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentIndex > 0)
                          CustomActionButton(
                            onPressed: _previousQuestion,
                            label: "السابق",
                          ),
                        CustomActionButton(
                          onPressed: _selectedAnswers[index] != null
                              ? _nextQuestion
                              : null,
                          label: index == widget.questions.length - 1
                              ? "إنهاء الاختبار"
                              : "التالي",
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
