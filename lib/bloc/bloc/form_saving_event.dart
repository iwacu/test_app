part of 'form_saving_bloc.dart';

abstract class FormSavingEvent {}

class UserNameChanged extends FormSavingEvent {
  final String userName;
  UserNameChanged(this.userName);
}

class BabyPrematureChanged extends FormSavingEvent {
  final int babyPremature;
  BabyPrematureChanged(this.babyPremature);
}

class BabyRelationshipChanged extends FormSavingEvent {
  final String babyRelationship;
  BabyRelationshipChanged(this.babyRelationship);
}

class SubmitForm extends FormSavingEvent {}

class SubmitFormSaveBaby extends FormSavingEvent {
  final String babyBirthDay;
  final String babySex;

  SubmitFormSaveBaby(this.babyBirthDay, this.babySex);
}
