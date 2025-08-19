import 'package:class_market/_test_code/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenTest extends StatelessWidget {
  const HomeScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('좌동'),
            const SizedBox(width: 4.0),
            Icon(CupertinoIcons.chevron_down),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.list_dash)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(
            thickness: 1,
            height: 1,
          ),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            indent: 16.0,
            endIndent: 16.0,
            thickness: 1,
            height: 0.5,
            color: Colors.black,
          );
        },
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Container(
            padding: EdgeInsets.all(16.0),
            height: 135,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    width: 115,
                    height: 115,
                    product.urlToImage,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextTheme().bodyLarge,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${product.address} * ${product.publishedAt}',
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${product.price} 원',
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: product.commentsCount > 0,
                            child: _buildIcons(
                              product.commentsCount,
                              CupertinoIcons.chat_bubble_2,
                            ),
                          ),
                          Visibility(
                            child: _buildIcons(
                              product.heartCount,
                              CupertinoIcons.heart,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcons(int count, IconData iconData) {
    return Row(
      children: [
        Icon(iconData, size: 14.0),
        const SizedBox(width: 4.0),
        Text('$count'),
      ],
    );
  }
}
