import 'package:bus_seat_layout/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'seat_widget.dart';
import 'door_widget.dart';
import 'driver_widget.dart';
import 'space_widget.dart';

class BusLayoutWidget extends StatelessWidget {
  final List<dynamic> data;

  const BusLayoutWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 400;
        final double itemSize = isSmallScreen ? 44 : 52; // Increased size for better appearance
        
        // Calculate max columns
        int maxColumns = 0;
        for (var row in data) {
          if (row is List) {
            if (row.length > maxColumns) maxColumns = row.length;
          } else if (row is Map) {
            final keys = row.keys.map((k) => int.parse(k.toString())).toList();
            if (keys.isNotEmpty) {
              final maxKey = keys.reduce((a, b) => a > b ? a : b);
              if (maxKey + 1 > maxColumns) maxColumns = maxKey + 1;
            }
          }
        }

        return Column(
          children: [
            // Bus front representation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.grey300,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'FRONT',
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Bus layout rows
            for (int i = 0; i < data.length; i++)
              _buildRow(data[i], maxColumns, i, itemSize),
              
            // Bus back representation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.grey300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'BACK',
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(dynamic rowData, int maxColumns, int rowIndex, double itemSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(maxColumns, (colIndex) {
          return SizedBox(
            width: itemSize,
            height: itemSize,
            child: _getWidgetForCell(rowData, colIndex),
          );
        }),
      ),
    );
  }

  Widget _getWidgetForCell(dynamic rowData, int colIndex) {
    if (rowData is List) {
      if (colIndex < rowData.length) {
        return _getWidgetByType(rowData[colIndex]);
      } else {
        return const SpaceWidget();
      }
    } else if (rowData is Map) {
      final cellData = rowData[colIndex.toString()];
      if (cellData != null) {
        return _getWidgetByType(cellData);
      } else {
        return const SpaceWidget();
      }
    } else {
      return const SpaceWidget();
    }
  }

  Widget _getWidgetByType(dynamic cellData) {
    final type = cellData['type'];
    final name = cellData['name'] ?? '';

    switch (type) {
      case 'seat':
        return SeatWidget(name: name);
      case 'door':
        return const DoorWidget();
      case 'driver':
        return const DriverWidget();
      case 'space':
      default:
        return const SpaceWidget();
    }
  }
}