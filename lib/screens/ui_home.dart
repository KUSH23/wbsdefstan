import 'package:flutter/material.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/controller/new_wbs_data.dart';
import 'package:wbsessential/features/plan_new_wbs/bloc/plan_new_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/bloc/plan_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/ui/ui_plan_home.dart';
import 'package:wbsessential/features/plan_wbs/ui/ui_plan_wbs.dart';
import 'package:wbsessential/controller/responsive.dart';
import 'package:wbsessential/features/wbs_projects/ui/ui_wbs_project.dart';
import 'package:wbsessential/screens/components/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectidController = TextEditingController();
  final TextEditingController _projectiNameController = TextEditingController();
  final PlanNewWbsBloc planNewWbsBloc = PlanNewWbsBloc();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed.
      newProjectId = _projectidController.text;
      newProjectName = _projectiNameController.text;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const PlanWBSHomeScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    planNewWbsBloc.add(WbsNewInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Text(
              "WBS List",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Form(
                key: _formKey,
                child:
                Padding(padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _projectidController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Valid Project Id';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Project ID'
                        ),
                      ),
                      TextFormField(
                        controller: _projectiNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Valid Project Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Project Name'
                        ),
                      ),
                    ],
                  ),
                )
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                _submitForm();
              },
              icon: const Icon(Icons.add),
              label: const Text("Create New"),
            ),
          ],
        ),
      ),
    );
  }
}
