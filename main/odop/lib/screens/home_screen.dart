import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:odop/widgets/banner_widget.dart';
import 'package:odop/widgets/brand_highlights.dart';
import 'package:odop/widgets/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Shopping Area',
            style: TextStyle(letterSpacing: 2),
          ),
          actions: [
            IconButton(
              icon: const Icon(IconlyLight.buy),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        children: const [
          SearchWidget(),
          SizedBox(
            height: 10,
          ),
          BannerWidget(),
          BrandHighlights(),
          CategoryWidget(),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                  hintText: 'Search..',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    IconlyLight.infoSquare,
                    size: 12,
                    color: Colors.black,
                  ),
                  Text(
                    '100% Genuine',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    IconlyLight.infoSquare,
                    size: 12,
                    color: Colors.black,
                  ),
                  Text(
                    'Hand Crafted',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    IconlyLight.infoSquare,
                    size: 12,
                    color: Colors.black,
                  ),
                  Text(
                    'Eco-Friendly',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
