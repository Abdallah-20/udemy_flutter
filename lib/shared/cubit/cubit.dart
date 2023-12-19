import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import '../../modules/todo_app/archived_tasks/archive_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> Screens = [
    NewtasksScreen(),
    DonetasksScreen(),
    ArchivetasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDB() {
    openDatabase(
      'todoo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT)',
        )
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("Error when creating table ${error.toString()}");
        });
      },
      onOpen: (database) {
        getFromDB(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertIntoDB({
    required title,
    required date,
    required time,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
        "INSERT INTO tasks (title,date,time,status) VALUES ('$title','$date','$time','New')",
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertIntoDatabaseState());
        getFromDB(database);
      }).catchError((Error) {
        print('Error while inserting new record : $Error');
      });
    });
  }

  void getFromDB(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'Done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetFromDatabaseState());
    });
  }

  updateDB({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', '$id'],
    ).then((value) {
      getFromDB(database);
      emit(AppUpdateDatabaseState());
    });
  }

  deleteDB({
    required int id,
  }) {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      ['$id'],
    ).then((value) {
      getFromDB(database);
      emit(AppDeleteFromDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeState()));
    }
  }
}
