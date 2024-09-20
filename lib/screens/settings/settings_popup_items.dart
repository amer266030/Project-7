enum SettingsPopupItems { about, terms, policy }

extension Values on SettingsPopupItems {
  String get title {
    switch (this) {
      case SettingsPopupItems.about:
        return 'About Us';
      case SettingsPopupItems.terms:
        return 'Terms & Conditions';
      case SettingsPopupItems.policy:
        return 'Privacy Policy';
    }
  }

  String get description {
    switch (this) {
      case SettingsPopupItems.about:
        return 'Education Administration Programs';
      case SettingsPopupItems.terms:
        return 'This is Terms & Conditions';
      case SettingsPopupItems.policy:
        return 'This is Privacy Policy';
    }
  }
}
