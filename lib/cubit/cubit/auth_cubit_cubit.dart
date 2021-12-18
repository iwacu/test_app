import 'package:bloc/bloc.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/user.dart';
import 'package:momnotebook/services/database/database_helper.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());

  getUser() async {
    var user = await DatabaseHelper.instance.getUser();

    if (user.object == null) {
      emit(AuthCubitNoUser());
    } else {
      var baby = await DatabaseHelper.instance.getBaby(user.object!.babyId);
      var babies = await DatabaseHelper.instance.getBabies();
      babies.forEach((ef) => print('id::${ef.id} <=> name :: ${ef.name}'));

      emit(AuthCubitUser(user.object!, baby.object!, babies));
    }
  }

  updateUser(User user, int id) async {
    var res = await DatabaseHelper.instance
        .updateUser(User(name: user.name, babyId: id, id: user.id));

    getUser();
  }
}
