import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';
import 'package:intern_app/core/widgets/banner_top_button.dart';
import 'package:intern_app/features/user/widgets/user_search.dart';

class UserBannerTop extends StatelessWidget {
  const UserBannerTop({super.key, required this.bannerTopButtons});

  final List<Widget> bannerTopButtons;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      width:
          windowDesktopAppWidth(context) -
          (windowDesktopAppWidth(context) * 0.2),
      height: windowDesktopAppHeight(context) * 0.136,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Usuários",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 32,
            ),
          ),
          Row(
            spacing: 24,
            children: bannerTopButtons
          ),
        ],
      ),
    );
  }
}
