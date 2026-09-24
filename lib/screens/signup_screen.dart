import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../widgets/ui_helper.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();

  String selectedGender = 'male';
  bool isLoading = false;
  bool hidePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (usernameController.text.trim().isEmpty) {
      UiHelper.showSnackBar(context, 'Please enter username');
      return;
    }

    if (emailController.text.trim().isEmpty) {
      UiHelper.showSnackBar(context, 'Please enter email');
      return;
    }

    if (!emailController.text.contains('@')) {
      UiHelper.showSnackBar(context, 'Please enter a valid email');
      return;
    }

    if (passwordController.text.isEmpty) {
      UiHelper.showSnackBar(context, 'Please enter password');
      return;
    }

    if (passwordController.text.length < 6) {
      UiHelper.showSnackBar(context, 'Password must be at least 6 characters');
      return;
    }

    if (mobileController.text.trim().isEmpty) {
      UiHelper.showSnackBar(context, 'Please enter mobile number');
      return;
    }

    if (mobileController.text.trim().length != 10) {
      UiHelper.showSnackBar(context, 'Mobile number must be 10 digits');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await AuthService.register(
      name: usernameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      mobile: mobileController.text.trim(),
      gender: selectedGender,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result['success'] == true) {
      UiHelper.showSnackBar(
        context,
        result['message'] ?? 'Registration successful',
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      UiHelper.showSnackBar(
        context,
        result['message'] ?? 'Registration failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const Center(
                child: Icon(
                  Icons.eco,
                  color: AppColors.primary,
                  size: 45,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your credentials to continue',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 30),
              UiHelper.customTextField(
                label: 'Username',
                hint: 'Enter your username',
                controller: usernameController,
              ),
              const SizedBox(height: 22),
              UiHelper.customTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 22),
              UiHelper.customTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: passwordController,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              UiHelper.customTextField(
                label: 'Mobile',
                hint: 'Enter your mobile number',
                controller: mobileController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 22),
              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: selectedGender,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightGrey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedGender = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 18),
              const Text(
                'By continuing you agree to our Terms of Service and Privacy Policy.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 22),
              UiHelper.customButton(
                text: 'Sign Up',
                isLoading: isLoading,
                onPressed: register,
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.darkText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}