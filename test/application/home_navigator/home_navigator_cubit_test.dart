import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:smart_chat/application/home_navigator/home_navigator_cubit.dart';

void main() {
  late HomeNavigatorCubit cubit;

  setUp(() {
    cubit = HomeNavigatorCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('chatsSelected()', () {
    //TODO chatsSelected
  });
  group('discoverSelected()', () {
    //TODO discoverSelected
  });
  group('meSelected()', () {
    //TODO meSelected
  });
}
