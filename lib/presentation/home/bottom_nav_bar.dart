// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_chat/application/home_navigator/home_navigator_cubit.dart';

// Project imports:

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
              top: Divider.createBorderSide(context, color: Colors.grey))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: BlocBuilder<HomeNavigatorCubit, HomeNavigatorState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BottomNavBarItem(
                  label: 'Chats',
                  iconData: Icons.question_answer_outlined,
                  color: state.maybeMap(
                      chatsSelected: (_) => Theme.of(context).primaryColor,
                      orElse: () => Colors.black),
                  onTap: () =>
                      context.read<HomeNavigatorCubit>().chatsSelected(),
                ),
                BottomNavBarItem(
                  label: 'Discover',
                  iconData: Icons.search,
                  color: state.maybeMap(
                      discoverSelected: (_) => Theme.of(context).primaryColor,
                      orElse: () => Colors.black),
                  onTap: () =>
                      context.read<HomeNavigatorCubit>().discoverSelected(),
                ),
                BottomNavBarItem(
                  label: 'Me',
                  iconData: Icons.person,
                  color: state.maybeMap(
                      meSelected: (_) => Theme.of(context).primaryColor,
                      orElse: () => Colors.black),
                  onTap: () => context.read<HomeNavigatorCubit>().meSelected(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final IconData iconData;
  final String label;

  const BottomNavBarItem({
    Key? key,
    required this.onTap,
    required this.color,
    required this.iconData,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
