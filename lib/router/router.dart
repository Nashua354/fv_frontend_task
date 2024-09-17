import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/bloc/card_cubit/card_cubit.dart';
import 'package:fv_frontend_task/bloc/transactions_cubit/transaction_cubit.dart';
import 'package:fv_frontend_task/router/routes.dart';
import 'package:fv_frontend_task/screens/card_details_screen.dart';
import 'package:fv_frontend_task/screens/cards_listing_screen.dart';
import 'package:fv_frontend_task/screens/dashboard.dart';
import 'package:fv_frontend_task/screens/settings.dart';
import 'package:fv_frontend_task/screens/splash_screen.dart';
import 'package:fv_frontend_task/screens/transactions_list_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePath.dashboard,
      name: AppRoute.dashboard.name,
      builder: (context, state) => const DashboardScreen(),
      routes: [
        GoRoute(
          path: RoutePath.cardListing,
          name: AppRoute.cardListing.name,
          builder: (context, state) => MultiBlocProvider(providers: [
            BlocProvider(create: (_) => CardCubit()),
            BlocProvider(create: (_) => TransactionCubit()),
          ], child: CreditCardScreen()),
          routes: [
            GoRoute(
              path: RoutePath.transactions,
              name: AppRoute.transactions.name,
              builder: (context, state) => BlocProvider(
                  create: (_) => TransactionCubit(), child: TransactionsPage()),
            ),
            GoRoute(
              path: RoutePath.cardDetails,
              name: AppRoute.cardDetails.name,
              builder: (context, state) => CardDetailsScreen(),
            ),
          ],
        ),
        GoRoute(
          path: RoutePath.settings,
          name: AppRoute.settings.name,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(state.error.toString()),
    ),
  ),
);
