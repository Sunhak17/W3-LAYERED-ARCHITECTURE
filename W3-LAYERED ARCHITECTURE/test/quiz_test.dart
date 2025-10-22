import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

main() {
  test('My first test', () {
   
    Question q1 =
        Question(title: "4-2", choices: ["1", "2", "3"], goodChoice: "2", points: 10);
    Question q2 =
        Question(title: "4+2", choices: ["1", "2", "3"], goodChoice: "6", points: 50);

    Quiz quiz = Quiz(questions: [q1, q2]);

     // Answer are all good
    quiz.addAnswer(Answer(questionId: q1.id, answerChoice: "2"));
    quiz.addAnswer(Answer(questionId: q2.id, answerChoice: "6"));

    // SCore eis 100
    expect(quiz.getScoreInPercentage(), equals(100));
    expect(quiz.getPoint(), equals(60));
  });
}