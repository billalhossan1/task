import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constant/app_colors.dart';
import 'controller/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.instance.primary,
            elevation: 0,
            leading: GestureDetector(
              onTap: Get.back,
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.instance.white,
              ),
            ),
            title: CommonText(
              text: 'My Profile',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColors.instance.white,
            ),
          ),
          body: ctrl.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ctrl.user == null
              ? Center(
                  child: CommonText(
                    text: 'Unable to load profile',
                    fontSize: 14,
                    textColor: AppColors.instance.dark300,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.instance.primary.withOpacity(
                          0.1,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 56,
                          color: AppColors.instance.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CommonText(
                        text: ctrl.user!.fullName,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.instance.dark500,
                      ),
                      const SizedBox(height: 4),
                      CommonText(
                        text: '@${ctrl.user!.username}',
                        fontSize: 13,
                        textColor: AppColors.instance.dark300,
                      ),
                      const SizedBox(height: 28),
                      _InfoTile(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: ctrl.user!.email,
                      ),
                      _InfoTile(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: ctrl.user!.phone,
                      ),
                      _InfoTile(
                        icon: Icons.location_on_outlined,
                        label: 'Address',
                        value: ctrl.user!.address.full,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.instance.dark200.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.instance.primary500, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: label,
                  fontSize: 11,
                  textColor: AppColors.instance.dark300,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 2),
                CommonText(
                  text: value,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.instance.dark500,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
