import 'package:flutter/material.dart';
import 'package:workout_planner/page_history.dart';
import 'api.dart';
import 'page_category.dart';

class CategoryPage extends StatefulWidget {
  final VoidCallback onSignOut;
  CategoryPage({@required this.onSignOut});
  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  final newCategoryTextFieldController = TextEditingController();

  void showCategoryNameExistedWarningDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Category Name Existed"),
          content: Text("Please use another name."),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showAddCategoryDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: newCategoryTextFieldController,
                decoration: InputDecoration(
                  hintText: "Category's Name...",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                newCategoryTextFieldController.text = "";
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('ADD'),
              onPressed: () async {
                setState(() {
                  if (Api.categoryNameExists(
                      newCategoryTextFieldController.text)) {
                    showCategoryNameExistedWarningDialog(context);
                    return;
                  }
                  Api.addCategory(newCategoryTextFieldController.text);
                  newCategoryTextFieldController.text = "";
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteCategoryDialog(
      BuildContext context, String deleteCategoryName) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete the Category"),
          content: Text("Are you sure to delete the Category?"),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('DELETE'),
              onPressed: () async {
                setState(() {
                  Api.deleteCategory(deleteCategoryName);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Api.categoryCount(),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(Api.categoryNameByIndex(index)),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPageStateful(
                                categoryName: Api.categoryNameByIndex(index))),
                      );
                    },
                    onLongPress: () {
                      showDeleteCategoryDialog(
                          context, Api.categoryNameByIndex(index));
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddCategoryDialog(context);
        },
        tooltip: 'New Category',
        child: Icon(Icons.add),
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  child: Text('Workout Planner',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
              ),
              ListTile(
                title: Text('History', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoryPageStateful()),
                  );
                },
              ),
              ListTile(
                title: Text('Sign Out', style: TextStyle(fontSize: 20)),
                onTap: () => widget.onSignOut(),
              ),
              ListTile(
                title: Text('More...', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
