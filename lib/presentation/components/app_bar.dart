import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roqqu/utils/extensions/theme_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.isDarkMode;

    final logo = isDarkMode ? 'assets/logo/whitelogo.svg' : 'assets/logo/blacklogo.svg';
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(logo, width: 36, height: 24),
          Row(
            children: [
              Icon(Icons.language, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 16.r,
                backgroundImage: const NetworkImage('https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=800'),
              ),
              const SizedBox(width: 4),
              PopupMenuButton<int>(
                onSelected: (item) {},
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text('Exchange'),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('Wallet'),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text('Roqqu Hub'),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text('Logout'),
                  ),
                ],

                icon: const Icon(Icons.menu),

              ),            ],
          ),
        ],
      ),
    );
  }
}
