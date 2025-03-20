import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/new.dart';
import 'package:efk_academy/common/cubits/get_new_cubit/get_new_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.close_outlined,
          ),
        ),
      ),
      body: BlocBuilder<GetNewCubit, GetNewState>(
        builder: (context, state) {
          if (state.status == GetNewStatus.inProgress) {
            return loading();
          }

          if (state.status == GetNewStatus.failure) {
            return failure(state.errorMessage);
          }

          if (state.status == GetNewStatus.success) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (_, index) {
                return Text(
                  state.news[index].name,
                  style: Theme.of(context).textTheme.labelMedium,
                );
              },
              separatorBuilder: (_, index) => const Divider(),
              itemCount: state.news.length,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget buildItem(New item) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.push(AppRoute.newDetail, arguments: item);
      },
      child: Text(
        item.name,
        style: labelStyle.copyWith(
          fontSize: 14.sp,
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
