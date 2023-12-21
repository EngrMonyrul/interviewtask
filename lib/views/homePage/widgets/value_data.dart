import 'package:flutter/material.dart';

Padding valueData(BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
  return Padding(
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
            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.black38),
          ),
        ),
      ],
    ),
  );
}
