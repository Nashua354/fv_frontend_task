import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/constants/app_colors.dart';
import 'package:fv_frontend_task/constants/mock_responses.dart';
import 'package:fv_frontend_task/models/transactions.dart';
import 'package:fv_frontend_task/screens/transaction_filters.dart';
import 'package:fv_frontend_task/widgets/card_outline.dart';
import 'package:fv_frontend_task/widgets/custom_list_tile.dart';
import 'package:go_router/go_router.dart';

class TransactionsPage extends StatefulWidget {
  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String? selectedValue = 'Credit card •••• 3507';
  int countSelectedFilters = 0;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    BlocProvider.of<TransactionCubit>(context).fetchTransactions();
  }

  resetFilter() {
    selectedFilters = {
      "date": "",
      "type": "",
      "category": "",
      "status": "",
    };
  }

  filters() {
    List<Widget> chips = [];
    countSelectedFilters = 0;
    if (selectedFilters["date"].isNotEmpty &&
        selectedFilters["date"] != "All time") {
      countSelectedFilters++;
      chips.add(Container(
        margin: const EdgeInsets.only(right: 8),
        child: FilterChip(
            avatarBorder: const Border(),
            backgroundColor: Colors.white,
            label: Text(selectedFilters["date"]),
            onSelected: (_) {
              selectedFilters["date"] = "All time";
              setState(() {});
            }),
      ));
    }
    if (selectedFilters["status"].isNotEmpty &&
        selectedFilters["status"] != "All") {
      countSelectedFilters++;

      chips.add(Container(
        margin: const EdgeInsets.only(right: 8),
        child: FilterChip(
            avatarBorder: const Border(),
            backgroundColor: Colors.white,
            label: Text(selectedFilters["status"]),
            onSelected: (_) {
              selectedFilters["status"] = "All";
              setState(() {});
            }),
      ));
    }
    if (selectedFilters["category"].isNotEmpty &&
        selectedFilters["category"] != "All") {
      countSelectedFilters++;

      chips.add(Container(
        margin: const EdgeInsets.only(right: 8),
        child: FilterChip(
            avatarBorder: const Border(),
            backgroundColor: Colors.white,
            label: Text(selectedFilters["category"]),
            onSelected: (_) {
              selectedFilters["category"] = "All";
              setState(() {});
            }),
      ));
    }
    if (selectedFilters["type"].isNotEmpty &&
        selectedFilters["type"] != "All") {
      countSelectedFilters++;

      chips.add(Container(
        margin: const EdgeInsets.only(right: 8),
        child: FilterChip(
            avatarBorder: const Border(),
            backgroundColor: Colors.white,
            label: Text(selectedFilters["type"]),
            onSelected: (_) {
              selectedFilters["type"] = "All";
              setState(() {});
            }),
      ));
    }
    setState(() {});
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: const Color(0xffDBE4F1),
        appBar: AppBar(
          backgroundColor: const Color(0xffDBE4F1),
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                context.pop();
              },
              color: Colors.black),
          actions: const [
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 16),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            loadData();
          },
          child: SingleChildScrollView(
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
                          items: const [
                            DropdownMenuItem(
                              value: 'Credit card •••• 3507',
                              child: Text('Credit card •••• 3507'),
                            ),
                            DropdownMenuItem(
                              value: 'Credit card •••• 6008',
                              child: Text('Credit card •••• 6008'),
                            )
                          ],
                          onChanged: (value) {
                            selectedValue = value;
                            BlocProvider.of<TransactionCubit>(context)
                                .fetchTransactions();
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
                            avatarBorder: Border.all(width: 2),
                            backgroundColor: Colors.white,
                            label: Text(
                                '${countSelectedFilters == 0 ? "" : (countSelectedFilters)} Filters'),
                            onSelected: (_) async {
                              await showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const FilterScreen();
                                  });
                              BlocProvider.of<TransactionCubit>(context)
                                  .fetchTransactions();
                              setState(() {});
                            }),
                        const SizedBox(width: 8),
                        ...filters(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CardOutline(
                    child: BlocBuilder<TransactionCubit, TransactionState>(
                      builder: (context, state) {
                        if (state is TransactionLoadingState) {
                          return const ShimmerListLoader();
                        } else if (state is TransactionLoadedState) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.transactions.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 2,
                              color: AppColors.dividerColor,
                            ),
                            itemBuilder: (_, index) {
                              Transaction transaction =
                                  state.transactions[index];
                              return CustomListTile(
                                imageUrl: transaction.icon!,
                                title: transaction.name!,
                                subtitle:
                                    '22 Jun 24, 4:25pm • ${transaction.status}',
                                trailing: '-\$${transaction.expense}',
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
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
    super.key,
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
