import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/core/app_module.dart';
import 'package:projeto_controle_financeiro/core/app_widget.dart';
import 'package:projeto_controle_financeiro/core/auth/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}
