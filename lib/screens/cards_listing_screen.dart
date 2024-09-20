import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/card_cubit/card_cubit.dart';
import 'package:fv_frontend_task/bloc/category_cubit/category_cubit.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/constants/app_colors.dart';
import 'package:fv_frontend_task/models/cards.dart';
import 'package:fv_frontend_task/models/category_model.dart';
import 'package:fv_frontend_task/router/routes.dart';
import 'package:fv_frontend_task/widgets/card_outline.dart';
import 'package:fv_frontend_task/widgets/custom_chart.dart';
import 'package:fv_frontend_task/widgets/custom_list_tile.dart';
import 'package:fv_frontend_task/widgets/recent_transactions.dart';
import 'package:go_router/go_router.dart';

class CardListingScreen extends StatefulWidget {
  const CardListingScreen({super.key});

  @override
  State<CardListingScreen> createState() => _CardListingScreenState();
}

class _CardListingScreenState extends State<CardListingScreen> {
  @override
  void initState() {
    loadData();

    super.initState();
  }

  loadData() {
    BlocProvider.of<CardCubit>(context).fetchCards();
    BlocProvider.of<TransactionCubit>(context).fetchTransactions();
    BlocProvider.of<CategoryCubit>(context).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text('Credit card', style: TextStyle(color: Colors.black)),
        actions: const [
          Icon(Icons.info_outline, color: Colors.black),
          SizedBox(width: 8)
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadData();
          return;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text('BALANCE DUE', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8),
                    Text('\$245,781.00',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blue.withOpacity(0.1),
                    child: const LineChartSample2(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 40,
                    right: 40,
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.baseColor.withOpacity(0.1),
                      Colors.white
                    ], // Gradient colors
                    begin:
                        Alignment.topCenter, // Starting point of the gradient
                    end: Alignment.bottomCenter, // Ending point of the gradient
                  ),
                ),
                child: Column(
                  children: [
                    // Cards
                    CardOutline(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          _buildSectionTitle('Credit cards'),
                          const SizedBox(height: 12),
                          Divider(
                            height: 2,
                            color: AppColors.dividerColor,
                          ),
                          BlocBuilder<CardCubit, CardState>(
                              builder: (context, state) {
                            if (state is CardLoadingState) {
                              return const ShimmerListLoader();
                            } else if (state is CardLoadedState) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index) {
                                    CardModel card = state.cards[index];
                                    return GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                            AppRoute.cardDetails.name);
                                      },
                                      child: CustomListTile(
                                          imageUrl: card.imageUrl!,
                                          title: card.name!,
                                          trailing: '-\$${card.expense}',
                                          subtitle:
                                              'Asset ••••${card.cardLast4}'),
                                    );
                                  },
                                  separatorBuilder: (_, index) => Divider(
                                        height: 2,
                                        color: AppColors.dividerColor,
                                      ),
                                  itemCount: state.cards.length);
                            }
                            return Container();
                          }),
                          Divider(
                            height: 2,
                            color: AppColors.dividerColor,
                          ),
                          const SizedBox(height: 12),
                          _buildCardFooter('+ ADD ACCOUNT'),
                        ],
                      ),
                    ),
                    CardOutline(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          _buildSectionTitle('Top categories'),
                          const SizedBox(height: 8),
                          Divider(color: AppColors.dividerColor, height: 2),
                          BlocBuilder<CategoryCubit, CategoryState>(
                              builder: (context, state) {
                            if (state is CategoryLoadedState) {
                              return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                      color: AppColors.dividerColor, height: 2),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: state.categories.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    CategoryModel category =
                                        state.categories[index];
                                    return CustomListTile(
                                        imageUrl: category.icon!,
                                        title: category.name!,
                                        subtitle:
                                            '${category.spendPercentage}% of spends',
                                        trailing: '-\$${category.expense}');
                                  });
                            } else if (state is CategoryLoadingState) {
                              return const ShimmerListLoader();
                            } else {
                              return Container();
                            }
                          }),
                          Divider(color: AppColors.dividerColor, height: 2),
                          const SizedBox(height: 8),
                          _buildCardFooter('SEE ALL CATEGORIES >'),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),

                    //Transactions
                    const RecentTransactions(),
                  ],
                ),
              )
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
        color: isSelected ? AppColors.baseColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.grey.shade300),
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

  Widget _buildCardFooter(String title) {
    return Center(
      child: Text(title,
          style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold)),
    );
  }
}
