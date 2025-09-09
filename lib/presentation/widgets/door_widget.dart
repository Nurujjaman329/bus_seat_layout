import 'package:bus_seat_layout/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DoorWidget extends StatelessWidget {
  const DoorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.door.withOpacity(0.15),
        border: Border.all(color: AppColors.door, width: 1.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.door.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Icon(
            Icons.door_front_door, 
            size: 24, 
            color: AppColors.door,
          ),
        ),
      ),
    );
  }
}