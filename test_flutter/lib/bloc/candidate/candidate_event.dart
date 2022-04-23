part of 'candidate_bloc.dart';

@immutable
abstract class CandidateEvent {}

class CandidateInitialEvent extends CandidateEvent {
  final String id;

  @override
  CandidateInitialEvent({
    required this.id,
  });
}
