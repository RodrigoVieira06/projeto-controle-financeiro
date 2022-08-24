import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Por favor, aguarde'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
