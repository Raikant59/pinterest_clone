import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/widgets/google_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/state/providers.dart';
import '../utils/app_responsive.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? email;

  const LoginScreen({super.key, this.email});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController =
  TextEditingController(text: widget.email ?? '');
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  static const Color screenBackground = Color(0xFFF6F6F6);
  static const Color pinterestRed = Color(0xFFE60023);
  static const Color borderColor = Color(0xFFA7A7A7);
  static const Color dividerColor = Color(0xFFDDDDDD);
  static const Color hintColor = Color(0xFF757575);
  static const Color forgottenColor = Color(0xFF616161);

  Future<void> _handleLogin() async {
    final success = await ref.read(authControllerProvider.notifier).signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (!success) {
      final error = ref.read(authControllerProvider).errorMessage ??
          'Login failed. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(
      BuildContext context, {
        required String hintText,
        Widget? suffixIcon,
        bool showAsValue = false,
      }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: showAsValue ? Colors.black : hintColor,
        fontSize: AppResponsive.sp(context, 16).clamp(14.0, 17.0),
        fontWeight: FontWeight.w400,
        letterSpacing: -0.2,
      ),
      isDense: true,
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppResponsive.w(context, 18).clamp(14.0, 20.0),
        vertical: AppResponsive.h(context, 17).clamp(14.0, 18.0),
      ),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppResponsive.r(context, 22).clamp(18.0, 24.0),
        ),
        borderSide: BorderSide(
          color: borderColor,
          width: AppResponsive.r(context, 1.3).clamp(1.0, 1.4),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppResponsive.r(context, 22).clamp(18.0, 24.0),
        ),
        borderSide: BorderSide(
          color: borderColor,
          width: AppResponsive.r(context, 1.4).clamp(1.1, 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    final double headerHorizontal =
    AppResponsive.w(context, 16).clamp(12.0, 18.0);
    final double formHorizontal =
    AppResponsive.w(context, 30).clamp(22.0, 34.0);

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
                    children: [
                      SizedBox(
                        height: AppResponsive.h(context, 14).clamp(10.0, 16.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: headerHorizontal),
                        child: SizedBox(
                          height: AppResponsive.h(context, 46).clamp(42.0, 50.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: AppResponsive.r(context, 40)
                                      .clamp(36.0, 42.0),
                                  height: AppResponsive.r(context, 40)
                                      .clamp(36.0, 42.0),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    splashRadius: AppResponsive.r(context, 20)
                                        .clamp(18.0, 22.0),
                                    onPressed: () => context.pop(),
                                    icon: Icon(
                                      Icons.close,
                                      size: AppResponsive.r(context, 30)
                                          .clamp(26.0, 32.0),
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: AppResponsive.sp(context, 22)
                                      .clamp(19.0, 24.0),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppResponsive.h(context, 18).clamp(14.0, 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: headerHorizontal),
                        child: const Divider(
                          height: 1,
                          thickness: 1,
                          color: dividerColor,
                        ),
                      ),
                      SizedBox(
                        height: AppResponsive.h(context, 18).clamp(14.0, 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: formHorizontal),
                        child: SizedBox(
                          width: double.infinity,
                          height: AppResponsive.h(context, 52).clamp(48.0, 56.0),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.transparent,
                              side: BorderSide(
                                color: borderColor,
                                width: AppResponsive.r(context, 1.3)
                                    .clamp(1.0, 1.4),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppResponsive.r(context, 22).clamp(18.0, 24.0),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppResponsive.w(context, 28)
                                    .clamp(18.0, 30.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const GoogleIcon(),
                                SizedBox(
                                  width: AppResponsive.w(context, 18)
                                      .clamp(12.0, 20.0),
                                ),
                                Flexible(
                                  child: Text(
                                    'Continue with Google',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: AppResponsive.sp(context, 18)
                                          .clamp(15.0, 19.0),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppResponsive.h(context, 20).clamp(14.0, 22.0),
                      ),
                      Text(
                        'Or',
                        style: TextStyle(
                          fontSize: AppResponsive.sp(context, 22)
                              .clamp(18.0, 24.0),
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(
                        height: AppResponsive.h(context, 20).clamp(14.0, 22.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: formHorizontal),
                        child: SizedBox(
                          height: AppResponsive.h(context, 54).clamp(48.0, 58.0),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: AppResponsive.sp(context, 16.5)
                                  .clamp(14.0, 17.5),
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              letterSpacing: -0.2,
                            ),
                            decoration: _inputDecoration(
                              context,
                              hintText: 'Enter your email',
                              showAsValue: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppResponsive.h(context, 16).clamp(12.0, 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: formHorizontal),
                        child: SizedBox(
                          height: AppResponsive.h(context, 54).clamp(48.0, 58.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(
                              fontSize: AppResponsive.sp(context, 16.5)
                                  .clamp(14.0, 17.5),
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              letterSpacing: -0.2,
                            ),
                            decoration: _inputDecoration(
                              context,
                              hintText: 'Enter your password',
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(
                                  right: AppResponsive.w(context, 12)
                                      .clamp(8.0, 14.0),
                                ),
                                child: IconButton(
                                  splashRadius: AppResponsive.r(context, 20)
                                      .clamp(18.0, 22.0),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: AppResponsive.r(context, 30)
                                        .clamp(24.0, 32.0),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppResponsive.h(context, 20).clamp(14.0, 22.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: formHorizontal),
                        child: SizedBox(
                          width: double.infinity,
                          height: AppResponsive.h(context, 52).clamp(48.0, 56.0),
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: pinterestRed,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppResponsive.r(context, 20).clamp(18.0, 22.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: AppResponsive.sp(context, 18)
                                    .clamp(15.0, 19.0),
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppResponsive.h(context, 28).clamp(20.0, 30.0),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: forgottenColor,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgotten password?',
                          style: TextStyle(
                            fontSize: AppResponsive.sp(context, 18)
                                .clamp(15.0, 19.0),
                            fontWeight: FontWeight.w700,
                            color: forgottenColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (keyboardInset == 0) ...[
                        Container(
                          width: AppResponsive.w(context, 122).clamp(96.0, 126.0),
                          height: AppResponsive.h(context, 5).clamp(4.0, 5.5),
                          margin: EdgeInsets.only(
                            bottom: AppResponsive.h(context, 10)
                                .clamp(8.0, 12.0),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6A6A6A),
                            borderRadius: BorderRadius.circular(
                              AppResponsive.r(context, 30).clamp(20.0, 30.0),
                            ),
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          height: AppResponsive.h(context, 18).clamp(14.0, 20.0),
                        ),
                      ],
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