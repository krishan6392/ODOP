import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app_admin/firebase_service.dart';
import 'package:shop_app_admin/widgets/catageories_list_widget.dart';
import 'package:shop_app_admin/widgets/main_categories_list_widgets.dart';

class MainCategoryScreen extends StatefulWidget {
  static const String id = 'main-category';
  const MainCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MainCategoryScreen> createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {
  final FirebaseService _service = FirebaseService();
  final TextEditingController _mainCat = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _noCategorySelected = false;
  Object? _selectedValue;
  QuerySnapshot? snapshot;
  Widget _dropDownButton() {
    return DropdownButton(
        hint: const Text('Select Categroy'),
        value: _selectedValue,
        items: snapshot!.docs.map((e) {
          return DropdownMenuItem(
            value: e['catName'],
            child: Text(e['catName']),
          );
        }).toList(),
        onChanged: (selectedCat) {
          setState(() {
            _selectedValue = selectedCat;
            _noCategorySelected = false;
          });
        });
  }

  clear() {
    setState(() {
      _selectedValue = null;
      _mainCat.clear();
    });
  }

  @override
  void initState() {
    getCatList();
    super.initState();
  }

  getCatList() {
    return _service.categories.get().then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Main Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            snapshot == null ? const Text('Loading..') : _dropDownButton(),
            SizedBox(
              height: 8,
            ),
            if (_noCategorySelected == true)
              Text(
                'No Category Selected',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(
              width: 200,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Category Name';
                  }
                },
                controller: _mainCat,
                decoration: const InputDecoration(
                  label: Text('Enter Category Name'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: clear,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                      BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedValue == null) {
                      setState(() {
                        _noCategorySelected = true;
                      });
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show();
                      _service.saveCategory(
                        data: {
                          'category': _selectedValue,
                          'mainCategory': _mainCat.text,
                          'approved': true,
                        },
                        reference: _service.mainCat,
                        docName: _mainCat.text,
                      ).then((value) {
                        clear();
                        EasyLoading.dismiss();
                      });
                    }
                  },
                  child: const Text(
                    '  Save  ',
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Main Category List',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const MainCategoryListWidget(),
          ],
        ),
      ),
    );
  }
}
