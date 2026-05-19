import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:flutter/material.dart';

class EventImage extends StatelessWidget {
  final String imagePath;
  const EventImage({
    super.key, required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
    );
  }
}