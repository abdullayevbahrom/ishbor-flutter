import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/create_action_form.dart';

import '../../../../../../core/router/route_names.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../../export.dart';

class WAnimatedMenuContainer extends StatelessWidget {
  const WAnimatedMenuContainer({super.key, required this.open});

  final bool open;
  static const _dur = Duration(milliseconds: 300);
  static const _curve = Curves.easeIn;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 50,
      bottom: 53,
      child: AnimatedMenuContainer(
        open: open,
        duration: _dur,
        curve: _curve,
        child: SizedBox(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cFEFEFE,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.newWithOpacity(.05),
                  blurRadius: 40.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Wrap(
              direction: Axis.vertical,
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreateActionForm(
                  index: 1,
                  title: LocaleKeys.createVacancy.tr(),
                  imageUrl: AppSvg.icVacancy,
                  onTap: () {
                    context.push(Routes.wGenerateVacancy);

                    //context.push(Routes.createVacancy);
                  },
                ),
                CreateActionForm(
                  index: 2,
                  title: LocaleKeys.createService.tr(),
                  imageUrl: AppSvg.icService,
                  onTap: () {
                    context.push(Routes.createService);
                  },
                ),
                CreateActionForm(
                  index: 3,
                  title: LocaleKeys.createTask.tr(),
                  imageUrl: AppSvg.icTask,
                  onTap: () {
                    context.push(Routes.createTask);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedMenuContainer extends StatelessWidget {
  final bool open;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const AnimatedMenuContainer({
    required this.open,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Matrix4 closed =
        Matrix4.identity()
          ..translate(0.0, 0.0)
          ..scale(0.01);
    final Matrix4 opened = Matrix4.identity();

    return TweenAnimationBuilder<Matrix4>(
      tween: Matrix4Tween(begin: closed, end: open ? opened : closed),
      duration: duration,
      curve: curve,
      builder: (context, matrix, _) {
        return AnimatedOpacity(
          duration: duration,
          curve: curve,
          opacity: open ? 1 : .5,
          child: Padding(
            padding: EdgeInsets.only(bottom: 0, right: 5),
            child: IgnorePointer(
              ignoring: !open,
              child: Transform(
                alignment: Alignment.bottomRight,
                transform: matrix,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
