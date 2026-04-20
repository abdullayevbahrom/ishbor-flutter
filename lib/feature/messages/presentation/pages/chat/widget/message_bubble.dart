import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_cached_network_image.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';

import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../models/message_record.dart';
import '../../../../../../models/vacancy.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.currentUserId,
    this.fieldKey,
    required this.isCurrentUser,
    required this.enableFirstMessage,
    this.service,
    this.task,
    this.vacancy,
  });

  final MessageRecord? message;
  final int currentUserId;
  final GlobalKey? fieldKey;
  final bool isCurrentUser;
  final bool enableFirstMessage;
  final ServiceModel? service;
  final TaskModel? task;
  final Vacancy? vacancy;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool needToDownload = false;
  bool isDownloading = false;
  double _downLoadLength = 0;

  Future<File> get _sysFile async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File(
      '$dir/${widget.message?.file!.originalName}.${widget.message?.file!.extension}',
    );
  }

  Future<void> _checkFile() async {
    File file = await _sysFile;
    bool need = !(await file.exists());

    setState(() {
      needToDownload = need;
    });
  }

  Widget _getIcon() {
    if (isDownloading) {
      return SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          value: _downLoadLength,
          strokeWidth: 1,
        ),
      );
    }

    if (needToDownload) {
      return Icon(
        Icons.file_download,
        color: widget.isCurrentUser ? AppColors.cFFFFFF : AppColors.c000000,
      );
    }

    return Icon(
      Icons.insert_drive_file,
      color: widget.isCurrentUser ? AppColors.cFFFFFF : AppColors.c000000,
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        widget.vacancy?.images?.isNotEmpty == true
            ? widget.vacancy?.images?.first.urls['original']
            : widget.task?.images.isNotEmpty == true
            ? widget.task?.images.first.urls['original']
            : widget.service?.images?.isNotEmpty == true
            ? widget.service?.images?.first.urls['original']
            : null;

    final price =
        widget.vacancy?.salaryMin ??
        widget.service?.price ??
        widget.task?.price ??
        null;
    return Column(
      crossAxisAlignment:
          widget.isCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        if (widget.enableFirstMessage)
          if (widget.vacancy != null ||
              widget.service != null ||
              widget.task != null)
            InkWell(
              onTap: () {
                if (widget.vacancy != null) {
                  context.push("/vacancy-view?id=${widget.vacancy?.id}");
                } else if (widget.service != null) {
                  context.push("/service-view?id=${widget.service?.id}");
                } else if (widget.task != null) {
                  context.push("/task-view?id=${widget.task?.id}");
                }
              },
              borderRadius: BorderRadius.circular(18.r),
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.c000000.newWithOpacity(.05),
                      offset: const Offset(20, 0),
                      blurRadius: 20.r,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (imageUrl != null)
                      AppCachedNetworkImage(
                        height: 87.h,
                        radius: 12.r,
                        imageUrl: imageUrl,
                      ),

                    Expanded(
                      child: Column(
                        spacing: 2.h,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vacancy?.title ?? widget.service?.title ?? widget.task?.title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.size17Bold.copyWith(
                              color: AppColors.c2E3A59,
                            ),
                          ),
                          Text(
                            price != null ? "${Formatters.moneyFormat(price.toInt().toString())} ${price > 50000 ? "UZS" : "USD"}" : LocaleKeys.salaryIsNegotiable.tr(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.size16Medium.copyWith(
                              color: AppColors.cFF9914,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 8.w),
                    ),
                  ],
                ).paddingAll(8.r),
              ),
            ).paddingOnly(bottom: 8.h),
        DecoratedBox(
          key: widget.fieldKey,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: widget.isCurrentUser ? AppColors.cFF9914 : AppColors.cEBEEF3,
          ),
          child: Column(
            children: [
              widget.message?.file != null
                  ? InkWell(
                    onTap: () async {
                      await _checkFile();

                      if (needToDownload) {
                        Response response = await Dio().get(
                          widget.message!.file!.url,
                          onReceiveProgress: (received, total) {
                            if (total != -1) {
                              setState(() {
                                isDownloading = true;
                                _downLoadLength = (received / total);
                              });
                            }
                          },
                          options: Options(
                            responseType: ResponseType.bytes,
                            followRedirects: false,
                            receiveTimeout: Duration(seconds: 20),
                          ),
                        );

                        File file = await _sysFile;
                        var raf = file.openSync(mode: FileMode.write);
                        raf.writeFromSync(response.data);
                        await raf.close();

                        setState(() {
                          needToDownload = false;
                          isDownloading = false;
                        });
                      } else {
                        File file = await _sysFile;
                        OpenFile.open(file.path);
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _getIcon(),
                        Text(
                          (widget.message?.file!.originalName.length ?? 0) > 19
                              ? '${widget.message?.file?.originalName.substring(0, 19)}.${widget.message?.file?.extension}'
                              : '${widget.message?.file?.originalName}.${widget.message?.file?.extension}',
                          softWrap: true,
                          textAlign:
                              widget.isCurrentUser
                                  ? TextAlign.right
                                  : TextAlign.left,
                          style: AppTextStyles.size15Medium.copyWith(
                            color:
                                widget.isCurrentUser
                                    ? AppColors.cFFFFFF
                                    : AppColors.c000000,
                          ),
                        ).paddingOnly(left: 5.w),
                      ],
                    ),
                  )
                  : Text(
                    widget.message?.body ?? '',
                    style: AppTextStyles.size15Medium.copyWith(
                      color:
                          widget.isCurrentUser
                              ? AppColors.cFFFFFF
                              : AppColors.c000000,
                    ),
                  ),
            ],
          ).paddingSymmetric(horizontal: 12.w,vertical: 8.h),
        ),
        Align(
          alignment:
              widget.isCurrentUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
          child: Text(
            Formatters.formatChatDate(
              widget.message?.createdAt ?? DateTime.now(),
            ),
            style: AppTextStyles.size13Regular.copyWith(
              color: AppColors.c888888,
            ),
          ),
        ).paddingOnly(top: 4.h),
      ],
    ).paddingOnly(
      right: widget.isCurrentUser ? 0 : 100.w,
      left: widget.isCurrentUser ? 100.w : 0,
    );
  }
}
