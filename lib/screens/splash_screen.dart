import 'package:flutter/material.dart';
import 'package:fv_frontend_task/constants/app_colors.dart';
import 'package:fv_frontend_task/router/routes.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _initialize() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 2));
      context.pushReplacementNamed(AppRoute.cardListing.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: Center(
        child: Image.asset("assets/icons/getfinvest_logo.jpeg"),
      ),
    );
  }
}
