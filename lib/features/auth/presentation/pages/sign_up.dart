import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/app/router.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/gen_assets/assets.gen.dart';
import 'package:health_tracker/core/theme/app_colors.dart';
import 'package:health_tracker/core/widgets/app_button.dart';
import 'package:health_tracker/core/widgets/app_text_field.dart';
import 'package:health_tracker/features/auth/presentation/providers/auth_providers.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(40),
                Text(
                  'Welcome to',
                  style: context.displayMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(5),
                Text(
                  'Health Tracker',
                  style: context.displayLarge?.copyWith(
                    color: context.theme.primaryColor,
                  ),
                ),
                const Gap(30),
                Text('Create your account', style: context.displaySmall),
                const Gap(30),
                AppTextField(
                  controller: _emailController,
                  hint: 'hello@mail.com',
                  label: 'Email',
                  validator: validateEmailTextFields,
                ),
                const Gap(16),
                AppTextField(
                  controller: _passwordController,
                  hint: 'Your Password',
                  label: 'Password',
                  isPassword: true,
                  validator: validatePasswordTextFields,
                ),
                const Spacer(),
                const Gap(32),
                AppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authNotifier.signUpWithEmail(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    }
                  },
                  buttonText: 'Sign Up',
                  isLoading: authState.loading,
                ),
                const Gap(16),
                AppButton(
                  onPressed: () => context.replaceRoute(const SignInRoute()),
                  buttonText: 'Already have an account? Sign In',
                  buttonType: ButtonType.tonal,
                ),
                const Gap(40),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(height: 0, color: AppColors.textSecondary),
                    ),
                    const Gap(10),
                    Text(
                      'OR',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
                    const Expanded(
                      child: Divider(height: 0, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const Gap(40),
                AppButton(
                  onPressed: authNotifier.signInWithGoogle,
                  buttonText: 'Continue with Google',
                  buttonType: ButtonType.outlined,
                  isLoading: authState.googleLoading,
                  image: Assets.images.google.image(
                    width: 25,
                  ),
                  hasIcon: true,
                ),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
