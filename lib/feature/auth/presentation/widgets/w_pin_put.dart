import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../../../core/helpers/validators.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

final defaultPinTheme = PinTheme(
  width: 56.h,
  height: 56.h,
  textStyle: AppTextStyles.size20Medium.copyWith(color: AppColors.c333333),
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.cE0E5EB),
    borderRadius: BorderRadius.circular(12.r),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: AppColors.cFF9914),
  borderRadius: BorderRadius.circular(12.r),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: Color.fromRGBO(234, 239, 243, 1),
  ),
);

class WPinput extends StatefulWidget {
  const WPinput({
    super.key,
    required this.codeController,
    required this.onSendRequest,
    required this.length,
  });

  final TextEditingController codeController;
  final VoidCallback onSendRequest;
  final int length;

  @override
  State<WPinput> createState() => _WPinputState();
}

class _WPinputState extends State<WPinput> {
  late final SmsRetrieverImpl smsRetrieverImpl;

  @override
  void initState() {
    smsRetrieverImpl = SmsRetrieverImpl(SmartAuth.instance);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      enabled: true,
      autofocus: true,
      length: widget.length,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      mainAxisAlignment: MainAxisAlignment.center,
      controller: widget.codeController,
      keyboardType: TextInputType.number,
      autofillHints: [AutofillHints.oneTimeCode],
      smsRetriever: smsRetrieverImpl,
      closeKeyboardWhenCompleted: true,
      keyboardAppearance: Brightness.light,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      errorTextStyle: AppTextStyles.size15Medium.copyWith(
        color: AppColors.cRed,
      ),
      onChanged: (value) {
        if (value.length == widget.length) {
          widget.onSendRequest();
        }
      },
      validator: (s) {
        return ValidatorHelpers.validateField(value: s!);
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
    );
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeUserConsentApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsWithUserConsentApi(
      senderPhoneNumber: "4546",
    );
    if (res.hasData && !res.hasError) {
      return res.data!.code;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
