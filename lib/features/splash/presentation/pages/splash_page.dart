import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/design/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {

  late final AnimationController controller;

  late final Animation<double> opacity;

  late final Animation<double> scale;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    opacity = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    scale = Tween<double>(
      begin: .75,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    controller.forward();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          "/dashboard",
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: FadeTransition(
          opacity: opacity,

          child: ScaleTransition(
            scale: scale,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                SvgPicture.asset(
                  Assets.logo,
                  width: 240,
                ),

                const SizedBox(height: 28),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
