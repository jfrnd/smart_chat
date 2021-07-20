// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/presentation/core/widgets/loading_in_progress_overlay.dart';
import 'package:smart_chat/presentation/editor/widgets/edit_translation_list_tile.dart';
import 'package:smart_chat/presentation/core/flushbar_helper.dart';
import '../../../injection.dart';

class TranslationsEditorDialogPage<
    T extends TranslatableEntity,
    V extends StringValueObject,
    E extends EntityEditorCubit<T, V>> extends StatelessWidget {
  final T initEntity;
  final BuildContext context;

  const TranslationsEditorDialogPage({
    Key? key,
    required this.initEntity,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext newContext) {
    return BlocProvider(
      create: (context) => getIt<E>()..initializedForEditing(initEntity),
      child: BlocConsumer<E, EntityEditorState<T>>(
        listenWhen: (p, c) => p.saveFailureOrSuccess != c.saveFailureOrSuccess,
        listener: (context, state) {
          state.saveFailureOrSuccess?.fold(
            (failure) => showCrudFailureMessage(failure, context),
            (unit) => AutoRouter.of(context).pop(),
          );
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (context, state) => Stack(
          children: [
            TranslationsEditorDialogScaffold<T, V, E>(initEntity: initEntity),
            LoadingInProgressOverlay(isLoading: state.isSaving),
          ],
        ),
      ),
    );
  }
}

class TranslationsEditorDialogScaffold<
    T extends TranslatableEntity,
    V extends StringValueObject,
    E extends EntityEditorCubit<T, V>> extends StatelessWidget {
  final T initEntity;

  const TranslationsEditorDialogScaffold({
    Key? key,
    required this.initEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => context.read<E>().saved(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TranslationsList<T, V, E>(),
            AddMoreTranslationsButton<T, V, E>(),
            const SizedBox(height: 32.0)
          ],
        ),
      ),
    );
  }
}

class TranslationsList<
    T extends TranslatableEntity,
    V extends StringValueObject,
    E extends EntityEditorCubit<T, V>> extends StatelessWidget {
  const TranslationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<E, EntityEditorState<T>>(
      builder: (context, state) {
        final entity = state.entity!;
        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final languageCode =
                entity.translations.getSupportedLanguageCodesOrCrash()[index];
            final translation =
                entity.translations.getValueObjectOrCrash(languageCode);
            return EditTranslationListTile<T, V, E>(
              translation: translation as V,
              languageCode: languageCode,
              showError: false,
            );
          },
          itemCount: state.entity!.translations
              .getSupportedLanguageCodesOrCrash()
              .size,
        );
      },
    );
  }
}

class AddMoreTranslationsButton<
    T extends TranslatableEntity,
    V extends StringValueObject,
    E extends EntityEditorCubit<T, V>> extends StatelessWidget {
  const AddMoreTranslationsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<E, EntityEditorState<T>>(
      builder: (context, state) {
        return Visibility(
          visible: state.entity!.translations
              .getUnsupportedLanguageCodesOrCrash()
              .asList()
              .isNotEmpty,
          child: TextButton.icon(
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () => showChooseLanguageCodeDialog<T, V, E>(context),
            icon: const Icon(Icons.add),
            label: const Text("Add more translations"),
          ),
        );
      },
    );
  }
}
