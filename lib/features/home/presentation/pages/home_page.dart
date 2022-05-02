import 'dart:io';

import 'package:flutter/cupertino.dart' as IOS;
import 'package:flutter/material.dart' as Android;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/bloc/home_bosses_bloc.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/bloc/home_bosses_event.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/bloc/home_bosses_state.dart';
import 'package:flutter_elden_ring_app/features/home/presentation/widgets/widgets.dart';
import 'package:flutter_elden_ring_app/injection_container.dart';

class HomePage extends StatelessWidget {
  static const _PAGE_TITLE = 'Elden Ring - Bosses';

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return IOS.CupertinoPageScaffold(
        // Uncomment to change the background color
        navigationBar: const IOS.CupertinoNavigationBar(
          middle: Text(_PAGE_TITLE),
        ),
        child: buildBody(context),
      );
    } else {
      return Android.Scaffold(
        appBar: Android.AppBar(
          title: Text(_PAGE_TITLE),
        ),
        body: buildBody(context),
      );
    }
  }

  SafeArea buildBody(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => sl<HomeBossesBloc>(),
        child: BlocBuilder<HomeBossesBloc, HomeState>(
          builder: (context, state) {
            return currentStateWidget(context, state);
          },
        ),
      ),
    );
  }

  Widget currentStateWidget(BuildContext context, HomeState state) {
    if (state is Init) {
      BlocProvider.of<HomeBossesBloc>(context).add(GetBossesEvent());
      return Container();
    } else if (state is Empty) {
      return MessageDisplay(
        message: 'No result available!',
      );
    } else if (state is Loading) {
      return LoadingWidget();
    } else if (state is Loaded) {
      final bosses = state.bosses;
      return ListView.builder(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          shrinkWrap: true,
          physics: scrollPhysics(),
          itemCount: bosses.length,
          itemBuilder: (BuildContext context, int index) {
            return BossCard(bosses[index]);
          });
    } else if (state is Error) {
      return MessageDisplay(
        message: state.message,
      );
    } else {
      return Container();
    }
  }

  IOS.ScrollPhysics scrollPhysics() {
    return Platform.isIOS
        ? IOS.BouncingScrollPhysics()
        : Android.ClampingScrollPhysics();
  }
}
