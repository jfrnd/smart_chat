// Project imports:
import 'package:smart_chat/domain/entities/user/password.dart';

const VALID_PASSWORD = '123456789';
final validPassword = Password(VALID_PASSWORD);

const INVALID_PASSWORD = 'abc';
final invalidPassword = Password(INVALID_PASSWORD);
