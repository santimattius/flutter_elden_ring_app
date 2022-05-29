import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_elden_ring_app/features/classes/domain/class_character.dart';
import 'package:flutter_elden_ring_app/features/classes/presentation/bloc/home_classes_bloc.dart';
import 'package:flutter_elden_ring_app/features/detail/detail_content.dart';
import 'package:flutter_elden_ring_app/injection_container.dart';
import 'package:flutter_elden_ring_app/shared/presentation/base_list_page.dart';
import 'package:flutter_elden_ring_app/shared/presentation/widgets/loading_widget.dart';
import 'package:flutter_elden_ring_app/shared/presentation/widgets/message_display.dart';

const double IMAGE_RATIO = 2 / 3;

class ClassesPage extends BaseListPage {
  ClassesPage() : super(currentPage: 'Classes');

  @override
  Widget body(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (_) => serviceLocator<HomeClassesBloc>(),
        child: BlocBuilder<HomeClassesBloc, HomeClassesState>(
          builder: (context, state) {
            return currentWidget(context, state);
          },
        ),
      ),
    );
  }

  Widget currentWidget(BuildContext context, HomeClassesState state) {
    if (state is Init) {
      BlocProvider.of<HomeClassesBloc>(context).add(GetCharactersEvent());
      return LoadingWidget();
    } else if (state is Empty) {
      return MessageDisplay(
        message: 'No result available!',
      );
    } else if (state is Loading) {
      return LoadingWidget();
    } else if (state is Error) {
      return MessageDisplay(
        message: state.message,
      );
    } else if (state is Loaded) {
      final characters = state.characters;
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: IMAGE_RATIO),
          itemCount: characters.length,
          itemBuilder: (BuildContext context, int index) {
            return characterCard(context, characters[index]);
          });
    } else {
      return Container();
    }
  }

  Padding characterCard(BuildContext context, Character character) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'detail',
              arguments: DetailContent(
                  title: character.name,
                  description: character.description,
                  image: character.image,
                  aspectRatio: IMAGE_RATIO));
        },
        child: Card(
          child: CachedNetworkImage(
            imageUrl: character.image,
            fit: BoxFit.cover,
            placeholder: (context, url) => LoadingWidget(),
            errorWidget: (context, url, error) => Image.asset(
              'assets/camera.png',
            ),
          ),
        ),
      ),
    );
  }

  @override
  String title() => 'Classes';
}
