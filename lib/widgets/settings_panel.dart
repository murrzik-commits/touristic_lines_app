import 'package:flutter/material.dart';

class SettingsPanel extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onClearRoutes;

  const SettingsPanel({
    super.key, 
    required this.onClose,
    required this.onClearRoutes,
  });

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  String _selectedLanguage = 'RU';
  ThemeMode _selectedTheme = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Шапка с заголовком и крестиком
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Настройки',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF2E2E2E)),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),
          
          // Содержимое настроек
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Настройка языка
                  _buildSettingSection(
                    title: 'Язык',
                    children: [
                      _buildLanguageOption('RU', 'Русский'),
                      _buildLanguageOption('EN', 'English'),
                      _buildLanguageOption('CY', 'Chinese'),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Настройка темы
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

  Widget _buildSettingSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E2E2E),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildLanguageOption(String language, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _selectedLanguage = language;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _selectedLanguage == language 
                  ? const Color(0xFF2E2E2E).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _selectedLanguage == language 
                    ? const Color(0xFF2E2E2E)
                    : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Text(
              '$label ($language)',
              style: TextStyle(
                color: const Color(0xFF2E2E2E),
                fontWeight: _selectedLanguage == language 
                    ? FontWeight.w600 
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(ThemeMode theme, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _selectedTheme = theme;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _selectedTheme == theme 
                  ? const Color(0xFF2E2E2E).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _selectedTheme == theme 
                    ? const Color(0xFF2E2E2E)
                    : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF2E2E2E),
                fontWeight: _selectedTheme == theme 
                    ? FontWeight.w600 
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}