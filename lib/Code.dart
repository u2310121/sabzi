import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
class CodeEntryScreen extends StatefulWidget {
  @override
  _CodeEntryScreenState createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  final TextEditingController pinController = TextEditingController();

  void _submitCode() {
    String code = pinController.text;
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter code correctly')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('code entered correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Enter Code'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                controller: pinController,
                length: 6,
                pinAnimationType: PinAnimationType.fade,
                defaultPinTheme: PinTheme(
                  width: 40,
                  height: 55,
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 40,
                  height: 55,
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 40,
                  height: 55,
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitCode,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
