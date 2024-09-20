import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/card_cubit/card_cubit.dart';
import 'package:fv_frontend_task/bloc/category_cubit/category_cubit.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/constants/app_colors.dart';
import 'package:fv_frontend_task/models/cards.dart';
import 'package:fv_frontend_task/utils/common_functions.dart';
import 'package:fv_frontend_task/widgets/card_outline.dart';
import 'package:fv_frontend_task/widgets/custom_list_tile.dart';
import 'package:fv_frontend_task/widgets/recent_transactions.dart';
import 'package:go_router/go_router.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  int selectedCard = 0;
  @override
  void initState() {
    loadData();

    super.initState();
  }

  loadData() {
    BlocProvider.of<CardCubit>(context).fetchCardDetails();
    BlocProvider.of<CategoryCubit>(context).fetchCategories();
    BlocProvider.of<TransactionCubit>(context).fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE6F3),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
            color: Colors.black),
        title: const Text(
          'Credit cards',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CardCubit, CardState>(builder: (context, state) {
                if (state is CardLoadedState) {
                  return CarouselSlider(
                      items: List.generate(
                          state.cards.length,
                          (index) =>
                              CreditCardWidget(cardModel: state.cards[index])),
                      options: CarouselOptions(
                          height: 200,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            selectedCard = index;
                            setState(() {});
                            BlocProvider.of<CategoryCubit>(context)
                                .fetchCategories();
                            BlocProvider.of<TransactionCubit>(context)
                                .fetchTransactions();
                          }));
                } else if (state is CardLoadingState) {
                  return const ShimmerListLoader();
                } else {
                  return Container();
                }
              }),
              const SizedBox(height: 16),
              SizedBox(
                height: 110,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildActionButton('DETAILS', Icons.credit_card),
                    _buildActionButton('REWARDS', Icons.card_giftcard),
                    _buildActionButton(
                        'CREDITS', Icons.card_membership_outlined),
                    _buildActionButton('BENEFITS', Icons.star_border),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<CardCubit, CardState>(builder: (context, state) {
                if (state is CardLoadedState) {
                  DateTime currentDate = DateTime.now();
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AVAILABLE CREDIT LIMIT',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          priceWithSuperScript(
                              "\$${state.cards[selectedCard].expense!}", 24),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: double.parse(
                                    state.cards[selectedCard].expense!) /
                                double.parse(
                                    state.cards[selectedCard].totalLimit!),
                            backgroundColor: Colors.grey[300],
                            color: AppColors.baseColor,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              priceWithSuperScript(
                                  '\$${(double.parse(state.cards[selectedCard].totalLimit!) - double.parse(state.cards[selectedCard].expense!)).toStringAsFixed(2)}',
                                  16),
                              priceWithSuperScript(
                                  '\$${state.cards[selectedCard].totalLimit}',
                                  16),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Spent',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              Text(' Total credit limit',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Divider(color: AppColors.dividerColor, height: 2),
                          const SizedBox(height: 8),
                          Text(
                            'Last updated from bank on ${currentDate.day} ${intToMonth(currentDate.month)}, ${currentDate.hour}:${currentDate.minute}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is CardLoadingState) {
                  return const ShimmerListLoader();
                } else {
                  return Container();
                }
              }),
              const SizedBox(height: 16),
              CardOutline(
                child: BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                  if (state is CategoryLoadedState) {
                    return Column(
                      children: [
                        const Text(
                          'Top categories',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const CustomListTile(
                            title: 'Foods & dining',
                            trailing: '-\$110.32',
                            imageUrl: "",
                            subtitle: '90% of spends',
                            icon: Icons.restaurant,
                            iconColor: Colors.blue),
                        const CustomListTile(
                            title: 'Apps & software',
                            trailing: '-\$2600.45',
                            imageUrl: "",
                            subtitle: '90% of spends',
                            icon: Icons.apps,
                            iconColor: Colors.orange),
                        const CustomListTile(
                            title: 'Health & wellness',
                            trailing: '-\$1400.94',
                            imageUrl: "",
                            subtitle: '4% of spends',
                            icon: Icons.health_and_safety,
                            iconColor: Colors.purple),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {},
                          child: const Text('SEE ALL CATEGORIES'),
                        ),
                      ],
                    );
                  } else if (state is CategoryLoadingState) {
                    return const ShimmerListLoader();
                  } else {
                    return Container();
                  }
                }),
              ),
              const SizedBox(height: 16),
              const RecentTransactions(),
              const SizedBox(height: 16),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Need any help?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text('Our representative will call you'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {},
                            child: const Text(
                              'Call customer care',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CachedNetworkImage(
                      imageUrl:
                          'https://placehold.co/80x80.png?description=Support%20image',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return CardOutline(
      child: Column(
        children: [
          Icon(icon, size: 25, color: Colors.black),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 12)),
        ],
      ),
    );
  }
}

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key, required this.cardModel});
  final CardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl: cardModel.imageUrl!,
                        width: 60,
                        height: 40,
                      ),
                      const Text(
                        'VISA',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '**** **** **** ${cardModel.cardLast4}',
                    style: const TextStyle(fontSize: 24, letterSpacing: 2),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                    color: Color(0xFF0074CC),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOTAL DUE',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        priceWithSuperScript("-\$${cardModel.expense!}", 24,
                            color: Colors.white),
                        // Text(

                        //   style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 24,
                        //       fontWeight: FontWeight.bold),
                        // ),
                      ],
                    ),
                    const Icon(Icons.credit_card_rounded,
                        color: Colors.white, size: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
