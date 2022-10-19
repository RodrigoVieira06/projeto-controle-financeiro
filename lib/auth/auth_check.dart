import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/home/page/home_page_widget.dart';
import 'package:projeto_controle_financeiro/screens/login/page/login_page.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            (snapshot.data?.displayName == null && snapshot.hasData)) {
          return Scaffold(
            backgroundColor: projectTheme.backgroundColor,
            body: const LoadingWidget(),
          );
        }
        if (snapshot.data == null) {
          Modular.to.navigate('/');
          return const LoginPage();
        } else {
          Modular.to.navigate('/home/');
          return const HomePageWidget();
        }
      },
    );
  }
}
