import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/core/helpers/helpers.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/new/cubit/get_new_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetNewCubit>()..getNews(),
      child: Scaffold(
        appBar: appBar(context),
        body: BlocBuilder<GetNewCubit, GetNewState>(
          builder: (context, state) {
            switch (state) {
              case GetNewInProgress():
                return loading();
              case GetNewFailure():
                return failure(state.message);
              case GetNewSuccess():
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      NavigatorHelper.push(AppRoute.newDetail,
                          arguments: state.news[index]);
                    },
                    child: Text(
                      state.news[index].name,
                      style: labelStyle.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  separatorBuilder: (_, i) => const Divider(),
                  itemCount: state.news.length,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.close_outlined,
        ),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget failure(String message) {
    return Center(
      child: Text(
        message,
      ),
    );
  }
}
