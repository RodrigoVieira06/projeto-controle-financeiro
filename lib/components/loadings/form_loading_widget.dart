import 'package:flutter/material.dart';

class FormLoadingWidget extends StatelessWidget {
  const FormLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Carregando dados do formulário.',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
