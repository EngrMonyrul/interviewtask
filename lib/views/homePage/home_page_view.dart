// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/models/database.dart';
import 'package:interviewtask/views/homePage/subViews/addTask/add_task_view.dart';
import 'package:interviewtask/views/homePage/subViews/taskView/view_task.dart';
import 'package:interviewtask/views/homePage/widgets/homepage_appbar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


class HomePageView extends StatefulWidget {
  final DatabaseHandler databaseHandler;

  const HomePageView({super.key, required this.databaseHandler});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  refreshData() {
    widget.databaseHandler.fetchTasks();
    setState(() {});
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homepageAppbar(
        title: 'Task View',
        needActionButton: false,
        iconData: CupertinoIcons.checkmark_alt_circle,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4c4f4d),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTaskView(databaseHandler: widget.databaseHandler)));
        },
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Icon(
                CupertinoIcons.plus,
                size: 30,
                color: Colors.white,
              ),
              Spacer(),
              Text(
                'Add Task',
                style: TextStyle(fontSize: 10, color: Colors.white),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<dynamic>(
            future: widget.databaseHandler.fetchTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingWidget();
              } else if (snapshot.hasError) {
                return errorWidget();
              } else {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TaskViewPage(task: snapshot.data[index], databaseHandler: widget.databaseHandler)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .13,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF6e706a),
                              Color(0xFFd5cd23),
                              Color(0xFF00ff73),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5, 5),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFF4c4f4d)),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(fontSize: 40),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 5, top: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * .5,
                                    child: Text(
                                      'ID: ${snapshot.data[index].id}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * .5,
                                    child: Text(
                                      'Title: ${snapshot.data[index].title}, \nStatus: ${(snapshot.data[index].status) == 0 ? 'Completed' : 'Backlog'}\nDescription: ${snapshot.data[index].description}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 15, fontStyle: FontStyle.italic, color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {},
                              itemBuilder: (context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddTaskView(
                                              databaseHandler: widget.databaseHandler,
                                              task: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Edit'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () async {
                                        await widget.databaseHandler.deleteTask(id: snapshot.data[index].id);
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'Delete File Successfully',
                                          onConfirmBtnTap: () {
                                            widget.databaseHandler.fetchTasks();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePageView(databaseHandler: widget.databaseHandler)));
                                          },
                                        );
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Center errorWidget() {
    return const Center(
      child: Text(
        'Empty Data\nPlease Add Data',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF4c4f4d),
          ),
          Text(
            'Data Loading',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
