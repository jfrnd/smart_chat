// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvertedListTile extends StatelessWidget {
  final Widget? leading;
  final String overline;
  final String body;
  final Widget? trailing;
  final Function()? onLongPress;
  final Function()? onTap;
  final bool enabled;
  final Color? tileColor;
  final bool? dense;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enableFeedback;
  final Color? focusColor;
  final FocusNode? focusNode;
  final double? horizontalTitleGap;
  final Color? hoverColor;
  final bool isThreeLine;
  final double? minLeadingWidth;
  final double? minVerticalPadding;
  final MouseCursor? mouseCursor;
  final bool selected;
  final Color? selectedTileColor;
  final ShapeBorder? shape;
  final VisualDensity? visualDensity;
  final Color? bodyColor;

  const InvertedListTile({
    Key? key,
    this.leading,
    required this.overline,
    required this.body,
    this.trailing,
    this.onLongPress,
    this.onTap,
    this.enabled = true,
    this.tileColor,
    this.dense,
    this.autofocus = false,
    this.contentPadding,
    this.enableFeedback,
    this.focusColor,
    this.focusNode,
    this.horizontalTitleGap,
    this.hoverColor,
    this.isThreeLine = false,
    this.minLeadingWidth,
    this.minVerticalPadding,
    this.mouseCursor,
    this.selected = false,
    this.selectedTileColor,
    this.shape,
    this.visualDensity,
    this.bodyColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [leading ?? Container()],
      ),
      title: Text(
        overline,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        body,
        style: TextStyle(
          color: bodyColor ?? Colors.black,
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
      onLongPress: onLongPress,
      onTap: onTap,
      enabled: enabled,
      tileColor: tileColor,
      dense: dense,
      autofocus: autofocus,
      contentPadding: contentPadding,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusNode: focusNode,
      horizontalTitleGap: horizontalTitleGap,
      hoverColor: hoverColor,
      isThreeLine: isThreeLine,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      mouseCursor: mouseCursor,
      selected: selected,
      selectedTileColor: selectedTileColor,
      shape: shape,
      visualDensity: visualDensity,
    );
  }
}

class CenteredListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? subtitle;
  final Widget? title;
  final Widget? trailing;
  final Function()? onLongPress;
  final Function()? onTap;
  final bool enabled;
  final Color? tileColor;
  final bool? dense;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enableFeedback;
  final Color? focusColor;
  final FocusNode? focusNode;
  final double? horizontalTitleGap;
  final Color? hoverColor;
  final bool isThreeLine;
  final double? minLeadingWidth;
  final double? minVerticalPadding;
  final MouseCursor? mouseCursor;
  final bool selected;
  final Color? selectedTileColor;
  final ShapeBorder? shape;
  final VisualDensity? visualDensity;

  const CenteredListTile({
    Key? key,
    this.leading,
    this.subtitle,
    this.title,
    this.trailing,
    this.onLongPress,
    this.onTap,
    this.enabled = true,
    this.tileColor,
    this.dense,
    this.autofocus = false,
    this.contentPadding,
    this.enableFeedback,
    this.focusColor,
    this.focusNode,
    this.horizontalTitleGap,
    this.hoverColor,
    this.isThreeLine = false,
    this.minLeadingWidth,
    this.minVerticalPadding,
    this.mouseCursor,
    this.selected = false,
    this.selectedTileColor,
    this.shape,
    this.visualDensity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [leading ?? Container()],
      ),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onLongPress: onLongPress,
      onTap: onTap,
      enabled: enabled,
      tileColor: tileColor,
      dense: dense,
      autofocus: autofocus,
      contentPadding: contentPadding,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusNode: focusNode,
      horizontalTitleGap: horizontalTitleGap,
      hoverColor: hoverColor,
      isThreeLine: isThreeLine,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      mouseCursor: mouseCursor,
      selected: selected,
      selectedTileColor: selectedTileColor,
      shape: shape,
      visualDensity: visualDensity,
    );
  }
}
