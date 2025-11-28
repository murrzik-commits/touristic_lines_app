import 'package:flutter/material.dart';

/// Панель настроек приложения с выбором языка и темы оформления
class SettingsPanel extends StatefulWidget {
  /// Колбэк функция для закрытия панели настроек
  final VoidCallback onClose;
  
  /// Колбэк функция для очистки маршрутов (в текущей реализации не используется)
  final VoidCallback onClearRoutes;

  /// Конструктор панели настроек
  /// 
  /// Аргументы:
  /// [onClose] - функция вызываемая при закрытии панели
  /// [onClearRoutes] - функция для очистки маршрутов (зарезервировано для будущего использования)
  const SettingsPanel({
    super.key, 
    required this.onClose,
    required this.onClearRoutes,
  });

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  /// Выбранный язык приложения
  String _selectedLanguage = 'RU';
  
  /// Выбранная тема оформления
  ThemeMode _selectedTheme = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5, // Ширина 50% от экрана
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Тень для эффекта глубины
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Шапка панели с заголовком и кнопкой закрытия
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50], // Светло-серый фон шапки
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Заголовок "Настройки"
                const Text(
                  'Настройки',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                /// Кнопка закрытия панели
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF2E2E2E)),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),
          
          /// Основное содержимое настроек
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Секция настройки языка
                  _buildSettingSection(
                    title: 'Язык',
                    children: [
                      _buildLanguageOption('RU', 'Русский'),
                      _buildLanguageOption('EN', 'English'),
                      _buildLanguageOption('CY', 'Chinese'),
                    ],
                  ),
                  
                  const SizedBox(height: 24), // Отступ между секциями
                  
                  /// Секция настройки темы оформления
                  _buildSettingSection(
                    title: 'Тема оформления',
                    children: [
                      _buildThemeOption(ThemeMode.light, 'Светлая'),
                      _buildThemeOption(ThemeMode.dark, 'Тёмная'),
                      _buildThemeOption(ThemeMode.system, 'Системная'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Строит секцию настроек с заголовком и списком опций
  /// 
  /// Аргументы:
  /// [title] - заголовок секции настроек
  /// [children] - список виджетов опций для этой секции
  /// 
  /// Возвращает:
  /// [Widget] - колонка с заголовком и опциями
  Widget _buildSettingSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Заголовок секции
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E2E2E),
          ),
        ),
        const SizedBox(height: 12), // Отступ между заголовком и опциями
        ...children, // Распаковка списка опций
      ],
    );
  }

  /// Строит опцию выбора языка
  /// 
  /// Аргументы:
  /// [language] - код языка (RU, EN, CY)
  /// [label] - отображаемое название языка
  /// 
  /// Возвращает:
  /// [Widget] - интерактивный элемент выбора языка
  Widget _buildLanguageOption(String language, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8), // Отступ между опциями
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8), // Закругленные углы области нажатия
          onTap: () {
            setState(() {
              _selectedLanguage = language; // Обновление выбранного языка
            });
          },
          child: Container(
            width: double.infinity, // Ширина на всю доступную область
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _selectedLanguage == language 
                  ? const Color(0xFF2E2E2E).withOpacity(0.1) // Подсветка выбранной опции
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _selectedLanguage == language 
                    ? const Color(0xFF2E2E2E) // Темная граница для выбранной опции
                    : Colors.grey[300]!, // Светлая граница для невыбранных
                width: 1,
              ),
            ),
            child: Text(
              '$label ($language)', // Формат: "Русский (RU)"
              style: TextStyle(
                color: const Color(0xFF2E2E2E),
                fontWeight: _selectedLanguage == language 
                    ? FontWeight.w600 // Полужирный для выбранной опции
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Строит опцию выбора темы оформления
  /// 
  /// Аргументы:
  /// [theme] - режим темы (light, dark, system)
  /// [label] - отображаемое название темы
  /// 
  /// Возвращает:
  /// [Widget] - интерактивный элемент выбора темы
  Widget _buildThemeOption(ThemeMode theme, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _selectedTheme = theme; // Обновление выбранной темы
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _selectedTheme == theme 
                  ? const Color(0xFF2E2E2E).withOpacity(0.1) // Подсветка выбранной опции
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _selectedTheme == theme 
                    ? const Color(0xFF2E2E2E) // Темная граница для выбранной опции
                    : Colors.grey[300]!, // Светлая граница для невыбранных
                width: 1,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF2E2E2E),
                fontWeight: _selectedTheme == theme 
                    ? FontWeight.w600 // Полужирный для выбранной опции
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}