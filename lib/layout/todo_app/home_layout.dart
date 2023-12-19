import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var form2Key = GlobalKey<FormState>();
  var taskController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.Screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (form2Key.currentState!.validate()) {
                    cubit.insertIntoDB(
                      title: taskController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                    // insertIntoDB(
                    //   title: taskController.text,
                    //   date: dateController.text,
                    //   time: timeController.text,
                    // ).then((value) {
                    //   getFromDB(database).then((value) {
                    //     Navigator.pop(context);
                    //   });
                    //   // isBottomSheetShown = false;
                    //   // setState(() {
                    //   //   fabIcon = Icons.edit;
                    //   // });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: form2Key,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: taskController,
                                  type: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Task cannot be empty';
                                    }
                                    return null;
                                  },
                                  label: "Task Tittle",
                                  prefix: Icons.task,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: timeController,
                                  label: "Task Time",
                                  prefix: Icons.watch_later_outlined,
                                  type: TextInputType.datetime,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Time cannot be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) => timeController.text =
                                        value!.format(context));
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: dateController,
                                  label: "Task Date",
                                  prefix: Icons.date_range_outlined,
                                  type: TextInputType.datetime,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Date cannot be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2023-08-30"),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Archive",
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is AppInsertIntoDatabaseState) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Future<String> getName() async {
    return 'Ahmed Ali';
  }
}
