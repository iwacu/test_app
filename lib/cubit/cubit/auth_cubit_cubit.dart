import 'package:bloc/bloc.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/user.dart';
import 'package:momnotebook/services/database/database_helper.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());

  getUser() async {
    var user = await DatabaseHelper.instance.getUser();
    var baby = await DatabaseHelper.instance.getBaby();

    if (user.object == null) {
      emit(AuthCubitNoUser());
    } else {
      emit(AuthCubitUser(user.object!, baby.object!));
    }
  }
}
