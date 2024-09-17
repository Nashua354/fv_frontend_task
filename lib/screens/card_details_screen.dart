import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
            color: Colors.black),
        title: Text(
          'Credit cards',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
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
                        Text(
                          'VISA',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      '**** **** **** 7628',
                      style: TextStyle(fontSize: 24, letterSpacing: 2),
                    ),
                    SizedBox(height: 16),
                    Container(
                      color: Color(0xFF0074CC),
                      padding: EdgeInsets.all(16),
                      child: Row(
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton('DETAILS', Icons.info),
                _buildActionButton('REWARDS', Icons.card_giftcard),
                _buildActionButton('CREDITS', Icons.credit_score),
                _buildActionButton('BENEFITS', Icons.card_membership),
              ],
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AVAILABLE CREDIT LIMIT',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$32,781.00',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$24,890.00 Spent'),
                        Text('\$50,000.00 Total credit limit'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Last updated from bank on 4 Jul, 10:24AM',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Top categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildCategoryItem('Foods & dining', '-\$110.32', '90% of spends',
                Icons.restaurant, Colors.blue),
            _buildCategoryItem('Apps & software', '-\$2600.45', '90% of spends',
                Icons.apps, Colors.orange),
            _buildCategoryItem('Health & wellness', '-\$1400.94',
                '4% of spends', Icons.health_and_safety, Colors.purple),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: Text('SEE ALL CATEGORIES'),
            ),
            SizedBox(height: 16),
            Text(
              'Recent transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildTransactionItem(
                'Uber',
                '-\$82.00',
                '22 Jun 24, 4:25pm',
                'Pending',
                'https://placehold.co/40x40.png?description=Uber%20logo'),
            _buildTransactionItem(
                'Starbucks',
                '-\$110.00',
                '22 Jun 24, 4:25pm',
                'Pending',
                'https://placehold.co/40x40.png?description=Starbucks%20logo'),
            _buildTransactionItem(
                'Mc Donalds',
                '-\$110.00',
                '22 Jun 24, 4:25pm',
                'Pending',
                'https://placehold.co/40x40.png?description=Mc%20Donalds%20logo'),
            _buildTransactionItem(
                'Ikea',
                '-\$110.00',
                '22 Jun 24, 4:25pm',
                'Pending',
                'https://placehold.co/40x40.png?description=Ikea%20logo'),
            _buildTransactionItem(
                'JBL technologies',
                '-\$110.00',
                '22 Jun 24, 4:25pm',
                'Pending',
                'https://placehold.co/40x40.png?description=JBL%20technologies%20logo'),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: Text('SEE ALL TRANSACTIONS'),
            ),
            SizedBox(height: 16),
            Card(
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
                        Text(
                          'Need any help?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Our representative will call you'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Call customer care'),
                        ),
                      ],
                    ),
                    Spacer(),
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
        SizedBox(height: 8),
        Text(text, style: TextStyle(color: Colors.black)),
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
        trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
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
        trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
