import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoozitest/app/routes/app.routes.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.bloc.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.event.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.state.dart';
import 'package:zoozitest/shared/widgets/loading.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthenticatedState) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }
            },
          ),
        ],
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text('Welcome to Home Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: const Text('Logout'),
                ),
                const SizedBox(height: 20),
                // const LoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
