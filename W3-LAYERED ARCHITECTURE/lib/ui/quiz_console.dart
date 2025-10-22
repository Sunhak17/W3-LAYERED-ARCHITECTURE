import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write('Your name: ');
      String? userName = stdin.readLineSync();

      if (userName == null || userName.isEmpty) {
        {
          print('--- Quiz Finished ---');
          break;
        }
      }

      quiz.resetAnswers();

      for (var question in quiz.questions) {
        print('Question: ${question.title} - (${question.points} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(questionId: question.id, answerChoice: userInput);
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      quiz.savePlayer(userName);
      int score = quiz.getScoreInPercentage();
      int points = quiz.getPoint();
      print('--- Quiz Finished ---');
      print('$userName, Your score in percentage: $score %');
      print('$userName, You score in points: $points');

      for (Player player in quiz.getAllPlayers()) {
        print(player);
      }
      print('');
    }
  }
}
