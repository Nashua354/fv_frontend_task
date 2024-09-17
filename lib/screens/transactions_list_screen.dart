import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/models/transactions.dart';
import 'package:go_router/go_router.dart';

class TransactionsPage extends StatefulWidget {
  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String? selectedValue = 'Credit card •••• 3507';
  @override
  void initState() {
    BlocProvider.of<TransactionCubit>(context).fetchTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Color(0xffDBE4F1),
        appBar: AppBar(
          backgroundColor: Color(0xffDBE4F1),
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                context.pop();
              },
              color: Colors.black),
          actions: const [
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 16),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        padding: EdgeInsets.zero,
                        value: selectedValue,
                        items: [
                          DropdownMenuItem(
                            child: Text('Credit card •••• 3507'),
                            value: 'Credit card •••• 3507',
                          ),
                          DropdownMenuItem(
                            child: Text('Credit card •••• 6008'),
                            value: 'Credit card •••• 6008',
                          )
                        ],
                        onChanged: (value) {
                          selectedValue = value;
                          setState(() {});
                        }),
                  ),
                  //  Row(
                  //   children: [
                  //     Text('Credit card •••• 3507'),
                  //     Spacer(),
                  //     Icon(Icons.arrow_drop_down),
                  //   ],
                  // ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                          backgroundColor: Colors.white,
                          label: const Text('Sort by'),
                          onSelected: (_) {}),
                      const SizedBox(width: 8),
                      FilterChip(
                          backgroundColor: Colors.white,
                          label: const Text('2 Filters'),
                          onSelected: (_) {}),
                      const SizedBox(width: 8),
                      FilterChip(
                          backgroundColor: Colors.white,
                          label: const Text('Current month'),
                          onSelected: (_) {}),
                      const SizedBox(width: 8),
                      FilterChip(
                          backgroundColor: Colors.white,
                          label: const Text('Food & Dining'),
                          onSelected: (_) {}),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<TransactionCubit, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TransactionLoadedState) {
                      return Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.transactions.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (_, index) {
                            Transaction transaction = state.transactions[index];
                            return TransactionItem(
                              imageUrl: transaction.icon!,
                              title: transaction.name!,
                              date: '22 Jun 24, 4:25pm',
                              status: transaction.status!,
                              amount: '-\$${transaction.expense}',
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String status;
  final String amount;

  const TransactionItem({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.status,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(imageUrl: imageUrl, width: 60, height: 60),
          // const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                if (status.isNotEmpty)
                  Text(
                    status,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
