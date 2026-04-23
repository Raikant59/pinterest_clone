import 'package:flutter/material.dart';
import 'package:pinterest_clone/screens/SignUp%20Screens/widgets/progress_dots.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes.dart';
import '../../features/auth/state/providers.dart';

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
  bool get _hasSymbol => RegExp(r'[!@#\$%^&*(),.?":{}|<>\[\]\\\/_\-+=~`]').hasMatch(_password);

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
    if (_criteriaCount >= 3) return "Looks good";
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

  InputDecoration _passwordDecoration() {
    return InputDecoration(
      border: InputBorder.none,
      hintText: _hasPassword ? null : 'Create a strong password',
      hintStyle: const TextStyle(
        color: hintColor,
        fontSize: 15,
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

    return Scaffold(
      backgroundColor: screenBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(bottom: keyboardInset > 0 ? 20 : 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => context.pop(),
                              padding: EdgeInsets.zero,
                              splashRadius: 20,
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 24,
                                color: Color(0xFF66665E),
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
                            const SizedBox(width: 40),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Center(
                        child: Text(
                          'Create a password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -0.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          height: 68,
                          padding: const EdgeInsets.fromLTRB(14, 6, 12, 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: borderColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 13,
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
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        letterSpacing: -0.2,
                                      ),
                                      decoration: _passwordDecoration(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 24,
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
                      const SizedBox(height: 10),

                      if (_hasPassword)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              height: 10,
                              color: const Color(0xFFE3E3DE),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 260),
                                  curve: Curves.easeOut,
                                  width: MediaQuery.of(context).size.width *
                                      0.72 *
                                      _progressValue,
                                  decoration: BoxDecoration(
                                    color: _progressColor,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 14),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_hasPassword)
                              Text(
                                _statusText,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: _isValidPassword
                                      ? const Color(0xFF5F5F5A)
                                      : const Color(0xFF5F5F5A),
                                ),
                              ),
                            if (_hasPassword) const SizedBox(height: 4),
                            const Text(
                              'Use 8 or more letters, numbers and symbols',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6D6D68),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                      ),


                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: SizedBox(
                          width: double.infinity,
                          height: 54,
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
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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