import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'pin_login_screen.dart';

class BranchSelectionScreen extends StatelessWidget {
  const BranchSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Filialni tanlang',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Qaysi filialda ish boshlamoqchisiz?',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _buildBranchCard(
                context,
                title: 'CHOYXONA №1',
                subtitle: 'Asosiy zal va shiyponlar',
                restaurantId: 'r0000000-0000-0000-0000-000000000001',
                icon: Icons.storefront,
              ),
              const SizedBox(height: 20),
              _buildBranchCard(
                context,
                title: 'CHOYXONA №2',
                subtitle: 'Yangi zal va kottej xonalar',
                restaurantId: 'r0000000-0000-0000-0000-000000000002',
                icon: Icons.store,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBranchCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String restaurantId,
    required IconData icon,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PinLoginScreen(
                restaurantId: restaurantId,
                branchName: title,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 36, color: AppColors.primary),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}