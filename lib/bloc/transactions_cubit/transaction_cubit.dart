import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/models/transactions.dart';
import 'package:fv_frontend_task/repository/transaction_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitialState());
  final TransactionRepository _repo = TransactionRepository();

  fetchTransactions() async {
    emit(TransactionLoadingState());
    TransactionList result = await _repo.fetchTransactions();
    if (result.transactions != null) {
      emit(TransactionLoadedState(result.transactions!));
    } else {
      emit(TransactionErrorState());
    }
  }

  fetchFilteredTransactions(
      {String? cardId,
      String? status,
      String? dateRange,
      String? category,
      String? transactionType}) async {
    emit(TransactionLoadingState());
    TransactionList result = await _repo.fetchTransactions();
    if (result.transactions != null) {
      List<Transaction>? filteredTransactions = result.transactions;
      if (cardId != null) {
        filteredTransactions = filteredTransactions
            ?.where((element) => element.cardId == cardId)
            .toList();
      }
      if (status != null) {
        filteredTransactions = filteredTransactions
            ?.where((element) => element.status == status)
            .toList();
      }
      if (category != null) {
        filteredTransactions = filteredTransactions
            ?.where((element) => element.category == category)
            .toList();
      }
      if (transactionType != null) {
        filteredTransactions = filteredTransactions
            ?.where((element) => element.type == transactionType)
            .toList();
      }
      emit(TransactionLoadedState(filteredTransactions!));
    } else {
      emit(TransactionErrorState());
    }
  }
}
