import 'package:flutter/material.dart';

void main(){

  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest Counter",
    home: InterestCounter(),
    theme: ThemeData(
//      brightness: Brightness.dark,
      primaryColor: Colors.lightBlueAccent,
      accentColor: Colors.blueAccent
    ),
  ));
}

class InterestCounter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _InterestCounter();
  }

}

class _InterestCounter extends State<InterestCounter>{

  var _currencies = ["Rupees", "Pounds", "Dollars "];
  final _minPadding = 5.0;
  var _currentItemSelected = "Rupees";
  String  displayResult = "";
  TextEditingController amountController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController interestController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomPadding: false, //remove the error
      appBar: AppBar(
        title: Text("Interest Counter"),
      ),
      body: Container(
        margin: EdgeInsets.all(_minPadding),
        child: ListView(
          children: <Widget>[
            getImageAsset(),

            Padding(
              padding: EdgeInsets.only(top: _minPadding , bottom: _minPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: amountController,
                decoration: InputDecoration(
                    labelText: "Amount",
                    hintText: "Enter Amount here",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_minPadding)
                    )
                ),
              ),

            ),
            Padding(
              padding: EdgeInsets.only(top: _minPadding , bottom: _minPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: interestController,
                decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "Enter Interest here",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_minPadding)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minPadding , bottom: _minPadding),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: timeController,
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Time in Years",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ),
                  ),
                  Container(
                    width: _minPadding*5,

                  ),

                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected){
                        _onDropDownItemSelected(newValueSelected);

                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minPadding , bottom: _minPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColor,
                      child: Text("Calculate",),
                      onPressed: (){

                        setState(() {
                          displayResult = _calculateTotalReturns();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text("Reset",),
                      onPressed: (){
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_minPadding),
              child: Text(this.displayResult,style: textStyle,),
            )
          ],
        ),
      ),
    );
  }
  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/moneybag.jpg');
    Image image = Image(image: assetImage , width: 100.0, height: 100.0,);
    return Container(child: image,margin: EdgeInsets.all(50.0),);
  }

  void _onDropDownItemSelected(String newItemSelected){
    setState(() {
      this._currentItemSelected = newItemSelected;
    });

  }

  String _calculateTotalReturns(){
    double principal = double.parse(amountController.text);
    double time = double.parse(timeController.text);
    double interest = double.parse(interestController.text);

    double totalAmount = principal + (principal * time * interest) / 100;

    String result  = "The interest is $totalAmount $_currentItemSelected after $time years";
    return result;

  }

  void _reset(){
    amountController.text = '';
    timeController.text = '';
    interestController.text = '';
    _currentItemSelected = _currencies[0];
    displayResult ='';

  }


}



