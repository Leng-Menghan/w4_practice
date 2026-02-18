
import 'package:flutter/material.dart';

import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widget/theme_color_button.dart';

class ThemeService extends ChangeNotifier {
  ThemeColor themeColor = currentThemeColor;

  void onClick(ThemeColor selectedTheme){
    themeColor = selectedTheme;
    notifyListeners();
  }
}

ThemeService themeService = ThemeService();

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeService,
      builder:(context, child) => Container(
        color: themeService.themeColor.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              "Settings",
              style: AppTextStyles.heading.copyWith(
                color: themeService.themeColor.color,
              ),
            ),
      
            SizedBox(height: 50),
      
            Text(
              "Theme",
              style: AppTextStyles.label.copyWith(color: AppColors.textLight),
            ),
      
            SizedBox(height: 10),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ThemeColor.values
                  .map(
                    (theme) => ThemeColorButton(
                      themeColor: theme,
                      isSelected: theme == themeService.themeColor,
                      onTap: (value) => themeService.onClick(value),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
 