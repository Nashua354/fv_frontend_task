import 'package:fv_frontend_task/constants/mock_responses.dart';
import 'package:fv_frontend_task/models/cards.dart';

class CardRepository {
  Future<CardList> fetchCards() async {
    await Future.delayed(const Duration(seconds: 1));
    return CardList.fromJson(cards);
  }

  Future<CardList> fetchCardDetails() async {
    await Future.delayed(const Duration(seconds: 1));
    return CardList.fromJson(cardDetails);
  }
}
