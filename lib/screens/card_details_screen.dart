import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/widgets/card_outline.dart';
import 'package:fv_frontend_task/widgets/custom_list_tile.dart';
import 'package:fv_frontend_task/widgets/recent_transactions.dart';
import 'package:go_router/go_router.dart';

class CardDetailsScreen extends StatefulWidget {
  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<TransactionCubit>(context).fetchTransactions();
    super.initState();
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
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://placehold.co/60x40.png?description=Chase%20logo',
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
                    const Text(
                      '**** **** **** 7628',
                      style: TextStyle(fontSize: 24, letterSpacing: 2),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      color: const Color(0xFF0074CC),
                      padding: const EdgeInsets.all(16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOTAL DUE',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '-\$24,890.00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(Icons.credit_card,
                              color: Colors.white, size: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton('DETAILS', Icons.info),
                _buildActionButton('REWARDS', Icons.card_giftcard),
                _buildActionButton('CREDITS', Icons.credit_score),
                _buildActionButton('BENEFITS', Icons.card_membership),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AVAILABLE CREDIT LIMIT',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$32,781.00',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$24,890.00 Spent'),
                        Text('\$50,000.00 Total credit limit'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Last updated from bank on 4 Jul, 10:24AM',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            CardOutline(
              child: Column(
                children: [
                  const Text(
                    'Top categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              ),
            ),
            const SizedBox(height: 16),
            const RecentTransactions(),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
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
                          onPressed: () {},
                          child: const Text('Call customer care'),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CachedNetworkImage(
                      imageUrl:
                          'https://placehold.co/80x80.png?description=Support%20image',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.black),
        const SizedBox(height: 8),
        Text(text, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildCategoryItem(String title, String amount, String percentage,
      IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(percentage),
        trailing:
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String amount, String date,
      String status, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CachedNetworkImage(imageUrl: imageUrl, width: 40, height: 40),
        title: Text(title),
        subtitle: Text('$date • $status'),
        trailing:
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
