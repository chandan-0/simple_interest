import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigoAccent,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

//------------------------ Very Important Class -----------------------------

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupies', 'Dollers', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = 'Rupies';
  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  var displayResult ='';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: initAppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Container(
              margin: EdgeInsets.fromLTRB(
                  _minimumPadding * 2,
                  _minimumPadding * 0,
                  _minimumPadding * 2,
                  _minimumPadding * 0),
              child: TextFormField(
                style: textStyle,
                controller: principalControlled,
                keyboardType: TextInputType.number,
                // ignore: missing_return
                validator: (String value){
                  if(value.isEmpty)
                  {
                    return "Please Enter Principal";
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g. 12000',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  _minimumPadding * 2,
                  _minimumPadding * 2,
                  _minimumPadding * 2,
                  _minimumPadding * 0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiControlled,
                // ignore: missing_return
                validator: (String value){
                  if(value.isEmpty)
                  {
                    return "Please Enter Rate Of Interest";
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Rate of interest',
                    hintText: 'In persent',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: _minimumPadding * 2,
                  right: _minimumPadding * 2,
                  top: _minimumPadding * 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      style: textStyle,
                      controller: termControlled,
                      keyboardType: TextInputType.number,
                      // ignore: missing_return
                      validator: (String value){
                        if(value.isEmpty)
                        {
                          return "Please Enter Term";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        // container of dropDownButton
                        margin: EdgeInsets.only(
                            left: _minimumPadding * 5,
                            right: _minimumPadding * 4,
                            top: _minimumPadding * 2),
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        )
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: _minimumPadding * 2,
                  right: _minimumPadding * 2,
                  top: _minimumPadding * 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.black87,
                      child: Text(
                        "Calculate",
                        style: textStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate()){
                            this.displayResult = _calculateTotalReturns();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.redAccent,
                      textColor: Colors.black87,
                      child: Text(
                        "Reset",
                        style: textStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: _minimumPadding * 5,
                  right: _minimumPadding * 5,
                  top: _minimumPadding * 7),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  getImageAsset() {
    AssetImage assetImage = AssetImage("images/Bank.png");
    Image image = Image(
      image: assetImage,
      width: 140.0,
      height: 140.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.fromLTRB(_minimumPadding * 20, _minimumPadding * 2,
          _minimumPadding * 20, _minimumPadding * 0),
    );
  }

  initAppBar() {
    return AppBar(
      title: Text("Simple Interest"),
      automaticallyImplyLeading: true,
      leading: GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.menu,
        ),
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.more_vert,
              ),
            )),
      ],
      actionsIconTheme: IconThemeData(
        color: Colors.black,
        size: 30.0,
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years your investment will be worth $totalAmountPayable in $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalControlled.text= '';
    roiControlled.text      = '';
    termControlled.text     = '';
    displayResult           = '';
    _currentItemSelected    = _currencies[0];
  }
}

//------------------------ Congratulations Chandu-------------------------------
