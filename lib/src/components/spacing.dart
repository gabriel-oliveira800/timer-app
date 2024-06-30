import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final double value;
  final Axis axis;

  const Spacing({
    super.key,
    required this.value,
    this.axis = Axis.vertical,
  });

  const Spacing.vertical(double value, {Key? key})
      : this(value: value, key: key);

  const Spacing.horizontal(double value, {Key? key})
      : this(value: value, key: key, axis: Axis.horizontal);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: axis == Axis.vertical,
      replacement: SizedBox(width: value),
      child: SizedBox(height: value),
    );
  }
}
