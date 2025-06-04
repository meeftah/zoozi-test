import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoozitest/app/routes/app.routes.dart';
import 'package:zoozitest/core/utils/string.formatter.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.bloc.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.event.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.state.dart';
import 'package:zoozitest/features/home/domain/entities/wallet.dart';
import 'package:zoozitest/features/home/domain/usecases/wallet.add.usecase.dart';
import 'package:zoozitest/features/home/domain/usecases/wallet.get.usecase.dart';
import 'package:zoozitest/features/home/presentation/bloc/home.bloc.dart';
import 'package:zoozitest/features/home/presentation/bloc/home.event.dart';
import 'package:zoozitest/features/home/presentation/bloc/home.state.dart';
import 'package:zoozitest/injection.container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    sl<HomeBloc>().add(GetWalletsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(addWalletUseCase: sl<WalletAddUseCase>(), getWalletsUseCase: sl<WalletGetUseCase>()),
      child: Scaffold(
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
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is WalletAddedSuccessfully) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wallet added successfully!")));
                } else if (state is WalletErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
            ),
          ],
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Hello, User', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(LogoutEvent());
                            Navigator.pushReplacementNamed(context, AppRoutes.login);
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 85,
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        List<Wallet> wallets = [];

                        if (state is WalletLoadedState) {
                          wallets = state.wallets;
                        }

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: wallets.length + 1,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            if (index < wallets.length) {
                              final wallet = wallets[index];
                              return Container(
                                width: 160,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade200),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wallet.currency,
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(wallet.balance.toString(), style: const TextStyle(color: Colors.black, fontSize: 14)),
                                  ],
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _showAddWalletDialog();
                                },
                                child: Container(
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.green.shade200),
                                    boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))],
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.add_circle_outline, size: 28, color: Colors.green),
                                        SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.account_balance_wallet_outlined, size: 16, color: Colors.green),
                                            SizedBox(width: 4),
                                            Text(
                                              'Add Wallet',
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddWalletDialog() {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController currencyController = TextEditingController();
    final TextEditingController balanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Add New Wallet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: currencyController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.attach_money),
                      labelText: 'Currency (e.g. USD, EUR)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(3), UpperCaseTextFormatter()],
                    validator: (value) {
                      final List<String> validCurrencies = ['USD', 'EUR', 'GBP'];
                      if (value == null || value.trim().isEmpty) {
                        return 'Currency is required';
                      }
                      if (!validCurrencies.contains(value.trim().toUpperCase())) {
                        return 'Please use one of: ${validCurrencies.join(', ')}';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: balanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_balance_wallet),
                      labelText: 'Initial Balance',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Balance is required';
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null || parsed < 0) {
                        return 'Balance must be a valid non-negative number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.grey.shade700),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState?.validate() ?? false) {
                            final currency = currencyController.text.trim();
                            final balance = int.parse(balanceController.text.trim());

                            sl<HomeBloc>().add(AddWalletEvent(currency: currency, initialBalance: balance));

                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
