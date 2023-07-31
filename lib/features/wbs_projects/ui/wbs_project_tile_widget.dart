

import 'package:flutter/material.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/models/new_project_wbs.dart';

DataRow productNewProjectFileDataRow({required WbsNewProjectDataModel productDataModel,}) {
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(productDataModel.timestamp);
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            // SvgPicture.asset(
            //   "assets/icons/xd_file.svg",
            //   height: 30,
            //   width: 30,
            // ),
            CircleAvatar(
              backgroundColor: secondaryColor,
              child: Text(productDataModel.projectid.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productDataModel.project_name.substring(0,productDataModel.project_name.length>25
                  ?25:productDataModel.project_name.length)),
            ),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    ],
  );
}