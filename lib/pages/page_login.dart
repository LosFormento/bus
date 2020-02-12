import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}
class _LoginData {
  String phone;
  String code;
  String step;

  _LoginData(this.phone, this.code);

  _LoginData.fromJson(Map<String, dynamic> json)
      : phone = json['phone'],
        code = json['code'];

  Map<String, dynamic> toJson() =>
      {
        'code':code,
        'phone': phone,
      };
}
// Define a corresponding State class.
// This class holds data related to the form.
class LoginScreenState extends State<LoginScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  var _waitingForCode=false;

  final _formKey = GlobalKey<FormState>();
  final _maskFormatter =   MaskTextInputFormatter(mask: '(##)###-##-##', filter: { "#": RegExp(r'[0-9]') });
  _LoginData _data = new _LoginData('','');


  Future <void>  submit() async {
     _formKey.currentState.save();
     if(_data.step == 'SENT'){
        print('waiting for code input');
        print(_data.phone);
        print(_data.code);
        var url = 'http://174.by/api/phone/verify';
        var client = http.Client();

        try {
          final uriResponse = await client.post(url,
            body: jsonEncode(_data.toJson()),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.acceptCharsetHeader:"UTF-8"
            },
          );

          print(uriResponse.body);

          var data=jsonDecode(uriResponse.body);

          if(data['user']){
            print(data['user_token']);
            Navigator.pop(context);
          }
        }finally {
          client.close();
        }

     }else{
       var url = 'http://174.by/api/phone/create';
       var client = http.Client();

       try {
         final uriResponse = await client.post(url,
           body: jsonEncode(_data.toJson()),
           headers: {
             HttpHeaders.contentTypeHeader: "application/json",
             HttpHeaders.acceptCharsetHeader:"UTF-8"
           },
         );
         var data=jsonDecode(uriResponse.body);
         if(data["code"] == 'SENT'){
           _data.step=data['code'];
           _formKey.currentState.save();
           _waitForCode(true);
         }else{

         }
       } finally {
         client.close();
       }
       print('Printing the login data.');
       print('phone: ${_data.phone}');
       print('code: ${_data.code}');
     }
  }

   void _waitForCode(bool state) {
    setState(() {
      _waitingForCode=state;
    });
  }


  @override
  Widget build(BuildContext context) {
    print('waitnig for code');
    print(_waitingForCode);

    return Scaffold(
      appBar: AppBar(
        title: Text("Войти"),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: '(xx)xxx-xx-xx',
                    labelText: 'Номер телефона',
                    prefixText: '+375 ',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Нужно ввести телефон';
                    }
                    final phoneExp = RegExp(r'^\(\d\d\)\d\d\d\-\d\d-\d\d$');
                    if (!phoneExp.hasMatch(value)) {
                      return 'Пример +375(29)XXX-XX-XX';
                    }
                    return null;
                  },
                  onSaved: (String value){
                    _data.phone = value;
                  },
                  // TextInputFormatters are applied in sequence.
                  inputFormatters: <TextInputFormatter>[
                    //WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    _maskFormatter,
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: _waitingForCode ?
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'XXXX',
                      labelText: 'Проверочный код',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Нужно ввести проверочный код';
                      }
                      if(value.length > 4 || value.length <4){
                        return '4 цифры из смс';
                      }
                      return null;
                    },
                    onSaved: (String value){
                      _data.code = value;
                    },
                    // TextInputFormatters are applied in sequence.
                    inputFormatters: <TextInputFormatter>[
                      //WhitelistingTextInputFormatter.digitsOnly,
                      // Fit the validating format.
                      //_maskFormatter,
                    ],
                  ) : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('Войти'),
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              this.submit();
                            }
                          },
                        ),
                        RaisedButton(
                          child: Text('Отмена'),
                          onPressed: () {
                              Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
}

}


