enum SettingsPopupItems { about, terms, policy, help }

extension Values on SettingsPopupItems {
  String get title {
    switch (this) {
      case SettingsPopupItems.about:
        return 'About Us';
      case SettingsPopupItems.terms:
        return 'Terms & Conditions';
      case SettingsPopupItems.policy:
        return 'Privacy Policy';
      case SettingsPopupItems.help:
        return 'Help & Support';
    }
  }

  String get description {
    switch (this) {
      case SettingsPopupItems.about:
        return 'Tuwaiq Academy is the leading institution for educational programs in advanced technology fields in the Kingdom of Saudi Arabia. It offers a variety of programs across different technical pathways for various age groups. The academy was announced in August 2019.';
      case SettingsPopupItems.terms:
        return 'This is Terms & Conditions';
      case SettingsPopupItems.policy:
        return 'This is Privacy Policy';
      case SettingsPopupItems.help:
        return 'This is Help & Support';
    }
  }
}
