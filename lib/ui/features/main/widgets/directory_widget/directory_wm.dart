import 'package:code_generator_app/common/utils/notification/app_notification.dart';
import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_widget.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract interface class IDirectoryDrawerWidgetModel implements IWidgetModel {
  TextEditingController get searchController;

  ValueListenable<bool> get isSearchModeListenable;

  ValueListenable<List<Keyword>> get keywordsListenable;

  void onBackTap();

  void onSearchTap();

  void onSearchChanged(String value);

  Future<void> onClearAllTap();

  Future<void> onDeleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  });

  Future<void> onLoginLongPress({
    required String enteredLogin,
    required String enteredKeyword,
  });

  Future<void> onKeywordLongPress(String enteredKeyword);

  BuildContext get context;
}

DirectoryDrawerWidgetModel defaultDirectoryDrawerWidgetModelFactory(
  BuildContext context,
) {
  return DirectoryDrawerWidgetModel(
    DirectoryDrawerModel(context.read<IDiskDataRepository>()),
  );
}

class DirectoryDrawerWidgetModel extends WidgetModel<DirectoryDrawerWidget, IDirectoryDrawerModel>
    implements IDirectoryDrawerWidgetModel {
  DirectoryDrawerWidgetModel(super.model);

  final _searchController = TextEditingController();
  final _isSearchModeEntity = ValueNotifier<bool>(false);
  final _keywordsNotifier = ValueNotifier<List<Keyword>>(const []);

  @override
  TextEditingController get searchController => _searchController;

  @override
  ValueNotifier<bool> get isSearchModeListenable => _isSearchModeEntity;

  @override
  ValueListenable<List<Keyword>> get keywordsListenable => _keywordsNotifier;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.keywordsListenable.addListener(_updateKeywords);
    _updateKeywords();
  }

  @override
  void dispose() {
    model.keywordsListenable.removeListener(_updateKeywords);
    _searchController.dispose();
    _isSearchModeEntity.dispose();
    _keywordsNotifier.dispose();
    super.dispose();
  }

  void _updateKeywords() => _keywordsNotifier.value = model.filterKeywords(
        source: model.keywordsListenable.value,
        query: _searchController.text,
      );

  @override
  void onBackTap() => Navigator.pop(context);

  @override
  void onSearchTap() {
    _isSearchModeEntity.value = !_isSearchModeEntity.value;

    if (!_isSearchModeEntity.value) {
      _searchController.clear();
      _updateKeywords();
    }
  }

  @override
  void onSearchChanged(String value) => _updateKeywords();

  @override
  Future<void> onClearAllTap() async {
    await AppNotification.showConfirmDialog(
      context: context,
      content: 'Вы уверены что хотите очистить список?',
      onConfirmTap: () async {
        await model.clearAll();
        _updateKeywords();
      },
    );
  }

  @override
  Future<void> onDeleteWebsite({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    await model.deleteWebsite(
      enteredWebsite: enteredWebsite,
      enteredLogin: enteredLogin,
      enteredKeyword: enteredKeyword,
    );
    _updateKeywords();
  }

  @override
  Future<void> onLoginLongPress({
    required String enteredLogin,
    required String enteredKeyword,
  }) async {
    final loginLabel = enteredLogin.isEmpty ? 'Без логина' : enteredLogin;

    await AppNotification.showConfirmDialog(
      context: context,
      content: 'Вы уверены что хотите удалить логин $loginLabel?',
      onConfirmTap: () async {
        await model.deleteLogin(
          enteredLogin: enteredLogin,
          enteredKeyword: enteredKeyword,
        );
        _updateKeywords();
      },
    );
  }

  @override
  Future<void> onKeywordLongPress(String enteredKeyword) async {
    await AppNotification.showConfirmDialog(
      context: context,
      content: 'Вы уверены что хотите удалить слово $enteredKeyword?',
      onConfirmTap: () async {
        await model.deleteKeyword(enteredKeyword);
        _updateKeywords();
      },
    );
  }
}
