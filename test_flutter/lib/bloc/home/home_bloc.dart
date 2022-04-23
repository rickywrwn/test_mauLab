import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_flutter/model/home_model.dart';
import 'package:test_flutter/repo/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  var homeRepo = HomeRepository();
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      // TODO: implement event handler
      emit(LoadingState());
      try {
        final candidateData = await homeRepo.getCandidate();
        final blogData = await homeRepo.getBlog();

        if (candidateData.item2 == 200 || blogData.item2 == 200) {
          var homeData = candidateData.item1! + blogData.item1!;
          emit(GetHomeSuccessState(homeData));
        } else {
          emit(GetHomeFailedState(message: "Something wrong, please try again"));
        }
      } catch (e) {
        print(e.toString());
        emit(GetFailureState(e.toString()));
      }
    });
  }

  void onLoad() {
    add(HomeInitialEvent());
  }
}
