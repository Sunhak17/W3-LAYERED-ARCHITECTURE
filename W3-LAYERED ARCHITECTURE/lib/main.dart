 
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() {
  QuizRepository repo = QuizRepository('Week3/W3-LAYERED ARCHITECTURE/lib/data/quiz_data.json');
  
  List<Question> questions = [
    Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        points: 10),
    Question(
        title: "2 + 2 = ?", 
        choices: ["2", "4", "5"], 
        goodChoice: "4",
        points: 50),
  ];

  Quiz quiz = Quiz(questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);

  console.startQuiz();
  repo.writeQuiz(quiz);
}
