import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:momnotebook/bloc/form_submission/form_sub.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/user.dart';
import 'package:momnotebook/services/database/database_helper.dart';

part 'form_saving_event.dart';
part 'form_saving_state.dart';

class FormSavingBloc extends Bloc<FormSavingEvent, FormSavingState> {
  FormSavingBloc() : super(FormSavingState());
  @override
  Stream<FormSavingState> mapEventToState(
    FormSavingEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(userName: event.userName);
    } else if (event is BabyPrematureChanged) {
      yield state.copyWith(babyPremature: event.babyPremature);
    } else if (event is BabyRelationshipChanged) {
      yield state.copyWith(babyRelationship: event.babyRelationship);
    } else if (event is SubmitForm) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());
      //  read user from dbs
      var user = await DatabaseHelper.instance.getUser();
      if (user.object == null) {
        print('user object null');
        // save user to database
        await DatabaseHelper.instance.addUser(User(name: state.userName));
        yield state.copyWith(
            formSubmissionStatus:
                SubmissionSuccess(message: 'User added successfully'));
      } else {
        yield state.copyWith(
            formSubmissionStatus:
                SubmissionSuccess(message: 'User exist already'));
      }
    } else if (event is SubmitFormSaveBaby) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());
      await DatabaseHelper.instance.addBaby(Baby(
          babySex: event.babySex,
          name: state.userName,
          birthDay: event.babyBirthDay,
          premature: state.babyPremature,
          relationship: state.babyRelationship));
      yield state.copyWith(
          formSubmissionStatus:
              SubmissionSuccess(message: 'Baby added successfully'));
      // print(
      //     'relationship ${state.babyRelationship} ::: premature ${state.babyPremature} ::: sex ${event.babySex} ::: name ${state.userName} ::: birthday ${event.babyBirthDay} ');
    }
  }
}
