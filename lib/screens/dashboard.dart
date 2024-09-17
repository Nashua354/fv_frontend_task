import 'package:flutter/material.dart';
import 'package:fv_frontend_task/router/routes.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finvest"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          Card(
            child: IconButton(
              icon: Icon(Icons.credit_card),
              onPressed: () {
                context.pushNamed(AppRoute.cardListing.name);
              },
            ),
          ),
          Card(
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                context.pushNamed(AppRoute.settings.name);
              },
            ),
          )
        ],
      ),
    );
  }
}
