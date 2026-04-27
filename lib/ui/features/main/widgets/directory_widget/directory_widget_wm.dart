import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_widget.dart';
import 'package:code_generator_app/ui/features/main/widgets/directory_widget/directory_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract interface class IDirectoryDrawerWidgetModel implements IWidgetModel {
  TextEditingController get searchController;

  ValueListenable<bool> get isSearchModeListenable;

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

class DirectoryDrawerWidgetModel extends WidgetModel<DirectoryDrawerWidget, IDirectoryDrawerModel>
    implements IDirectoryDrawerWidgetModel {
  DirectoryDrawerWidgetModel(super.model);

  final _searchController = TextEditingController();

  @override
  TextEditingController get searchController => _searchController;

  final _isSearchModeEntity = ValueNotifier<bool>(false);

  @override
  ValueNotifier<bool> get isSearchModeListenable => _isSearchModeEntity;

  @override
  void initWidgetModel() {
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
    _isSearchModeEntity.value = !_isSearchModeEntity.value;

    if (!_isSearchModeEntity.value) _searchController.clear();
  }

  @override
  void onSearchChanged(String value) => {};

  @override
  List<Keyword> filterKeywords(List<Keyword> source) {
    return model.filterKeywords(
      source: source,
      query: _searchController.text,
    );
  }
}
