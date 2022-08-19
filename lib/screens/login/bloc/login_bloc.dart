import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projeto_controle_financeiro/screens/login/models/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
