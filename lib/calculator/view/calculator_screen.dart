import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_api/genius_api.dart';
import 'package:genius_wallet/app/screens/loading_screen.dart';
import 'package:genius_wallet/app/widgets/app_screen_view.dart';
import 'package:genius_wallet/calculator/bloc/calculator_cubit.dart';
import 'package:genius_wallet/calculator/bloc/calculator_state.dart';
import 'package:genius_wallet/widgets/components/back_button_header.g.dart';
import 'package:genius_wallet/widgets/components/currency_selector/mode_from.g.dart';
import 'package:genius_wallet/widgets/components/currency_selector/mode_to.g.dart';
import 'package:genius_wallet/widgets/components/header.g.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubit(
        geniusApi: context.read<GeniusApi>(),
      )..getCurrencies(),
      child: const _CalculatorView(),
    );
  }
}

class _CalculatorView extends StatelessWidget {
  const _CalculatorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      builder: (context, state) {
        if (state.getCurrenciesStatus == CalculatorStatus.loading) {
          return const LoadingScreen();
        } else if (state.getCurrenciesStatus == CalculatorStatus.loaded) {
          return Scaffold(
            body: AppScreenView(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return BackButtonHeader(
                            constraints,
                            ovrTitle: '',
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Header(
                            constraints,
                            ovrHeaderName: 'Calculator',
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 120,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return ModeFrom(constraints);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return ModeTo(constraints);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Something went wrong loading this screen. Please try again!',
            ),
          );
        }
      },
    );
  }
}
