import 'package:flutter/material.dart';
import 'package:pinterest_clone/routes/routes.dart';
import 'package:pinterest_clone/widgets/google_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/state/providers.dart';
import '../utils/app_responsive.dart';

class EmailEntryScreen extends ConsumerStatefulWidget {
  const EmailEntryScreen({super.key});

  @override
  ConsumerState<EmailEntryScreen> createState() => _EmailEntryScreenState();
}

class _EmailEntryScreenState extends ConsumerState<EmailEntryScreen>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final AnimationController _entryController;
  late final AnimationController _breathController;

  late final Animation<Offset> _collageLeftAnimation;
  late final Animation<Offset> _collageRightAnimation;
  late final Animation<Offset> _logoAnimation;

  late final Animation<Offset> _titleLineOneAnimation;
  late final Animation<Offset> _titleLineTwoAnimation;

  late final Animation<double> _titleLineOneOpacity;
  late final Animation<double> _titleLineTwoOpacity;

  late final Animation<double> _collageScaleAnimation;

  bool _isChecking = false;

  static const Color pinterestRed = Color(0xFFE60023);
  static const Color screenBackground = Color(0xFFF4F4F4);
  static const Color borderColor = Color(0xFF4A4A4A);
  static const Color googleBorderColor = Color(0xFFCFCFCF);
  static const Color hintColor = Color(0xFF7A7A7A);

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _collageLeftAnimation = Tween<Offset>(
      begin: const Offset(-0.22, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _collageRightAnimation = Tween<Offset>(
      begin: const Offset(0.22, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0.18, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.15, 0.60, curve: Curves.easeOutCubic),
      ),
    );

    _titleLineOneAnimation = Tween<Offset>(
      begin: const Offset(0, 0.55),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.35, 0.72, curve: Curves.easeOutCubic),
      ),
    );

    _titleLineTwoAnimation = Tween<Offset>(
      begin: const Offset(0, 0.55),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.48, 0.88, curve: Curves.easeOutCubic),
      ),
    );

    _titleLineOneOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.35, 0.70, curve: Curves.easeOut),
      ),
    );

    _titleLineTwoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.48, 0.86, curve: Curves.easeOut),
      ),
    );

    _collageScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.018)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.018, end: 0.992)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.992, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_breathController);

    _entryController.forward().whenComplete(() {
      _breathController.repeat();
    });
  }

  Future<void> _handleContinue() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isChecking = true;
    });

    final email = _emailController.text.trim();
    final exists =
    await ref.read(emailLookupServiceProvider).checkIfUserExists(email);

    if (!mounted) return;

    ref.read(signupDraftProvider.notifier).setEmail(email);

    setState(() {
      _isChecking = false;
    });

    if (exists) {
      context.push('${AppRoutes.login}?email=${Uri.encodeComponent(email)}');
    } else {
      context.push(AppRoutes.createPassword);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _entryController.dispose();
    _breathController.dispose();
    super.dispose();
  }

  InputDecoration _emailInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: 'Email address',
      hintStyle: TextStyle(
        color: hintColor,
        fontSize: AppResponsive.sp(context, 15).clamp(13.0, 16.0),
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppResponsive.w(context, 16).clamp(14.0, 18.0),
        vertical: AppResponsive.h(context, 14).clamp(12.0, 16.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppResponsive.r(context, 18).clamp(16.0, 20.0),
        ),
        borderSide: BorderSide(
          color: borderColor,
          width: AppResponsive.r(context, 1.2).clamp(1.0, 1.4),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppResponsive.r(context, 18).clamp(16.0, 20.0),
        ),
        borderSide: BorderSide(
          color: borderColor,
          width: AppResponsive.r(context, 1.6).clamp(1.2, 1.8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppResponsive.r(context, 18).clamp(16.0, 20.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: AppResponsive.r(context, 1.2).clamp(1.0, 1.4),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppResponsive.r(context, 18).clamp(16.0, 20.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: AppResponsive.r(context, 1.4).clamp(1.2, 1.6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    final double horizontalPadding =
    AppResponsive.w(context, 28).clamp(22.0, 32.0);

    return Scaffold(
      backgroundColor: screenBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                bottom: keyboardInset > 0
                    ? AppResponsive.h(context, 12).clamp(8.0, 14.0)
                    : 0,
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppResponsive.h(context, 4).clamp(2.0, 6.0),
                        ),
                        SizedBox(
                          height: AppResponsive.h(context, 224).clamp(190.0, 240.0),
                          child: _AnimatedTopSection(
                            leftAnimation: _collageLeftAnimation,
                            rightAnimation: _collageRightAnimation,
                            scaleAnimation: _collageScaleAnimation,
                          ),
                        ),
                        SlideTransition(
                          position: _logoAnimation,
                          child: const _PinterestRoundLogo(),
                        ),
                        SizedBox(
                          height: AppResponsive.h(context, 8).clamp(6.0, 10.0),
                        ),
                        _AnimatedHeadline(
                          lineOneAnimation: _titleLineOneAnimation,
                          lineTwoAnimation: _titleLineTwoAnimation,
                          lineOneOpacity: _titleLineOneOpacity,
                          lineTwoOpacity: _titleLineTwoOpacity,
                        ),
                        SizedBox(
                          height: keyboardInset > 0
                              ? AppResponsive.h(context, 12).clamp(10.0, 14.0)
                              : AppResponsive.h(context, 18).clamp(14.0, 20.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: pinterestRed,
                              decoration: _emailInputDecoration(context),
                              validator: (value) {
                                final String email = value?.trim() ?? '';

                                if (email.isEmpty) {
                                  return 'Please enter email address';
                                }

                                final RegExp emailRegex = RegExp(
                                  r'^[\w\.-]+@[\w\.-]+\.\w+$',
                                );

                                if (!emailRegex.hasMatch(email)) {
                                  return 'Please enter a valid email';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppResponsive.h(context, 14).clamp(10.0, 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: AppResponsive.h(context, 46).clamp(42.0, 50.0),
                            child: ElevatedButton(
                              onPressed: _isChecking ? null : _handleContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: pinterestRed,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppResponsive.r(context, 18).clamp(16.0, 20.0),
                                  ),
                                ),
                              ),
                              child: _isChecking
                                  ? SizedBox(
                                width: AppResponsive.r(context, 20)
                                    .clamp(18.0, 22.0),
                                height: AppResponsive.r(context, 20)
                                    .clamp(18.0, 22.0),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: Colors.white,
                                ),
                              )
                                  : Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: AppResponsive.sp(context, 16)
                                      .clamp(14.0, 17.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppResponsive.h(context, 12).clamp(10.0, 14.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: AppResponsive.h(context, 50).clamp(46.0, 54.0),
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                side: BorderSide(
                                  color: googleBorderColor,
                                  width: AppResponsive.r(context, 1.2)
                                      .clamp(1.0, 1.4),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppResponsive.r(context, 18).clamp(16.0, 20.0),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppResponsive.w(context, 16)
                                      .clamp(14.0, 18.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const GoogleIcon(),
                                  SizedBox(
                                    width: AppResponsive.w(context, 12)
                                        .clamp(8.0, 14.0),
                                  ),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      fontSize: AppResponsive.sp(context, 15.5)
                                          .clamp(13.5, 16.5),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppResponsive.h(context, 14).clamp(10.0, 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                            AppResponsive.w(context, 38).clamp(28.0, 42.0),
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: 'Facebook login is no longer\navailable. ',
                              style: TextStyle(
                                fontSize: AppResponsive.sp(context, 13.5)
                                    .clamp(12.0, 14.5),
                                color: Colors.black,
                                height: 1.35,
                                fontWeight: FontWeight.w400,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'Recover your account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        if (keyboardInset == 0) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                              AppResponsive.w(context, 28).clamp(22.0, 32.0),
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: 'By continuing, you agree to Pinterest\'s ',
                                style: TextStyle(
                                  fontSize: AppResponsive.sp(context, 10.8)
                                      .clamp(9.5, 11.5),
                                  color: const Color(0xFF222222),
                                  height: 1.4,
                                ),
                                children: const [
                                  TextSpan(
                                    text: 'Terms of\n',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Service',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                    ' and acknowledge that you\'ve read our\n',
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: '. '),
                                  TextSpan(
                                    text: 'Notice at collection.',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: AppResponsive.h(context, 6).clamp(4.0, 8.0),
                          ),
                          Container(
                            width: AppResponsive.w(context, 115).clamp(90.0, 120.0),
                            height: AppResponsive.h(context, 4).clamp(3.0, 5.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF595959),
                              borderRadius: BorderRadius.circular(
                                AppResponsive.r(context, 20).clamp(12.0, 20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppResponsive.h(context, 6).clamp(4.0, 8.0),
                          ),
                        ] else ...[
                          SizedBox(
                            height: AppResponsive.h(context, 16).clamp(12.0, 18.0),
                          ),
                        ],
                      ],
                    ),
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

class _AnimatedTopSection extends StatelessWidget {
  final Animation<Offset> leftAnimation;
  final Animation<Offset> rightAnimation;
  final Animation<double> scaleAnimation;

  const _AnimatedTopSection({
    required this.leftAnimation,
    required this.rightAnimation,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: child,
        );
      },
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SlideTransition(
              position: rightAnimation,
              child: const PositionedFillSafe(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: 100,
                      top: 75,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/three.jpg',
                        width: 65,
                        height: 70,
                        radius: 18,
                      ),
                    ),
                    Positioned(
                      right: -8,
                      bottom: 20,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/five.jpg',
                        width: 78,
                        height: 88,
                        radius: 18,
                      ),
                    ),
                    Positioned(
                      right: -10,
                      top: -50,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/six.jpg',
                        width: 100,
                        height: 88,
                        radius: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: leftAnimation,
              child: const PositionedFillSafe(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: -10,
                      top: -50,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/one.jpg',
                        width: 95,
                        height: 95,
                        radius: 16,
                      ),
                    ),
                    Positioned(
                      left: -4,
                      top: 130,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/Two.jpg',
                        width: 90,
                        height: 150,
                        radius: 16,
                      ),
                    ),
                    Positioned(
                      left: 100,
                      top: 30,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/four.jpg',
                        width: 128,
                        height: 190,
                        radius: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedHeadline extends StatelessWidget {
  final Animation<Offset> lineOneAnimation;
  final Animation<Offset> lineTwoAnimation;
  final Animation<double> lineOneOpacity;
  final Animation<double> lineTwoOpacity;

  const _AnimatedHeadline({
    required this.lineOneAnimation,
    required this.lineTwoAnimation,
    required this.lineOneOpacity,
    required this.lineTwoOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final double titleFont =
    AppResponsive.sp(context, 28).clamp(23.0, 30.0);
    final double horizontalPadding =
    AppResponsive.w(context, 24).clamp(18.0, 28.0);

    return Column(
      children: [
        ClipRect(
          child: FadeTransition(
            opacity: lineOneOpacity,
            child: SlideTransition(
              position: lineOneAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  'Create a life',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.1,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
        ClipRect(
          child: FadeTransition(
            opacity: lineTwoOpacity,
            child: SlideTransition(
              position: lineTwoAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  'you love',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.1,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PositionedFillSafe extends StatelessWidget {
  final Widget child;

  const PositionedFillSafe({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: child);
  }
}

class _CollageImageCard extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double radius;

  const _CollageImageCard({
    required this.imagePath,
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final double responsiveWidth =
    AppResponsive.w(context, width).clamp(width * 0.8, width * 1.1);
    final double responsiveHeight =
    AppResponsive.h(context, height).clamp(height * 0.8, height * 1.1);
    final double responsiveRadius =
    AppResponsive.r(context, radius).clamp(radius * 0.85, radius * 1.1);

    return ClipRRect(
      borderRadius: BorderRadius.circular(responsiveRadius),
      child: Image.asset(
        imagePath,
        width: responsiveWidth,
        height: responsiveHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PinterestRoundLogo extends StatelessWidget {
  const _PinterestRoundLogo();

  @override
  Widget build(BuildContext context) {
    final double size = AppResponsive.r(context, 70).clamp(58.0, 76.0);

    return SizedBox(
      child: Image.asset(
        'assets/images/pinterest_splash_logo.png',
        width: size,
        height: size,
      ),
    );
  }
}