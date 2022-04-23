part of 'candidate_bloc.dart';

@immutable
abstract class CandidateState {}

class CandidateInitial extends CandidateState {}

class GetSuccessState extends CandidateState {
  final List<Address> dataAddress;
  final List<Email> dataEmail;
  final List<Experience> dataExperience;

  GetSuccessState(this.dataAddress, this.dataEmail, this.dataExperience);
}

class GetCandidateFailedState extends CandidateState {
  final String message;

  GetCandidateFailedState({this.message = ''});
}

class GetCandidateFailureState extends CandidateState {
  final String error;

  GetCandidateFailureState(this.error);
}

class LoadingCandidateState extends CandidateState {}
