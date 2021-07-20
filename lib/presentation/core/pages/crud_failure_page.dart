// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';

class CrudFailureDisplay extends StatelessWidget {
  final CrudFailure failure;

  const CrudFailureDisplay({
    Key? key,
    required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: failure.map(
        doesNotExist: (_) => const Text('Document does not exist'),
        notSignedIn: (_) => const Text('Not Signed In'),
        dataSchemaError: (_) => const Text('''Data Schema Error. 
                    For Developer: Check Data schema in the Firebase Console 
                    and restart app with calling the clearPersistence() method.'''),
        imageFailure: (_) => const Text('ImageFailure'),
        unexpected: (error) => Text('Unexpected: ${error.info}'),
        insufficientPermission: (_) => const Text('InsufficientPermission'),
        unableToUpdate: (_) => const Text('UnableToUpdate'),
        dataBaseNotSynchonWarning: (_) => const Text(
            'WARNING: Database not syncrhon anymore. Please contact support.'),
      ),
    );
  }
}
