import 'package:flutter/material.dart';
import 'package:pinterest_clone/routes/routes.dart';
import '../services/auth_service.dart';

class EmailEntryScreen extends StatefulWidget {
  const EmailEntryScreen({super.key});

  @override
  State<EmailEntryScreen> createState() => _EmailEntryScreenState();
}

class _EmailEntryScreenState extends State<EmailEntryScreen>
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

    final String email = _emailController.text.trim();
    final bool exists = await AuthService.instance.checkIfUserExists(email);

    if (!mounted) return;

    setState(() {
      _isChecking = false;
    });

    if (exists) {
      Navigator.pushNamed(
        context,
        AppRoutes.login,
        arguments: email,
      );
    } else {
      Navigator.pushNamed(
        context,
        AppRoutes.signup,
        arguments: email,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _entryController.dispose();
    _breathController.dispose();
    super.dispose();
  }

  InputDecoration _emailInputDecoration() {
    return InputDecoration(
      hintText: 'Email address',
      hintStyle: const TextStyle(
        color: hintColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: borderColor,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: borderColor,
          width: 1.6,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: screenBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: keyboardInset > 0 ? 12 : 0),
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
                        SizedBox(height: keyboardInset > 0 ? 4 : 4),
                        SizedBox(
                          height: 224,
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
                        const SizedBox(height: 8),
                        _AnimatedHeadline(
                          lineOneAnimation: _titleLineOneAnimation,
                          lineTwoAnimation: _titleLineTwoAnimation,
                          lineOneOpacity: _titleLineOneOpacity,
                          lineTwoOpacity: _titleLineTwoOpacity,
                        ),
                        SizedBox(height: keyboardInset > 0 ? 12 : 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: pinterestRed,
                              decoration: _emailInputDecoration(),
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
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: _isChecking ? null : _handleContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: pinterestRed,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: _isChecking
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: Colors.white,
                                ),
                              )
                                  : const Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                side: const BorderSide(
                                  color: googleBorderColor,
                                  width: 1.2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  _GoogleGIcon(),
                                  SizedBox(width: 12),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 38),
                          child: Text.rich(
                            TextSpan(
                              text:
                              'Facebook login is no longer\navailable. ',
                              style: TextStyle(
                                fontSize: 13.5,
                                color: Colors.black,
                                height: 1.35,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28),
                            child: Text.rich(
                              TextSpan(
                                text:
                                'By continuing, you agree to Pinterest\'s ',
                                style: TextStyle(
                                  fontSize: 10.8,
                                  color: Color(0xFF222222),
                                  height: 1.4,
                                ),
                                children: [
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
                          const SizedBox(height: 6),
                          Container(
                            width: 115,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF595959),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 6),
                        ] else ...[
                          const SizedBox(height: 16),
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
              position: leftAnimation,
              child: const PositionedFillSafe(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: const [
                    Positioned(
                      left: -10,
                      top: -10,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/one.jpg',
                        width: 78,
                        height: 74,
                        radius: 16,
                      ),
                    ),
                    Positioned(
                      left: -4,
                      bottom: 0,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/Two.jpg',
                        width: 80,
                        height: 146,
                        radius: 16,
                      ),
                    ),
                    Positioned(
                      left: 86,
                      top: 38,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/four.jpg',
                        width: 128,
                        height: 145,
                        radius: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: rightAnimation,
              child: const PositionedFillSafe(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: const [
                    Positioned(
                      right: 88,
                      top: 58,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/three.jpg',
                        width: 60,
                        height: 92,
                        radius: 18,
                      ),
                    ),
                    Positioned(
                      right: -4,
                      bottom: 20,
                      child: _CollageImageCard(
                        imagePath: 'assets/images/five.jpg',
                        width: 68,
                        height: 68,
                        radius: 18,
                      ),
                    ),
                    Positioned(
                      right: -2,
                      top: -10,
                      child: _TopCutImageCompact(),
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

class _TopCutImageCompact extends StatelessWidget {
  const _TopCutImageCompact();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(26),
      ),
      child: Container(
        width: 92,
        height: 28,
        color: const Color(0xFFE8D9C7),
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
    return Column(
      children: [
        ClipRect(
          child: FadeTransition(
            opacity: lineOneOpacity,
            child: SlideTransition(
              position: lineOneAnimation,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Create a life',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'you love',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PinterestRoundLogo extends StatelessWidget {
  const _PinterestRoundLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset(
        'assets/images/pinterest_splash_logo.png',
        width: 70,
        height: 70,
      ),
    );
  }
}

class _GoogleGIcon extends StatelessWidget {
  const _GoogleGIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      child: const Text(
        'G',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4285F4),
          height: 1,
        ),
      ),
    );
  }
}