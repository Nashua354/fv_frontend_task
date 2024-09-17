import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/card_cubit/card_cubit.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/models/cards.dart';
import 'package:fv_frontend_task/models/transactions.dart';
import 'package:fv_frontend_task/router/routes.dart';
import 'package:go_router/go_router.dart';

class CreditCardScreen extends StatefulWidget {
  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  @override
  void initState() {
    BlocProvider.of<CardCubit>(context).fetchCards();
    BlocProvider.of<TransactionCubit>(context).fetchTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
            color: Colors.black),
        title: const Text('Credit card', style: TextStyle(color: Colors.black)),
        actions: [
          const Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('BALANCE DUE', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              const Text('\$245,781.00',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 150,
                color: Colors.blue.withOpacity(0.1),
                child: const Center(child: Text('Graph Placeholder')),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeFilterButton('1W'),
                  _buildTimeFilterButton('1M'),
                  _buildTimeFilterButton('3M'),
                  _buildTimeFilterButton('6M', isSelected: true),
                  _buildTimeFilterButton('YTD'),
                  _buildTimeFilterButton('1Y'),
                  _buildTimeFilterButton('ALL'),
                ],
              ),
              const SizedBox(height: 16),

              // Cards
              _buildSectionTitle('Credit cards'),
              BlocBuilder<CardCubit, CardState>(builder: (context, state) {
                if (state is CardLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CardLoadedState) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        CardModel card = state.cards[index];
                        return _buildCreditCardItem(
                            card.imageUrl!,
                            card.name!,
                            '-\$${card.expense}',
                            'Asset ••••${card.cardLast4}');
                      },
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: state.cards.length);
                }
                return Container();
              }),
              const SizedBox(height: 8),
              const Text('+ ADD ACCOUNT', style: TextStyle(color: Colors.blue)),

              //Category
              const SizedBox(height: 16),
              _buildSectionTitle('Top categories'),
              _buildCategoryItem('https://placehold.co/40x40.png',
                  'Foods & dining', '-\$5000.32', '90% of spends'),
              _buildCategoryItem('https://placehold.co/40x40.png',
                  'Apps & software', '-\$2600.45', '90% of spends'),
              _buildCategoryItem('https://placehold.co/40x40.png',
                  'Health & wellness', '-\$1400.94', '4% of spends'),
              const SizedBox(height: 8),
              const Text('SEE ALL CATEGORIES',
                  style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 16),

              //Transactions
              _buildSectionTitle('All transactions'),
              BlocBuilder<TransactionCubit, TransactionState>(
                  builder: (context, state) {
                if (state is TransactionLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TransactionLoadedState) {
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        Transaction transaction = state.transactions[index];
                        return _buildTransactionItem(
                            transaction.icon!,
                            transaction.name!,
                            '-\$${transaction.expense}',
                            '22 Jun 24, 4:25pm • ${transaction.status}');
                      },
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: state.transactions.length < 6
                          ? state.transactions.length
                          : 5);
                }
                return Container();
              }),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.transactions.name);
                },
                child: const Text('SEE ALL TRANSACTIONS',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFilterButton(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCreditCardItem(
      String imageUrl, String title, String amount, String details) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.cardDetails.name);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CachedNetworkImage(imageUrl: imageUrl, width: 40, height: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(details, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Spacer(),
            Text(amount,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      String imageUrl, String title, String amount, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CachedNetworkImage(imageUrl: imageUrl, width: 40, height: 40),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(details, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text(amount,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      String imageUrl, String title, String amount, String details) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CachedNetworkImage(imageUrl: imageUrl, width: 40, height: 40),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: Text(title,
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 1,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Text(details, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text(amount,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
