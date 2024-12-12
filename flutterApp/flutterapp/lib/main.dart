import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Добавьте это
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; // Добавьте это
import 'appointments/appointments_model.dart';
import 'appointments/appointments_list.dart';
import 'contacts/contacts_model.dart';
import 'contacts/contacts_list.dart';
import 'notes/notes_model.dart';
import 'notes/notes_list.dart';
import 'tasks/tasks_model.dart';
import 'tasks/tasks_list.dart';

void main() {
  // Инициализация для sqflite_common_ffi
  sqfliteFfiInit();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    databaseFactory = databaseFactoryFfi;
  }

  runApp(FlutterBook());
}

class FlutterBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentsModel()),
        ChangeNotifierProvider(create: (_) => ContactsModel()),
        ChangeNotifierProvider(create: (_) => NotesModel()),
        ChangeNotifierProvider(create: (_) => TasksModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Book',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Book'),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Appointments'),
                  Tab(text: 'Contacts'),
                  Tab(text: 'Notes'),
                  Tab(text: 'Tasks'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                AppointmentsList(),
                ContactsList(),
                NotesList(),
                TasksList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
