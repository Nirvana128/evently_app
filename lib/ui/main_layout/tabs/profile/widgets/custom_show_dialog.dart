import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomShowDialog extends StatelessWidget {
  final String title;
  final String contentText;
  final VoidCallback onConfirm;
  const CustomShowDialog({
    super.key,
    required this.title,
    required this.contentText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 5.horizontalPadding,
      child: InkWell(
        onTap: () async {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(contentText),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    AppLocalizations.of(context)!.confirm,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: ImageIcon(
          AssetImage(Assets.iconsLogout),
          color: Theme.of(context).colorScheme.error,
          size: 32.width,
        ),
      ),
    );
  }
}
