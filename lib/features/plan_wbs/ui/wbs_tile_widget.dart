import 'package:flutter/material.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/features/plan_new_wbs/bloc/plan_new_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/bloc/plan_wbs_bloc.dart';
import 'package:wbsessential/models/sub_sub_wbs.dart';
import 'package:wbsessential/models/wbs_main.dart';

DataRow productFileDataRow({
  required WbsSubSubDataModel productDataModel,
  required PlanNewWbsBloc planNewWbsBloc,
  required PlanWbsBloc planWbsBloc}) {
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(productDataModel.timestamp);
  return DataRow(
    color: MaterialStateColor.resolveWith((states) {
      return productDataModel.id< 0 ? Colors.red : secondaryColor; //make tha magic!
    }),
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
              child: Text(productDataModel.id.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productDataModel.mssgroup_name),
            ),
          ],
        ),
      ),
      DataCell(
          Row(
            children: [
              IconButton(
                onPressed: (){
                    planNewWbsBloc.add(WbsNewAddButtonClickedEvent(wbsSubSubDataModel: productDataModel));
                    planWbsBloc.add(WbsAddButtonClickedEvent(wbsSubSubDataModel: productDataModel));
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
      ),
    ],
  );
}

DataRow productNewFileDataRow({required WbsSubSubDataModel productDataModel,}) {
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(productDataModel.timestamp);
  return DataRow(
    color: MaterialStateColor.resolveWith((states) {
      return productDataModel.id< 0 ? Colors.red : secondaryColor; //make tha magic!
    }),
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
              child: Text(productDataModel.id.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productDataModel.mssgroup_name.substring(0,productDataModel.mssgroup_name.length>25
                  ?25:productDataModel.mssgroup_name.length)),
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
