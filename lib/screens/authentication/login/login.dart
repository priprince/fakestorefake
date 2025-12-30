import 'package:fakestorefake/constants/export_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            CommonWidgets.showToast(state.message);
          }
          if (state is LoginSuccessState) {
            CommonWidgets.showToast("Login Success");
            context.goNamed(Routes.list);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final isLoading = state is LoginLoadingState;
            return LoginForm().modalProgressHud(isLoading);
          },
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              bloc.add(
                LoginButtonEvent(emailController.text, passwordController.text),
              );
            },
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    // return BlocProvider(create: (context) => LoginBloc(), child: LoginScreen());
    return BlocProvider.value(value: LoginBloc(), child: LoginScreen());
  }
}
