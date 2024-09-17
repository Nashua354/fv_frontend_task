import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/models/cards.dart';
import 'package:fv_frontend_task/repository/card_repository.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitialState());
  fetchCards() async {
    emit(CardLoadingState());
    CardRepository _repo = CardRepository();
    CardList result = await _repo.fetchCards();
    if (result.cards != null) {
      emit(CardLoadedState(result.cards!));
    } else {
      emit(CardErrorState());
    }
  }

  fetchFilteredCards() async {
    emit(CardLoadingState());
    CardRepository _repo = CardRepository();
    CardList result = await _repo.fetchCards();
    if (result.cards != null) {
      emit(CardLoadedState(result.cards!));
    } else {
      emit(CardErrorState());
    }
  }
}
