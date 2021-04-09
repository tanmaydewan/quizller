import 'package:flutter/material.dart';
import 'Quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

List<Icon> result = [];
int score = 0;
void resultCheck(bool userAnswer) {
  bool correctAnswer = quizBrain.checkAnswer(userAnswer);

  if ((userAnswer == correctAnswer) &&
      (quizBrain.count != quizBrain.countCheck)) {
    result.add(
      Icon(Icons.check, color: Colors.green),
    );
    score++;
  } else if (userAnswer != correctAnswer &&
      (quizBrain.count != quizBrain.countCheck)) {
    result.add(
      Icon(Icons.close, color: Colors.red),
    );
  }
  quizBrain.nextQuestion();
}

class _QuizPageState extends State<QuizPage> {
  /* List<String> questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];
  List<bool> answer = [false, true, true];*/

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.count == quizBrain.countCheck) {
                    Alert(
                            context: context,
                            title: "Quiz over",
                            desc: "Your Score is $score ")
                        .show();
                    quizBrain.count = 0;
                    result.clear();
                  } else {
                    resultCheck(true);
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.count == quizBrain.countCheck) {
                    Alert(
                            context: context,
                            title: "FilledStacks",
                            desc: "Flutter is awesome.")
                        .show();
                  } else {
                    resultCheck(true);
                  }
                });
              },
            ),
          ),
        ),

        //TODO: Add a Row here as your score keeper
        Row(
          children: result,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
