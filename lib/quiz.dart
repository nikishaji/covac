import 'package:covac/citizen.dart';
import 'package:flutter/material.dart';
import './answer.dart';
import './question.dart';
import './result.dart';
import 'package:firebase_database/firebase_database.dart';

class CovidQuiz extends StatefulWidget {
  static const routename = '/quiz';
  Citizen _citizen;
  CovidQuiz(this._citizen);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<CovidQuiz> {
  void _worker(BuildContext context) {
    final _userref = FirebaseDatabase.instance.reference();
    _userref.child('citizen/${widget._citizen.mobileno}').update({
      'isbadge3': true,
      'badgeno': widget._citizen.badgeno + 1,
    });
  }

  final _questions = const [
    {
      'questionText': 'Q1. What does COVID-19 stand for?',
      'answers': [
        {
          'text':
              "It is a term for Coronavirus Disease 19, because it's the 19th strain of coronavirus discovered.",
          'score': -2
        },
        {
          'text':
              'It is a term that stands for Coronavirus Disease 2019, the year it was first identified',
          'score': 10
        },
      ],
    },
    {
      'questionText': 'Q2. How is COVID-19 passed on?',
      'answers': [
        {
          'text':
              'In sexual fluids, including semen, vaginal fluids or anal mucous',
          'score': -2
        },
        {'text': 'By drinking unclean water', 'score': -2},
        {
          'text':
              'Through droplets that come from your mouth and nose when you cough or breathe out',
          'score': 10
        },
        {'text': 'All of the above', 'score': -2},
      ],
    },
    {
      'questionText': ' Q3. What are the common symptoms of COVID-19?',
      'answers': [
        {'text': 'A new and continuous cough', 'score': -2},
        {'text': 'Fever', 'score': -2},
        {'text': 'Tiredness', 'score': -2},
        {'text': 'All of the above', 'score': 10},
      ],
    },
    {
      'questionText':
          'Q4. Which of the following is an example of physical distancing? ?',
      'answers': [
        {
          'text':
              'You stop going to crowded places and visiting other people’s houses',
          'score': 10
        },
        {'text': 'You stop talking to the people you live with', 'score': -2},
        {'text': 'You stop speaking to your friends on the phone', 'score': -2},
      ],
    },
    {
      'questionText': 'Q5. Can you always tell if someone has COVID-19?',
      'answers': [
        {
          'text':
              'Yes – it will be obvious, a person with COVID-19 coughs a lot',
          'score': -2,
        },
        {'text': 'No – not everyone with COVID-19 has symptoms', 'score': 10},
      ],
    },
    {
      'questionText':
          'Q6. What’s a safe distance to stay apart from someone who’s sick?',
      'answers': [
        {
          'text': 'Atleast 1 foot(30cm)',
          'score': -2,
        },
        {'text': 'Atleast 3 feet(1m)', 'score': 10},
      ],
    },
    {
      'questionText':
          'Q7. Who’s at highest risk of developing severe Covid-19 disease?',
      'answers': [
        {
          'text': 'Children',
          'score': -2,
        },
        {
          'text':
              'Elderly people(above 6o years) & those with existing medical conditions',
          'score': 10
        },
        {
          'text': 'Pergnant women',
          'score': -2,
        },
      ],
    },
    {
      'questionText':
          'Q8. A vaccine stimulates your immune system to produce antibodies, like it would if you were exposed to the virus. True or False?',
      'answers': [
        {
          'text': 'True',
          'score': 10,
        },
        {'text': 'False', 'score': -2},
      ],
    },
    {
      'questionText': 'Q9. When should face masks be worn?',
      'answers': [
        {
          'text': 'On public transport',
          'score': -2,
        },
        {'text': 'In small shops', 'score': -2},
        {'text': 'In confined or crowded spaces', 'score': -2},
        {'text': 'All of the above', 'score': 10},
      ],
    },
    {
      'questionText': 'Q10. Can washing your hands protect you from COVID-19?',
      'answers': [
        {
          'text': 'Yes – normal soap and water or hand sanitizer is enough',
          'score': 10,
        },
        {'text': 'No – Washing your hands doesn’t stop COVID-19', 'score': -2},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _reset() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      setState(() {
        _worker(context);
      });

      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid Quiz'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.blueGrey[900],
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                ) //Quiz
              : Result(_totalScore, _resetQuiz, _reset),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'],
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    ); //Column
  }
}
