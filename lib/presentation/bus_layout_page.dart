import 'package:bus_seat_layout/core/theme/app_colors.dart';
import 'package:bus_seat_layout/data/datasources/bus_layout_remote_data_source.dart';
import 'package:bus_seat_layout/data/repositories/bus_layout_repository_impl.dart';
import 'package:bus_seat_layout/domain/usecases/get_bus_layout.dart';
import 'package:bus_seat_layout/presentation/bloc/bus_layout_bloc.dart';
import 'package:bus_seat_layout/presentation/widgets/bus_layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class BusLayoutPage extends StatefulWidget {
  const BusLayoutPage({super.key});

  @override
  BusLayoutPageState createState() => BusLayoutPageState();
}

class BusLayoutPageState extends State<BusLayoutPage> {
  bool isApi1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Seat Layout'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: BlocProvider(
        create: (context) {
          final remoteDataSource = BusLayoutRemoteDataSourceImpl(client: http.Client());
          final repository = BusLayoutRepositoryImpl(remoteDataSource: remoteDataSource);
          final getBusLayout = GetBusLayout(repository: repository);
          
          return BusLayoutBloc(getBusLayout: getBusLayout)
            ..add(LoadBusLayoutFromApi1());
        },
        child: BlocConsumer<BusLayoutBloc, BusLayoutState>(
          listener: (context, state) {
            if (state is BusLayoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 4),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                // Header with API toggle
                _buildHeader(context, state),
                
                // Bus layout content
                Expanded(
                  child: _buildBody(state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, BusLayoutState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isApi1) {
                        setState(() => isApi1 = true);
                        BlocProvider.of<BusLayoutBloc>(context).add(LoadBusLayoutFromApi1());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isApi1 ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'API 1',
                          style: TextStyle(
                            color: isApi1 ? Colors.white : AppColors.grey600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isApi1) {
                        setState(() => isApi1 = false);
                        BlocProvider.of<BusLayoutBloc>(context).add(LoadBusLayoutFromApi2());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isApi1 ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'API 2',
                          style: TextStyle(
                            color: !isApi1 ? Colors.white : AppColors.grey600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Status indicator
          if (state is BusLayoutLoading)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Loading layout...',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            )
          else if (state is BusLayoutLoaded)
            const Text(
              'Layout loaded successfully',
              style: TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

// Update the _buildBody method for better error UI
Widget _buildBody(BusLayoutState state) {
  if (state is BusLayoutLoading) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Loading bus layout...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  } else if (state is BusLayoutLoaded) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        
        return SingleChildScrollView(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            children: [
              // Legend
              _buildLegend(isSmallScreen),
              
              SizedBox(height: isSmallScreen ? 16 : 20),
              
              // Bus layout with container
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppColors.cardShadow,
                ),
                child: BusLayoutWidget(data: state.data),
              ),
            ],
          ),
        );
      },
    );
  } else if (state is BusLayoutError) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline, 
              size: 56, 
              color: AppColors.error
            ),
            const SizedBox(height: 16),
            const Text(
              'Unable to Load Layout',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                final bloc = BlocProvider.of<BusLayoutBloc>(context);
                if (isApi1) {
                  bloc.add(LoadBusLayoutFromApi1());
                } else {
                  bloc.add(LoadBusLayoutFromApi2());
                }
              },
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return const Center(
      child: Text(
        'Select an API to load bus layout',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16,
        ),
      ),
    );
  }
}

  Widget _buildLegend(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: isSmallScreen ? 12 : 20,
        children: [
          _buildLegendItem(const Icon(Icons.chair, color: AppColors.seat), 'Seat'),
          _buildLegendItem(const Icon(Icons.door_front_door, color: AppColors.door), 'Door'),
          _buildLegendItem(const Icon(Icons.airline_seat_recline_extra, color: AppColors.driver), 'Driver'),
          _buildLegendItem(Container(width: 20, height: 20, color: AppColors.grey300), 'Space'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Widget icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}