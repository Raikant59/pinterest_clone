import 'package:flutter/material.dart';
import 'package:pinterest_clone/screens/SignUp%20Screens/widgets/progress_dots.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes.dart';
import '../../features/auth/state/providers.dart';
import '../../utils/app_responsive.dart';

class CreatePasswordScreen extends ConsumerStatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  ConsumerState<CreatePasswordScreen> createState() =>
      _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  static const Color screenBackground = Color(0xFFF6F6F6);
  static const Color borderColor = Color(0xFF3D3D34);
  static const Color hintColor = Color(0xFF767676);
  static const Color pinterestRed = Color(0xFFE60023);
  static const Color disabledButton = Color(0xFFD9D9D3);
  static const Color disabledText = Color(0xFF9A9A95);
  static const Color weakRed = Color(0xFFE60023);
  static const Color strongGreen = Color(0xFF0A8F45);

  bool get _hasPassword => _passwordController.text.isNotEmpty;

  String get _password => _passwordController.text.trim();

  bool get _hasMinLength => _password.length >= 8;
  bool get _hasLetter => RegExp(r'[A-Za-z]').hasMatch(_password);
  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_password);
  bool get _hasSymbol =>
      RegExp(r'[!@#\$%^&*(),.?":{}|<>\[\]\\\/_\-+=~`]').hasMatch(_password);

  bool get _isValidPassword =>
      _hasMinLength && _hasLetter && _hasNumber && _hasSymbol;

  int get _criteriaCount {
    int count = 0;
    if (_hasMinLength) count++;
    if (_hasLetter) count++;
    if (_hasNumber) count++;
    if (_hasSymbol) count++;
    return count;
  }

  double get _progressValue {
    if (!_hasPassword) return 0.0;

    if (_isValidPassword) return 1.0;

    if (_criteriaCount <= 1) return 0.30;
    if (_criteriaCount == 2) return 0.55;
    if (_criteriaCount == 3) return 0.78;

    return 0.30;
  }

  Color get _progressColor {
    if (!_hasPassword) return Colors.transparent;
    if (_isValidPassword) return strongGreen;
    return weakRed;
  }

  String get _statusText {
    if (!_hasPassword) return '';
    if (_isValidPassword) return 'Perfection!';
    if (_criteriaCount >= 3) return 'Looks good';
    return 'Make it more complicated';
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _passwordDecoration(BuildContext context) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: _hasPassword ? null : 'Create a strong password',
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

  void _handleNext() {
    if (!_isValidPassword) return;

    ref.read(signupDraftProvider.notifier).setPassword(
      _passwordController.text.trim(),
    );

    context.push(AppRoutes.createName);
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double sidePadding =
    AppResponsive.w(context, 18).clamp(14.0, 22.0);
    final double topGap =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double titleGap =
    AppResponsive.h(context, 4).clamp(2.0, 6.0);
    final double fieldGap =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);
    final double progressGap =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double statusGap =
    AppResponsive.h(context, 14).clamp(10.0, 16.0);
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
                        padding: EdgeInsets.symmetric(
                          horizontal:
                          AppResponsive.w(context, 10).clamp(8.0, 14.0),
                        ),
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
                                  filledCount: 1,
                                  outlinedIndex: 1,
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
                          'Create a password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:
                            AppResponsive.sp(context, 20).clamp(18.0, 22.0),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -0.6,
                          ),
                        ),
                      ),
                      SizedBox(height: fieldGap),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: sidePadding),
                        child: Container(
                          height: AppResponsive.h(context, 68).clamp(60.0, 72.0),
                          padding: EdgeInsets.fromLTRB(
                            AppResponsive.w(context, 14).clamp(12.0, 16.0),
                            AppResponsive.h(context, 6).clamp(4.0, 8.0),
                            AppResponsive.w(context, 12).clamp(10.0, 14.0),
                            AppResponsive.h(context, 2).clamp(1.0, 4.0),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: AppResponsive.sp(context, 13)
                                      .clamp(11.5, 13.5),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  letterSpacing: 0,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      style: TextStyle(
                                        fontSize: AppResponsive.sp(context, 12)
                                            .clamp(11.0, 13.0),
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        letterSpacing: -0.2,
                                      ),
                                      decoration: _passwordDecoration(context),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppResponsive.w(context, 8)
                                        .clamp(6.0, 10.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
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
                                        _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: AppResponsive.r(context, 24)
                                            .clamp(20.0, 26.0),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: progressGap),
                      if (_hasPassword)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                            AppResponsive.w(context, 26).clamp(18.0, 30.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              height: AppResponsive.h(context, 10)
                                  .clamp(8.0, 11.0),
                              color: const Color(0xFFE3E3DE),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 260),
                                  curve: Curves.easeOut,
                                  width: screenWidth * 0.72 * _progressValue,
                                  decoration: BoxDecoration(
                                    color: _progressColor,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: statusGap),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                          AppResponsive.w(context, 30).clamp(22.0, 34.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_hasPassword)
                              Text(
                                _statusText,
                                style: TextStyle(
                                  fontSize: AppResponsive.sp(context, 15)
                                      .clamp(13.0, 16.0),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF5F5F5A),
                                ),
                              ),
                            if (_hasPassword)
                              SizedBox(
                                height: AppResponsive.h(context, 4)
                                    .clamp(2.0, 6.0),
                              ),
                            Text(
                              'Use 8 or more letters, numbers and symbols',
                              style: TextStyle(
                                fontSize: AppResponsive.sp(context, 13)
                                    .clamp(11.5, 13.5),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6D6D68),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: sidePadding),
                        child: SizedBox(
                          width: double.infinity,
                          height: AppResponsive.h(context, 54).clamp(48.0, 58.0),
                          child: ElevatedButton(
                            onPressed: _isValidPassword ? _handleNext : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                              _isValidPassword ? pinterestRed : disabledButton,
                              foregroundColor:
                              _isValidPassword ? Colors.white : disabledText,
                              disabledBackgroundColor: disabledButton,
                              disabledForegroundColor: disabledText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppResponsive.r(context, 24).clamp(20.0, 26.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Next',
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