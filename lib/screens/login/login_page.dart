import 'package:flutter/material.dart';

import 'components/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      body: LoginWidget(),
    );
  }
}
