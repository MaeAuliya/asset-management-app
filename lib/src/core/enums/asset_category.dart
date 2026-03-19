enum AssetCategory {
  laptop,
  projector,
}

extension AssetCategoryX on AssetCategory {
  String get label => switch (this) {
    AssetCategory.laptop => 'Laptop',
    AssetCategory.projector => 'Projector',
  };
}
