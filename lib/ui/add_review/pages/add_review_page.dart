import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/add_review/cubits/add_review_cubit.dart';
import 'package:efk_academy/ui/course_detail/cubits/get_review_cubit/get_review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReviewPage extends StatelessWidget {
  const AddReviewPage({
    super.key,
    required this.courseId,
    required this.getReviewCubit,
  });

  final String courseId;
  final GetReviewCubit getReviewCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddReviewCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<AddReviewCubit, AddReviewState>(
          listener: (context, state) {
            if (state.status == AddReviewStatus.failure) {
              AppToast.error(state.errorMessage);
            }
            if (state.status == AddReviewStatus.success) {
              AppToast.success('មិតិត្រូវបានបញ្ចេញបានជោគជ័យ!');
              getReviewCubit.getReviews(courseId);
              Navigator.of(context).pop();
            }
          },
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              children: [
                AddReviewInputField(),
                const SizedBox(height: 12.0),
                AddReviewButton(courseId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddReviewInputField extends StatelessWidget {
  const AddReviewInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          context.read<AddReviewCubit>().messageChanged(value),
      maxLength: 100,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'មិតិរបស់អ្នក...',
        labelText: 'មិតិយោបល់',
      ),
    );
  }
}

class AddReviewButton extends StatelessWidget {
  const AddReviewButton(
    this.courseId, {
    super.key,
  });

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final enabled =
        context.select((AddReviewCubit cubit) => cubit.state.message != '');
    final inProgress = context.select((AddReviewCubit cubit) =>
        cubit.state.status == AddReviewStatus.inProgress);
    return CustomButton(
      enabled: enabled,
      text: 'យល់ព្រម',
      inProgress: inProgress,
      onTap: () {
        context.read<AddReviewCubit>().addReview(courseId);
      },
    );
  }
}
