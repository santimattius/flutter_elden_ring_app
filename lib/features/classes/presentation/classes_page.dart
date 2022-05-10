import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elden_ring_app/shared/presentation/base_list_page.dart';

import '../../../shared/presentation/widgets/loading_widget.dart';

class ClassesPage extends BaseListPage {
  ClassesPage() : super(currentPage: 'Classes');

  @override
  Widget body(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Card(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://eldenring.fanapis.com/images/classes/17f69d71826l0i32gkm3ndn3kywxqj.png',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => LoadingWidget(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/camera.png',
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  String title() => 'Classes';
}
