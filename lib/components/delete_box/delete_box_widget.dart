import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeleteBoxWidget extends StatelessWidget {
  final dynamic funcaoExclusao;
  final Map<String, dynamic> entity;
  final String path;
  final String? entityName;

  const DeleteBoxWidget({
    Key? key,
    required this.funcaoExclusao,
    required this.entity,
    required this.path,
    this.entityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Excluir registro',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          fontFamily: 'Lato',
        ),
      ),
      content: SizedBox(
        width: 300,
        height: 150,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tem certeza que deseja excluir o registro "${entity['titulo']}"?',
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      entityName == null
                          ? await funcaoExclusao(entity)
                          : await funcaoExclusao(entityName, entity);
                      Modular.to.popAndPushNamed(path);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 27, 67),
                      minimumSize: const Size(100, 40),
                    ),
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black26,
                      minimumSize: const Size(100, 40),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
