import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elden_ring_app/features/detail/detail_content.dart';

import '../../shared/presentation/widgets/loading_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = ModalRoute.of(context)!.settings.arguments as DetailContent;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(content.title),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: content.aspectRatio,
              child: CachedNetworkImage(
                imageUrl: content.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => LoadingWidget(),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/camera.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Container(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      content.title,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(content.description),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
