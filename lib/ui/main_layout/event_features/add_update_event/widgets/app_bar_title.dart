import 'package:evently/ui/initial_flow/widgets/app_bar_back_button.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppBarTitle({super.key, required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Row(
        mainAxisAlignment: .end,
        children: [
          AppBarBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      actions: actions,
    );
  }
}
