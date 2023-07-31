import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wbsessential/models/new_project_wbs.dart';
import 'package:wbsessential/models/project_items_wbs.dart';
import 'package:wbsessential/models/sub_sub_wbs.dart';
import 'package:wbsessential/models/sub_wbs.dart';
import 'package:wbsessential/models/wbs_main.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {

  // Google App Script Web URL.
  // static const String URL = "http://127.0.0.1:8000";
  static const String URL = "http://wbs-env.eba-fj9we2jw.us-west-2.elasticbeanstalk.com";
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.

  Future<bool> addNewProjects({required WbsNewProjectDataModel product}) async {
    var url = "$URL/api/restapi/projects/";
    var client = http.Client();
    try{
      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: convert.jsonEncode(product));
      if (response.statusCode == 302) {
        print(response);
        var url = response.headers["location"];
        response = await http.get(Uri.parse(url!));
        (print(convert.jsonDecode(response.body)["status"] + "addProduct1"));

      } else {
        (print(convert.jsonDecode(response.body)["status"]+"addProduct2"));
      }

      if(convert.jsonDecode(response.body)["status"]=="SUCCESS"){
        return true;
      }
      // print(results);
    } catch(e) {
      print(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> addNewWProjects({required WbsNewProjectWDataModel product}) async {
    var url = "$URL/project/create/";
    var client = http.Client();
    try{
      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: convert.jsonEncode(product));
      if (response.statusCode == 302) {
        print(response);
        var url = response.headers["location"];
        response = await http.get(Uri.parse(url!));
        (print(convert.jsonDecode(response.body)["status"] + "addProduct1"));

      } else {
        (print(convert.jsonDecode(response.body)["status"]+"addProduct2"));
      }

      if(convert.jsonDecode(response.body)["status"]=="SUCCESS"){
        return true;
      }
      // print(results);
    } catch(e) {
      print(e.toString());
      return false;
    }
    return false;
  }


  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<WbsMainDataModel>> getWbsList(String? myitemname) async {
    var url = "$URL/api/restapi/";
    // if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      final jsonbody = response.body;
      final jsonFeedback = jsonDecode(jsonbody);
      // print(jsonFeedback);
      final results = jsonFeedback as List;
      // print(results);
      return results.map((json) => WbsMainDataModel.fromJson(json)).toList();
    });
  }

  Future<List<WbsSubDataModel>> getSubWbsList(String? myitemname) async {
    var url = "$URL/api/restapi/sub/";
    // if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      final jsonbody = response.body;
      final jsonFeedback = jsonDecode(jsonbody);
      // print(jsonFeedback);
      final results = jsonFeedback as List;
      // print(results);
      return results.map((json) => WbsSubDataModel.fromJson(json)).toList();
    });
  }

  Future<List<WbsSubSubDataModel>> getSubSubWbsList(String? myitemname) async {
    var url = "$URL/api/restapi/ssub/";
    // if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      return postFromJson(response.body);
      
    });
  }

  Future<List<WbsNewProjectDataModel>> getProjectWbsList(String? myitemname) async {
    var url = "$URL/api/restapi/projects/";
    // if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      return projectFromJson(response.body);

    });
  }

  Future<List<WbsNewProjectDataModel>> getProjectWList(String? myitemname) async {
    var url = "$URL/project/";
    // if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      // print(response);
      return projectFromJson(response.body);

    });
  }

  Future<List<WbsViewProjectItemDataModel>> getProjectViewWList(num pid) async {
    var url = "$URL/project/$pid/order-items";
    // if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      // print(response);
      return projectItemViewFromJson(response.body);
    });
  }

}