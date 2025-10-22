import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Question{
  final String id = uuid.v4();
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({required this.title, required this.choices, required this.goodChoice, required this.points});
}

class Answer{
  final String id = uuid.v4();
  final String questionId;
  final String answerChoice;
  

  Answer({required this.questionId, required this.answerChoice});

  bool isGood(Question question){
    return this.answerChoice == question.goodChoice;
  }
}

class Player{
  String name;
  int scorePercentage;
  int scorePoint;
  
  Player(this.name, this.scorePercentage, this.scorePoint);

  @override
  String toString() {
    return 'Player: $name\t\t Score: $scorePercentage';
  }
}

class Quiz{
  final String id = uuid.v4();
  List<Question> questions;
  List <Answer> answers =[];
  Map<String, Player> players ={};

  Quiz({required this.questions});

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }

  int getScoreInPercentage(){
    int totalSCore =0;
    for(Answer answer in answers){
      Question question = getQuestionById(answer.questionId)!;
      if (answer.isGood(question)) {
        totalSCore++;
      }
    }
    return ((totalSCore/ questions.length)*100).toInt();

  }

  int getPoint(){
    int totalSCore = 0;
    for(Answer answer in answers){
      Question question = getQuestionById(answer.questionId)!;
      if (answer.isGood(question)) {
        totalSCore += question.points;
      }
    }
    return totalSCore;
  }

  void savePlayer(String playerName){
    int scorePercentage = getScoreInPercentage();
    int scorePoint = getPoint();
    Player player = Player(playerName, scorePercentage, scorePoint);
    players[playerName] = player;
  }

  void resetAnswers(){
    answers.clear();
  }

  List<Player> getAllPlayers(){
    return players.values.toList();
  }

  Question? getQuestionById(String id){
    for(Question question in questions){
      if (question.id == id) {
        return question;
      }
    }
    return null;
  }

  Answer? getAnswerById(String id){
    for(Answer answer in answers){
      if (answer.id == id) {
        return answer;
      }
    }
    return null;
  }
}