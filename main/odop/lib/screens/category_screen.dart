import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:odop/category/main_category_widget.dart';
import 'package:odop/modles/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _title = 'Categories';
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? _title : selectedCategory!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        actions: [
          IconButton(
            icon: Icon(IconlyLight.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(IconlyLight.buy),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 80,
            color: Colors.grey.shade300,
            child: FirestoreListView<Category>(
              query: categoryCollection,
              itemBuilder: (context, snapshot) {
                Category category = snapshot.data();
                return InkWell(
                  onTap: () {
                    setState(() {
                      _title = category.catName!;
                      selectedCategory = category.catName;
                    });
                  },
                  child: Container(
                    height: 70,
                    color: selectedCategory == category.catName
                        ? Colors.white
                        : Colors.grey.shade300,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30,
                              child: CachedNetworkImage(
                                imageUrl: category.image!,
                                color: selectedCategory == category.catName
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              category.catName!,
                              style: TextStyle(
                                fontSize: 10,
                                color: selectedCategory == category.catName
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          MainCategoryWidget(
            selectedCat: selectedCategory,
          ),
        ],
      ),
    );
  }
}
