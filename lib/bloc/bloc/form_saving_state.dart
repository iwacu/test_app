part of 'form_saving_bloc.dart';

class FormSavingState {
  final String userName;
  bool get isValidUsername => userName.isNotEmpty;

  final int babyPremature;
  bool get isValidbabyPremature => babyPremature.isEven;
  final String babyRelationship;
  bool get isValidbabyRelationship => babyRelationship.isNotEmpty;

  final FormSubmissionStatus formSubmissionStatus;
  FormSavingState(
      {this.babyPremature = 1,
      this.babyRelationship = '',
      this.userName = '',
      this.formSubmissionStatus = const InitialFormStatus()});
  FormSavingState copyWith({
    String? userName,
    int? babyPremature,
    String? babyRelationship,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return FormSavingState(
      userName: userName ?? this.userName,
      babyPremature: babyPremature ?? this.babyPremature,
      babyRelationship: babyRelationship ?? this.babyRelationship,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
