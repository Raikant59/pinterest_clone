import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/screens/SignUp Screens/widgets/progress_dots.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/features/auth/state/providers.dart';

import '../../utils/app_responsive.dart';

class CreateNameScreen extends ConsumerStatefulWidget {
  const CreateNameScreen({super.key});

  @override
  ConsumerState<CreateNameScreen> createState() => _CreateNameScreenState();
}

class _CreateNameScreenState extends ConsumerState<CreateNameScreen> {
  final TextEditingController _nameController = TextEditingController();

  static const Color screenBackground = Color(0xFFF6F6F6);
  static const Color borderColor = Color(0xFF3D3D34);
  static const Color hintColor = Color(0xFF767676);
  static const Color pinterestRed = Color(0xFFE60023);
  static const Color disabledButton = Color(0xFFD9D9D3);
  static const Color disabledText = Color(0xFF9A9A95);

  bool get _hasName => _nameController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    if (!_hasName) return;

    ref.read(signupDraftProvider.notifier).setFullName(
      _nameController.text.trim(),
    );

    final draft = ref.read(signupDraftProvider);

    final success = await ref.read(authControllerProvider.notifier).signUp(
      email: draft.email,
      password: draft.password,
      fullName: _nameController.text.trim(),
    );

    if (!mounted) return;

    if (!success) {
      final error = ref.read(authControllerProvider).errorMessage ??
          'Sign up failed. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  InputDecoration _nameDecoration(BuildContext context) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: 'Full name',
      hintStyle: TextStyle(
        color: hintColor,
        fontSize: AppResponsive.sp(context, 15).clamp(13.0, 16.0),
        fontWeight: FontWeight.w400,
        letterSpacing: -0.2,
      ),
      contentPadding: EdgeInsets.zero,
      isDense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    final double horizontalPadding =
    AppResponsive.w(context, 18).clamp(14.0, 22.0);
    final double topGap =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double titleGap =
    AppResponsive.h(context, 4).clamp(2.0, 6.0);
    final double fieldGap =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);
    final double buttonBottomGap =
    AppResponsive.h(context, 8).clamp(6.0, 10.0);

    return Scaffold(
      backgroundColor: screenBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(
                bottom: keyboardInset > 0
                    ? AppResponsive.h(context, 20).clamp(14.0, 24.0)
                    : 0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: topGap),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => context.pop(),
                              padding: EdgeInsets.zero,
                              splashRadius: AppResponsive.r(context, 20)
                                  .clamp(18.0, 22.0),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                size: AppResponsive.r(context, 24)
                                    .clamp(20.0, 26.0),
                                color: const Color(0xFF66665E),
                              ),
                            ),
                            const Expanded(
                              child: Center(
                                child: ProgressDots(
                                  filledCount: 2,
                                  outlinedIndex: 2,
                                  total: 3,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResponsive.w(context, 40)
                                  .clamp(32.0, 44.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: titleGap),
                      Center(
                        child: Text(
                          "What's your name?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:
                            AppResponsive.sp(context, 20).clamp(18.0, 22.0),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),
                      SizedBox(height: fieldGap),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Container(
                          height: AppResponsive.h(context, 60).clamp(54.0, 64.0),
                          padding: EdgeInsets.symmetric(
                            horizontal:
                            AppResponsive.w(context, 18).clamp(14.0, 20.0),
                            vertical:
                            AppResponsive.h(context, 12).clamp(10.0, 14.0),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppResponsive.r(context, 24).clamp(20.0, 26.0),
                            ),
                            border: Border.all(
                              color: borderColor,
                              width: AppResponsive.r(context, 2).clamp(1.5, 2.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    fontSize: AppResponsive.sp(context, 16)
                                        .clamp(14.0, 17.0),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    letterSpacing: -0.2,
                                  ),
                                  decoration: _nameDecoration(context),
                                ),
                              ),
                              if (_hasName)
                                InkWell(
                                  onTap: () {
                                    _nameController.clear();
                                  },
                                  borderRadius: BorderRadius.circular(
                                    AppResponsive.r(context, 30)
                                        .clamp(24.0, 32.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      AppResponsive.r(context, 6)
                                          .clamp(4.0, 7.0),
                                    ),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      size: AppResponsive.r(context, 26)
                                          .clamp(22.0, 28.0),
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: SizedBox(
                          width: double.infinity,
                          height: AppResponsive.h(context, 54).clamp(48.0, 58.0),
                          child: ElevatedButton(
                            onPressed: _hasName ? _handleNext : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                              _hasName ? pinterestRed : disabledButton,
                              foregroundColor:
                              _hasName ? Colors.white : disabledText,
                              disabledBackgroundColor: disabledButton,
                              disabledForegroundColor: disabledText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppResponsive.r(context, 24).clamp(20.0, 26.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: AppResponsive.sp(context, 16)
                                    .clamp(14.0, 17.0),
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: buttonBottomGap),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}