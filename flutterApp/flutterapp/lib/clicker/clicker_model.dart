import 'package:flutter/material.dart';

class ClickerModel extends ChangeNotifier {
  int _count = 0;
  int _level = 1;
  int _points = 0;

  int get count => _count;
  int get level => _level;
  int get points => _points;

  void increment() {
    _count++;
    _points += 10; // Добавляем 10 очков за каждый клик

    // Повышение уровня за каждые 100 очков
    if (_points >= _level * 100) {
      _level++;
      _points -= _level * 100; // Сброс очков после повышения уровня
    }

    notifyListeners();
  }
}
