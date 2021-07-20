// Project imports:
import 'package:smart_chat/domain/entities/user/email_address.dart';

const VALID_EMAIL = 'example@google.de';
final validEmail = EmailAddress(VALID_EMAIL);

const VALID_EMAIL2 = 'example@google.de';
final validEmail2 = EmailAddress(VALID_EMAIL);

const INVALID_EMAIL = 'abc';
final invalidEmail = EmailAddress(INVALID_EMAIL);
