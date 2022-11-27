import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class DateselectButtonsWidget {
  DateselectButtonsWidget();

  final DateselectStore dateselectStore = DateselectStore();
  final Conversoes conversoes = Conversoes();

  Widget buildWidget(
    BuildContext context,
    List<Function({DateTime? selectedDate})> getEntityFunctions,
  ) {
    return ScopedBuilder<DateselectStore, Exception, DateTime>(
        store: dateselectStore,
        onLoading: (context) => const CircularProgressIndicator(),
        onError: (context, error) => Text('$error'),
        onState: (context, DateTime selectedDate) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: projectTheme.primaryColor,
                    ),
                    child: const Icon(Icons.arrow_left_rounded),
                    onPressed: () async {
                      dateselectStore.decrementMonth(selectedDate);
                      DateTime newDate =
                          selectedDate.subtract(const Duration(days: 31));
                      for (var function in getEntityFunctions) {
                        function(selectedDate: newDate);
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: projectTheme.primaryColor,
                  ),
                  child: Text(
                      '${conversoes.convertMonth(selectedDate.month)} - ${selectedDate.year}'),
                  onPressed: () async {
                    DateTime? newDate = await showMonthPicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (newDate == null) return;
                    dateselectStore.setDate(newDate);
                    for (var function in getEntityFunctions) {
                      function(selectedDate: newDate);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: projectTheme.primaryColor,
                    ),
                    child: const Icon(Icons.arrow_right_rounded),
                    onPressed: () {
                      dateselectStore.incrementMonth(selectedDate);
                      DateTime newDate =
                          selectedDate.add(const Duration(days: 31));
                      for (var function in getEntityFunctions) {
                        function(selectedDate: newDate);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
