import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(Screen());
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String inputUser = '';
  String result = '';

  void buttonpressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text1)),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else
              buttonpressed(text1);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text1,
              style: TextStyle(color: getTextColor(text1), fontSize: 28),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text2)),
          onPressed: () {
            if (text2 == 'ce') {
              if (inputUser.length != 0) {
                setState(() {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                });
              }
            } else
              buttonpressed(text2);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text2,
              style: TextStyle(color: getTextColor(text2), fontSize: 28),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text3)),
          onPressed: () {
            buttonpressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text3,
              style: TextStyle(color: getTextColor(text3), fontSize: 28),
            ),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(width: 0, color: Colors.transparent),
                ),
                backgroundColor: getBackgroundColor(text4)),
            onPressed: () {
              if (text4 == '=') {
                Parser p = Parser();
                if (inputUser.length != 0) {
                  Expression exp = p.parse(inputUser);
                  double eval =
                      exp.evaluate(EvaluationType.REAL, ContextModel());

                  setState(() {
                    result = eval.toString();
                  });
                }
              } else {
                buttonpressed(text4);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                text4,
                style: TextStyle(color: getTextColor(text4), fontSize: 28),
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 100,
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          '$inputUser',
                          style: TextStyle(color: textGreen, fontSize: 28),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          result,
                          style: TextStyle(
                              fontSize: 32,
                              color: textGrey,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: 300,
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('ac', 'ce', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var operators = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in operators) {
      if (item == text) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    }
    return backgroundGrey;
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    }
    return textGrey;
  }
}
