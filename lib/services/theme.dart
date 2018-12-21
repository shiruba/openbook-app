import 'package:Openbook/models/theme.dart';
import 'package:Openbook/services/storage.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class ThemeService {
  Stream<OBTheme> get themeChange => _themeChangeSubject.stream;
  final _themeChangeSubject = ReplaySubject<OBTheme>(maxSize: 1);

  Random random = new Random();

  OBTheme _activeTheme;

  OBStorage _storage;

  List<OBTheme> _themes = [
    OBTheme(
        id: 1,
        name: 'White Gold',
        primaryTextColor: '#505050',
        secondaryTextColor: '#676767',
        primaryColor: '#ffffff',
        primaryAccentColor: '#e9a039,#f0c569',
        successColor: '#7ED321',
        successColorAccent: '#ffffff',
        dangerColor: '#FF3860',
        dangerColorAccent: '#ffffff',
        themePreview:
            'assets/images/theme-previews/theme-preview-white-gold.png'),
    OBTheme(
        id: 2,
        name: 'Dark Gold',
        primaryTextColor: '#ffffff',
        secondaryTextColor: '#b3b3b3',
        primaryColor: '#000000',
        primaryAccentColor: '#e9a039,#f0c569',
        successColor: '#7ED321',
        successColorAccent: '#ffffff',
        dangerColor: '#FF3860',
        dangerColorAccent: '#ffffff',
        themePreview:
            'assets/images/theme-previews/theme-preview-dark-gold.png'),
    OBTheme(
        id: 3,
        name: 'Light',
        primaryTextColor: '#505050',
        secondaryTextColor: '#676767',
        primaryColor: '#ffffff',
        primaryAccentColor: '#ffdd00,#f93476',
        successColor: '#7ED321',
        successColorAccent: '#ffffff',
        dangerColor: '#FF3860',
        dangerColorAccent: '#ffffff',
        themePreview: 'assets/images/theme-previews/theme-preview-white.png'),
    OBTheme(
        id: 4,
        name: 'Dark',
        primaryTextColor: '#ffffff',
        secondaryTextColor: '#b3b3b3',
        primaryColor: '#000000',
        primaryAccentColor: '#ffdd00,#f93476',
        successColor: '#7ED321',
        successColorAccent: '#ffffff',
        dangerColor: '#FF3860',
        dangerColorAccent: '#ffffff',
        themePreview: 'assets/images/theme-previews/theme-preview-dark.png'),
  ];

  ThemeService() {
    _setActiveTheme(_themes[2]);
  }

  void setStorageService(StorageService storageService) {
    _storage = storageService.getSecureStorage(namespace: 'theme');
    this._bootstrap();
  }

  void setActiveTheme(OBTheme theme) {
    _setActiveTheme(theme);
    _storeActiveThemeId(theme.id);
  }

  void _bootstrap() async {
    int activeThemeId = await _getStoredActiveThemeId();
    if (activeThemeId != null) {
      OBTheme activeTheme = await _getThemeWithId(activeThemeId);
      _setActiveTheme(activeTheme);
    }
  }

  void _setActiveTheme(OBTheme theme) {
    _activeTheme = theme;
    _themeChangeSubject.add(theme);
  }

  void _storeActiveThemeId(int themeId) {
    if (_storage != null) _storage.set('activeThemeId', themeId.toString());
  }

  Future<OBTheme> _getThemeWithId(int id) async {
    return _themes.firstWhere((OBTheme theme) {
      return theme.id == id;
    });
  }

  Future<int> _getStoredActiveThemeId() async {
    String activeThemeId = await _storage.get('activeThemeId');
    return activeThemeId != null ? int.parse(activeThemeId) : null;
  }

  OBTheme getActiveTheme() {
    return _activeTheme;
  }

  bool isActiveTheme(OBTheme theme) {
    return theme.id == this.getActiveTheme().id;
  }

  List<OBTheme> getCuratedThemes() {
    return _themes.toList();
  }

  String generateRandomHexColor(){
    int length = 6;
    String chars = '0123456789ABCDEF';
    String hex = '#';
    while(length-- > 0) hex += chars[(random.nextInt(16)) | 0];
    return hex;
  }
}
