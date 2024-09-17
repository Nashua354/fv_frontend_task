part of 'card_cubit.dart';

class CardState {}

class CardInitialState extends CardState {}

class CardLoadingState extends CardState {}

class CardLoadedState extends CardState {
  List<CardModel> cards;
  CardLoadedState(this.cards);
}

class CardErrorState extends CardState {}
