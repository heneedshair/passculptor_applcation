import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    List<String> items = ['Встроенный метод', 'HashCode метод'];

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Center(
          child: Column(
            children: [
              const Text('Выберите метод создания пароля', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
              DropdownButton<String>(
                value: selectedValue,
                hint: const Text('Встроенный метод'),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
