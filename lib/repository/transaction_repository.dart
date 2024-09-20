import 'package:fv_frontend_task/constants/mock_responses.dart';
import 'package:fv_frontend_task/models/transactions.dart';

class TransactionRepository {
  Future<TransactionList> fetchTransactions() async {
    await Future.delayed(const Duration(seconds: 1));
    return TransactionList.fromJson(transactions);
  }

  Future<TransactionList> fetchFilteredTransactions() async {
    await Future.delayed(const Duration(seconds: 1));
    return TransactionList.fromJson(transactions);
  }
}
