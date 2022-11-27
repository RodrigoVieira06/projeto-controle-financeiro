import 'package:flutter_triple/flutter_triple.dart';

class DateselectStore extends NotifierStore<Exception, DateTime> {
  DateselectStore() : super(DateTime.now());

  setDate(DateTime selectedDate) async {
    setLoading(true);
    try {
      update(selectedDate);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
  }

  incrementMonth(DateTime selectedDate) async {
    setLoading(true);
    DateTime newDate = selectedDate.add(const Duration(days: 31));
    try {
      update(newDate);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
  }

  decrementMonth(DateTime selectedDate) async {
    setLoading(true);
    DateTime newDate = selectedDate.subtract(const Duration(days: 31));
    try {
      update(newDate);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
  }
}
