import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// Defining Adult Normal, Overweight & Obesity
// If your BMI is less than 18.5, it falls within the underweight range.
// If your BMI is 18.5 to <25, it falls within the normal.
// If your BMI is 25.0 to <30, it falls within the overweight range.
// If your BMI is 30.0 or higher, it falls within the obese range.
// Obesity is frequently subdivided into categories:
// Class 1: BMI of 30 to < 35
// Class 2: BMI of 35 to < 40
// Class 3: BMI of 40 or higher. Class 3 obesity is sometimes categorized as “extreme” or “severe” obesity.

class _HomeState extends State<Home> {
  final TextEditingController _editingControllerAge =
      new TextEditingController();
  final TextEditingController _editingControllerHeight =
      new TextEditingController();
  final TextEditingController _editingControllerWeight =
      new TextEditingController();
  String _formattedText = '';
  String _overweightObesity = '';
  double _finalResult = 0.0;

  void handleCalculateBMI() {
    setState(() {
      _finalResult = calculateBMI(
          _editingControllerWeight.text, _editingControllerHeight.text);
      _formattedText = 'Your BMI: ${_finalResult.toStringAsFixed(1)}';
      if (_finalResult < 18.5) {
        _overweightObesity = 'Underweight';
      } else if (_finalResult >= 18.5 && _finalResult < 25.0) {
        _overweightObesity = 'Normal';
      } else if (_finalResult >= 25.0 && _finalResult < 30.0) {
        _overweightObesity = 'Overweight';
      } else if (_finalResult >= 30.0 && _finalResult < 35.0) {
        _overweightObesity = 'Class 1 Obesity';
      } else if (_finalResult >= 35.0 && _finalResult < 40.0) {
        _overweightObesity = 'Class 2 Obesity';
      } else {
        _overweightObesity = 'Class 3 Obesity, Or Extreme / Severe Obesity';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: EdgeInsets.all(2.5),
          children: <Widget>[
            Image.asset(
              'images/bmi.png',
              height: 133.0,
              width: 200.0,
            ),
            Container(
              margin: EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Container(
                color: Colors.blueGrey,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _editingControllerAge,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person_outline),
                        labelText: 'Age',
                      ),
                    ),
                    TextField(
                      controller: _editingControllerHeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.assessment),
                        labelText: 'Height in Inches',
                        hintText: 'height in inches',
                      ),
                    ),
                    TextField(
                      controller: _editingControllerWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.line_weight),
                        labelText: 'Weight in lb',
                        hintText: 'weight in pounds',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: RaisedButton(
                          onPressed: handleCalculateBMI,
                          child: Text('Calculate'),
                          color: Colors.pink,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "$_formattedText",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "$_overweightObesity",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // resource url: https://www.epic4health.com/bmiformula.html
  // English Formula
  // Body Mass Index can be calculated using pounds and inches with this equation
  // BMI = (( weight_in_pounds / ( height_in_inches * height_in_inches )) * 703)

  // Metric Formula - 1
  // Body Mass Index can also be calculated using kilograms and meters
  // BMI = ( weight_in_kilograms / ( height_in_meters * height_in_meters ))

  // Metric Formula - 2
  // Body Mass Index can also be calculated using kilograms or centimeters
  // BMI = (( weight_in_kilograms / ( height_in_centimeters * height_in_centimeters )) * 10,000)

  double calculateBMI(String weight, String height) {
    if (int.parse(height).toString().isNotEmpty &&
        int.parse(weight).toString().isNotEmpty &&
        int.parse(height) > 0 &&
        int.parse(weight) > 0) {
      return (int.parse(weight) /
          (int.parse(height) * int.parse(height)) *
          703);
    } else {
      print('Wrong!!!');
      return int.parse('1') * 1.0;
    }
  }
}
