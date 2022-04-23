import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_flutter/model/candidate_model.dart';
import 'package:test_flutter/repo/candidate_repository.dart';

part 'candidate_event.dart';
part 'candidate_state.dart';

class CandidateBloc extends Bloc<CandidateEvent, CandidateState> {
  var candidateRepo = CandidateRepository();
  CandidateBloc() : super(CandidateInitial()) {
    on<CandidateInitialEvent>((event, emit) async {
      // TODO: implement event handler
      emit(LoadingCandidateState());
      try {
        final address = await candidateRepo.getAddress(event.id);
        final email = await candidateRepo.getEmail(event.id);
        final experience = await candidateRepo.getExperience(event.id);

        if (address.item2 == 200 || email.item2 == 200 || experience.item2 == 200) {
          var resultAddres = address.item1!;
          var resultEmail = email.item1!;
          var resultExperience = experience.item1!;
          emit(GetSuccessState(resultAddres, resultEmail, resultExperience));
        } else {
          emit(GetCandidateFailedState(message: "Something wrong, please try again"));
        }
      } catch (e) {
        print(e.toString());
        emit(GetCandidateFailureState(e.toString()));
      }
    });
  }
  void onLoad(String id) {
    add(CandidateInitialEvent(id: id));
  }
}
