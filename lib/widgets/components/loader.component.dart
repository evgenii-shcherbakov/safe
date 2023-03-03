import 'package:flutter/material.dart';

class LoaderComponent extends StatelessWidget {
  const LoaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      widthFactor: double.infinity,
      heightFactor: double.infinity,
      child: CircularProgressIndicator(
        value: null,
        strokeWidth: 5,
      ),
    );
  }
}
