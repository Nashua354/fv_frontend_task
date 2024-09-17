part of 'transaction_cubit.dart';

class TransactionState {}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionLoadedState extends TransactionState {
  List<Transaction> transactions;
  TransactionLoadedState(this.transactions);
}

class TransactionErrorState extends TransactionState {}
