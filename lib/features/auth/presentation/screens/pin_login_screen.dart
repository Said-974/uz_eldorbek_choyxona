import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/pin_numpad_widget.dart';

class PinLoginScreen extends StatefulWidget {
  final String restaurantId;
  final String branchName;

  const PinLoginScreen({
    super.key,
    required this.restaurantId,
    required this.branchName,
  });

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  String _enteredPin = '';
  static const int _pinLength = 5;

  void _onDigitPressed(String digit) {
    if (_enteredPin.length < _pinLength) {
      setState(() {
        _enteredPin += digit;
      });

      if (_enteredPin.length == _pinLength) {
        context.read<AuthBloc>().add(
              SubmitPinEvent(
                restaurantId: widget.restaurantId,
                pin: _enteredPin,
              ),
            );
      }
    }
  }

  void _onDeletePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.statusBillRequested,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              setState(() {
                _enteredPin = '';
              });
            } else if (state is Authenticated) {
              _routeByRole(context, state.user);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  Text(
                    widget.branchName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Shaxsiy PIN-kodingizni kiriting',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPinIndicators(),
                  const SizedBox(height: 16),
                  if (state is AuthLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: CircularProgressIndicator(color: AppColors.accent),
                    ),
                  const Spacer(),
                  PinNumPadWidget(
                    onDigitPress: _onDigitPressed,
                    onDeletePress: _onDeletePressed,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPinIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pinLength, (index) {
        final isFilled = index < _enteredPin.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? AppColors.primary : Colors.transparent,
            border: Border.all(
              color: isFilled ? AppColors.primary : AppColors.textMuted,
              width: 2,
            ),
          ),
        );
      }),
    );
  }

  void _routeByRole(BuildContext context, UserEntity user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Xush kelibsiz, ${user.fullName}! (${user.roleName})'),
        backgroundColor: AppColors.statusAvailable,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}