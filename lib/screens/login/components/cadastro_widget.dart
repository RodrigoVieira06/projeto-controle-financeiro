import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/auth/controller/auth_controller.dart';
import 'package:projeto_controle_financeiro/screens/login/controllers/controllers.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class CadastroWidget extends StatefulWidget {
  const CadastroWidget({Key? key}) : super(key: key);

  @override
  State<CadastroWidget> createState() => _CadastroWidgetState();
}

class _CadastroWidgetState extends State<CadastroWidget> {
  final AuthController auth = AuthController();
  final CadastroWidgetController cadastroWidgetController =
      CadastroWidgetController();

  // XFile? imagem;

  // photoSelection() async {
  //   final ImagePicker imagePicker = ImagePicker();

  //   try {
  //     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  //     if (file != null) setState(() => imagem = file);
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: cadastroWidgetController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 320,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Cadastre sua conta',
                          style: TextStyle(
                            color: projectTheme.primaryColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lato',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cadastroWidgetController.nome,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o seu nome.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cadastroWidgetController.sobrenome,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Sobrenome',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o seu sobrenome.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cadastroWidgetController.email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o seu email corretamente.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cadastroWidgetController.senha,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a sua senha.';
                            } else if (value.length < 6) {
                              return 'Senha inválida.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cadastroWidgetController.confirmarSenha,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Repita sua senha',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Repita a sua senha.';
                            } else if (value !=
                                cadastroWidgetController.senha.text) {
                              return 'A senha não é a mesma.';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const Divider(),
                      // ListTile(
                      //   leading: const Icon(Icons.upload),
                      //   title: Text(
                      //     'Envie uma foto de perfil',
                      //     style: TextStyle(
                      //       color: projectTheme.primaryColor,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: 'lato',
                      //     ),
                      //   ),
                      //   onTap: () async {
                      //     photoSelection();
                      //   },
                      //   trailing: imagem != null
                      //       ? Image.file(
                      //           File(imagem!.path),
                      //         )
                      //       : null,
                      // ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (cadastroWidgetController
                                      .formKey.currentState!
                                      .validate()) {
                                    auth.register(
                                        context,
                                        cadastroWidgetController.email.text,
                                        cadastroWidgetController.senha.text,
                                        cadastroWidgetController.nome.text,
                                        cadastroWidgetController.sobrenome.text,
                                        null
                                        // imagem?.path,
                                        );
                                    Modular.to.navigate('/');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: projectTheme.primaryColor,
                                  fixedSize: const Size(100, 10),
                                ),
                                child: const Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'lato',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () => Modular.to.navigate('/login'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red[400],
                                  fixedSize: const Size(100, 10),
                                ),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'lato',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
