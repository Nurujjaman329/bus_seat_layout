import 'package:bus_seat_layout/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final String name;
  final bool isSelected;

  const SeatWidget({
    super.key,
    required this.name,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.seatSelected : AppColors.seat.withOpacity(0.8),
        border: Border.all(
          color: isSelected ? AppColors.primaryDark : AppColors.primary,
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected ? [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.primaryDark,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}