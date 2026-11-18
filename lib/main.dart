import 'package:flutter/material.dart';
import 'package:todo_app/pages/task_list_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do list',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF2D675),      // giallo: checkbox, switch, pulsanti
          onPrimary: Colors.black,         // testo/segno sopra il giallo
          secondary: Color(0xFFF2D675),
          surface: Color(0xFF1E1E1E),
          onSurface: Colors.white,         // testo principale bianco
          error: Color(0xFFFF6B6B),        // rosso chiaro, leggibile su scuro
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Color(0xFFF2D675), // titolo e icone gialli
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF2D675),
          foregroundColor: Colors.black,
        ),
      ),
      home: const TaskListScreen(),
    );
  }
}