import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_widget.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

abstract interface class IDirectoryDrawerWidgetModel implements IWidgetModel {
  TextEditingController get searchController;

  EntityValueListenable<bool> get isSearchModeListenable;

  EntityValueListenable<String> get searchQueryListenable;

  void onBackTap();

  void onSearchTap();

  void onSearchChanged(String value);

  List<Keyword> filterKeywords(List<Keyword> source);

  BuildContext get context;
}

DirectoryDrawerWidgetModel defaultDirectoryDrawerWidgetModelFactory(
  BuildContext context,
) {
  return DirectoryDrawerWidgetModel(
    DirectoryDrawerModel(),
  );
}

class DirectoryDrawerWidgetModel
    extends WidgetModel<DirectoryDrawerWidget, IDirectoryDrawerModel>
    implements IDirectoryDrawerWidgetModel {
  DirectoryDrawerWidgetModel(super.model);

  final _searchController = TextEditingController();

  @override
  TextEditingController get searchController => _searchController;

  final _isSearchModeEntity = EntityStateNotifier<bool>();

  @override
  EntityValueListenable<bool> get isSearchModeListenable => _isSearchModeEntity;

  final _searchQueryEntity = EntityStateNotifier<String>();

  @override
  EntityValueListenable<String> get searchQueryListenable => _searchQueryEntity;

  @override
  void initWidgetModel() {
    _isSearchModeEntity.content(false);
    _searchQueryEntity.content('');
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void onBackTap() => Navigator.pop(context);

  @override
  void onSearchTap() {
    final isSearchMode = _isSearchModeEntity.value.data ?? false;
    final isNextSearchMode = !isSearchMode;

    _isSearchModeEntity.content(isNextSearchMode);

    if (!isNextSearchMode) {
      _searchController.clear();
      _searchQueryEntity.content('');
    }
  }

  @override
  void onSearchChanged(String value) => _searchQueryEntity.content(value);

  @override
  List<Keyword> filterKeywords(List<Keyword> source) {
    return model.filterKeywords(
      source: source,
      query: _searchQueryEntity.value.data ?? '',
    );
  }
}
