import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class AccordionWidget {
  const AccordionWidget();

  Widget buildWidget({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color? iconColor,
    required Widget content,
  }) {
    return Card(
        color: Colors.white,
        child: ExpansionTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 26,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: projectTheme.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: content,
            )
          ],
        ));
  }
}
