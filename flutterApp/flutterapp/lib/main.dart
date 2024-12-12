import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'appointments/appointments_model.dart';
import 'appointments/appointments_list.dart';
import 'contacts/contacts_model.dart';
import 'contacts/contacts_list.dart';
import 'notes/notes_model.dart';
import 'notes/notes_list.dart';
import 'tasks/tasks_model.dart';
import 'tasks/tasks_list.dart';
import 'clicker/clicker_model.dart';
import 'clicker/clicker_page.dart';

void main() {
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
        ChangeNotifierProvider(create: (_) => ClickerModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Book',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DefaultTabController(
          length: 5,  // Обновлено для добавления новой вкладки
          child: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Book'),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Appointments'),
                  Tab(text: 'Contacts'),
                  Tab(text: 'Notes'),
                  Tab(text: 'Tasks'),
                  Tab(text: 'Clicker'), 
                ],
              ),
            ),
            body: TabBarView(
              children: [
                AppointmentsList(),
                ContactsList(),
                NotesList(),
                TasksList(),
                ClickerPage(),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
