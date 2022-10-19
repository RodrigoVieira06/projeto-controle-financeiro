import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/auth/controller/auth_controller.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';
import 'package:projeto_controle_financeiro/screens/home/page/home_page_widget.dart';
import 'package:projeto_controle_financeiro/screens/login/page/login_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authStore = AuthController();

    return ScopedBuilder<AuthController, Exception, FirebaseAuth>(
      store: authStore,
      onLoading: (context) => Scaffold(
        backgroundColor: projectTheme.backgroundColor,
        body: const LoadingWidget(),
      ),
      onError: (context, error) => Scaffold(
        backgroundColor: projectTheme.backgroundColor,
        body: Text('$error'),
      ),
      onState: (context, FirebaseAuth auth) {
        if (auth.currentUser == null) {
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
