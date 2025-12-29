import 'package:fakestorefake/constants/export_page.dart';
import 'package:fakestorefake/screens/authentication/signUp/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocListener, BlocProvider;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpErrorState) {
            CommonWidgets.showToast(state.errorMessage);
          }
          if (state is SignUpSuccessState) {
            CommonWidgets.showToast("Login Success");
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            final isLoading = state is SignUpLoadingState;
            return SignUpForm().modalProgressHud(isLoading);
          },
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email required";
              }
              return null;
            },
          ),
          SizedBox(height: 50),
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name required";
              }
              return null;
            },
          ),
          SizedBox(height: 50),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.length < 2) {
                return "Password must be 2 chars";
              }
              return null;
            },
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              signUpBloc.add(
                SignUpButtonEvent(
                  nameController.text,
                  emailController.text,
                  passwordController.text,
                ),
              );
            },
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: SignUpBloc(), child: SignUpScreen());
  }
}
