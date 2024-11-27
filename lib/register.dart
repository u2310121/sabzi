import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Register'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                maxLength: 9,
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  prefixText: '+998',
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (phoneController.text.length == 9)
                    Navigator.pushNamed(context, '/code');
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Enter PhoneNumber correctly')),
                    );
                  }
                },
                child: Text('Send code'),
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
