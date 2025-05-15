import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/rental.dart';
import 'payment_complete_view.dart';

class PaymentView extends StatefulWidget {
  final Rental rental;

  const PaymentView({
    super.key,
    required this.rental,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String? accessoryName;
  String? stationName;
  int? hours;
  int? totalPrice;
  bool agreedToTerms = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedInfo();
  }

  Future<void> _loadSavedInfo() async {
    final storage = StorageService.instance;
    final savedAccessoryName =
        await storage.getString('selected_accessory_name');
    final savedStationName = await storage.getString('selected_station_name');
    final savedHours = await storage.getInt('selected_rental_duration');
    final savedPrice = await storage.getInt('selected_price');

    if (mounted) {
      setState(() {
        accessoryName = savedAccessoryName;
        stationName = savedStationName;
        hours = savedHours;
        totalPrice = savedPrice;
      });
    }
  }

  Future<void> _handlePaymentButtonTap() async {
    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('결제 약관에 동의해주세요.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 결제 처리 시뮬레이션
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PaymentCompleteView(
            rental: widget.rental,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('결제하기'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('대여 정보', style: AppTheme.titleMedium),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('스테이션'),
                                  Text(widget.rental.stationName),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('상품'),
                                  Text(widget.rental.accessoryName),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('대여 시간'),
                                  Text(
                                      '${widget.rental.totalRentalTime.inHours}시간'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('시간당 금액'),
                                  Text(
                                      '${widget.rental.totalRentalTime.inHours > 0 ? widget.rental.totalPrice ~/ widget.rental.totalRentalTime.inHours : widget.rental.totalPrice}원'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '총 결제 금액',
                                    style: AppTheme.titleMedium.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    '${widget.rental.totalPrice}원',
                                    style: AppTheme.titleMedium.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('결제 동의', style: AppTheme.titleMedium),
                              const SizedBox(height: 16),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('결제 진행 및 대여 약관에 동의합니다'),
                                value: agreedToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    agreedToTerms = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handlePaymentButtonTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        agreedToTerms ? AppColors.primary : Colors.grey[300],
                    foregroundColor:
                        agreedToTerms ? Colors.black : Colors.grey[600],
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '결제 진행 중...',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: agreedToTerms
                                    ? Colors.black
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '결제하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                agreedToTerms ? Colors.black : Colors.grey[600],
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
