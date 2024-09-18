import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/constants/app_colors.dart';
import 'package:fv_frontend_task/models/transactions.dart';
import 'package:fv_frontend_task/router/routes.dart';
import 'package:fv_frontend_task/widgets/card_outline.dart';
import 'package:fv_frontend_task/widgets/custom_list_tile.dart';
import 'package:go_router/go_router.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return CardOutline(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          _buildSectionTitle('All transactions'),
          SizedBox(height: 12),
          Divider(
            height: 2,
            color: AppColors.dividerColor,
          ),
          SizedBox(height: 12),
          BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TransactionLoadedState) {
              return ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    Transaction transaction = state.transactions[index];
                    return CustomListTile(
                        imageUrl: transaction.icon!,
                        title: transaction.name!,
                        trailing: '-\$${transaction.expense}',
                        subtitle: '22 Jun 24, 4:25pm • ${transaction.status}');
                  },
                  separatorBuilder: (_, index) => Divider(
                        height: 2,
                        color: AppColors.dividerColor,
                      ),
                  itemCount: state.transactions.length < 6
                      ? state.transactions.length
                      : 5);
            }
            return Container();
          }),
          const SizedBox(height: 8),
          Divider(
            height: 2,
            color: AppColors.dividerColor,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              context.pushNamed(AppRoute.transactions.name);
            },
            child: _buildCardFooter('SEE ALL TRANSACTIONS >'),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCardFooter(String title) {
    return Center(
      child: Text(title,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
    );
  }
}
