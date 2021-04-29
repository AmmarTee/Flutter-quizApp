import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizBrain {
  int _questionNumber = 0;

  static List questions = List<String>.filled(10,'');
  static List answers = List<bool>.filled(10,null);
  

  static bool toBoolean(String str) {
    if (str.toLowerCase() == "true") {
      return true;
    }
    return false;
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=22&difficulty=easy&type=boolean'));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      for(int i = 0;i<10;i++){
      questions[i] = decodedData['results'][i]['question'];
      answers[i] =  toBoolean(decodedData['results'][i]['correct_answer']);
      print(i.toString()+":-"+questions[i]);
      print(answers[i]);
      }
    } else {
      print(response.statusCode);
    }
  }

  void nextQuestion() {
    if (_questionNumber < questions.length-1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return questions[_questionNumber];
  }

  bool getCorrectAnswer() {
    return answers[_questionNumber];
  }

  bool isFinished() {
    if (_questionNumber >= questions.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
