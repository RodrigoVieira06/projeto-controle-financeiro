import 'package:flutter/material.dart';

class CardLoadingWidget extends StatelessWidget {
  final String info;

  const CardLoadingWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              info,
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
