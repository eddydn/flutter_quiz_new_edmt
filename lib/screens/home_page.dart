import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_new_edmt/database/category_helper.dart';
import 'package:flutter_quiz_new_edmt/model/category.dart';
import 'package:flutter_quiz_new_edmt/state/state_management.dart';

import '../database/db_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: FutureBuilder<List<Category>>(
          future: getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var category = Category();
              category.id = -1; // Test category will always -1
              category.name = "Exam";
              snapshot.data?.add(category);
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: snapshot.data!.map((Category category) {
                  return GestureDetector(
                    onTap: () {
                      questionCategoryState.value = category;
                      isTestMode.value = category.id == -1;
                      Navigator.pushNamed(context,
                          category.id != -1 ? "/readMode" : "/testMode");
                    },
                    child: Card(
                      color: category.id == -1 ? Colors.green : Colors.white,
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AutoSizeText(
                                category.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: category.id == -1
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<List<Category>> getCategories() async {
    var db = await copyDB();
    var result = await CategoryHelper().getCategories(db);
    //We need state to store it
    categoryListState.value = result;
    return result;
  }
}
