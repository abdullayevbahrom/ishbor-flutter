import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';

import '../../../../../core/theme/app_svg.dart';

class WAdsHeaderAction extends StatelessWidget {
  const WAdsHeaderAction({
    super.key,
    required this.onPressedReply,
    required this.onPressedFavorite,
    required this.isFavorite,
  });

  final VoidCallback onPressedReply;
  final VoidCallback onPressedFavorite;
  final bool isFavorite;

  bool get userLogged =>
      navigatorKey.currentContext?.read<UserCubit>().state.status.isLoaded() ??
      false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // IconButton(
        //   onPressed: onPressedReply,
        //   icon: SvgPicture.asset(AppSvg.icReply),
        // ),
        if (userLogged)
          IconButton(
            padding: EdgeInsets.zero,

            onPressed: onPressedFavorite,
            icon: SvgPicture.asset(
              isFavorite ? AppSvg.icHeartFilled : AppSvg.icHeart,
            ),
          ),

        // LikeButton(
        //   onTap: (isLiked) async {
        //     onPressedFavorite();
        //   },
        //   size: 30,
        //   bubblesSize: 80,
        //
        //   isLiked: isFavorite,
        //   likeBuilder: (isLiked) {
        //     return SizedBox(
        //       child: SvgPicture.asset(
        //         isLiked ? AppSvg.icHeartFilled : AppSvg.icHeart,
        //       ),
        //     );
        //   },
        // ),
        20.horizontalSpace,
      ],
    );
  }
}
