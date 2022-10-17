import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class DateSelectWidget extends StatelessWidget {
  const DateSelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: projectTheme.primaryColor,
              ),
              child: const Icon(Icons.arrow_left_rounded),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: projectTheme.primaryColor,
            ),
            child: const Text('OUTUBRO - 2022'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: projectTheme.primaryColor,
              ),
              child: const Icon(Icons.arrow_right_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
