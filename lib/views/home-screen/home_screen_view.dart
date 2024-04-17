// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../configs/assets/assets_path.dart';
import '../../widgets/cs_sliver_app_bar.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CsSliverAppBar(
        title: 'Seja bem-vindo ao',
        image: Image.asset(
          AssetsPath.LOGO,
          width: 350,
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 0,
            spacing: 0,
            alignment: WrapAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
