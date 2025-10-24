import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;
  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    // Map JSON to domain objects
    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        points: q['points'],
      );
    }).toList();

    Quiz quiz = Quiz(questions: questions);

    if (data['players'] != null) {
      var playersJson = data['players'] as List;
      for (var p in playersJson) {
        Player player =
            Player(p['name'], p['scorePercentage'], p['scorePoint']);
        quiz.players[player.name] = player;
      }
    }

    if (data['answers'] != null) {
      var answersJson = data['answers'] as List;
      for (var answerData in answersJson) {
        Answer answer = Answer(
            questionId: answerData['questionId'],
            answerChoice: answerData['answerChoice']);
        quiz.answers.add(answer);
      }
    }
    return quiz;
  }

  void writeQuiz(Quiz quiz) {
    final file = File(filePath);

    // Map domain objects to JSON
    Map<String, dynamic> data = {
      'id': quiz.id,
      'questions': quiz.questions
          .map((q) => {
                'id': q.id,
                'title': q.title,
                'choices': q.choices,
                'goodChoice': q.goodChoice,
                'points': q.points,
              })
          .toList(),

      'answers': quiz.answers
          .map((a) => {
                'id': a.id,
                'questionId': a.questionId,
                'answerchoice': a.answerChoice,
              })
          .toList(),
          
      'players': quiz.players.values
          .map((p) => {
                'name': p.name,
                'scorePercentage': p.scorePercentage,
                'scorePoint': p.scorePoint,
              })
          .toList(),
    };

    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(data);

    file.writeAsStringSync(jsonString);
  }
}
