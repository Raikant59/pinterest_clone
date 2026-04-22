import 'package:flutter/material.dart';
import 'package:pinterest_clone/screens/SignUp Screens/widgets/progress_dots.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/services/state/providers.dart';

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

  InputDecoration _nameDecoration() {
    return const InputDecoration(
      border: InputBorder.none,
      hintText: 'Full name',
      hintStyle: TextStyle(
        color: hintColor,
        fontSize: 15,
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
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
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
                                  filledCount: 2,
                                  outlinedIndex: 2,
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
                          "What's your name?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: borderColor,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _nameController,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    letterSpacing: -0.2,
                                  ),
                                  decoration: _nameDecoration(),
                                ),
                              ),
                              if (_hasName)
                                InkWell(
                                  onTap: () {
                                    _nameController.clear();
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      size: 26,
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
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: SizedBox(
                          width: double.infinity,
                          height: 54,
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