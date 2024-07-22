// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Widget  tha holds three widgets in a row
class TrippleRail extends StatelessWidget {
  /// TrippleRail
  const TrippleRail({
    super.key,
    this.leading,
    this.middle,
    this.trailing,
    this.leadingExpanded = false,
    this.middleExpanded = false,
    this.trailExpanded = false,
    this.onTap,
  });
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final bool leadingExpanded;
  final bool middleExpanded;
  final bool trailExpanded;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (leadingExpanded)
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              heightFactor: 1,
              child: leading,
            ))
          else
            Align(
              alignment: Alignment.centerLeft,
              heightFactor: 1,
              child: leading,
            ),
          if (middle != null) middle!,
          if (trailExpanded)
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              heightFactor: 3,
              child: trailing,
            ))
          else
            Align(
              alignment: Alignment.centerRight,
              heightFactor: 1,
              child: trailing,
            ),
        ],
      ),
    );
  }
}
