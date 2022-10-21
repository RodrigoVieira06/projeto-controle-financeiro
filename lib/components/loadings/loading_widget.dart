import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250,
        width: 250,
        child: Dialog(
          backgroundColor: projectTheme.backgroundColor,
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
    );
  }
}
