import 'package:flutter/material.dart';

class HoneyLoadingAnimation extends StatefulWidget {
  final bool isStationSelected;
  final Color dotColor; // 점 색상을 선택할 수 있도록 추가

  const HoneyLoadingAnimation({
    super.key,
    this.isStationSelected = false,
    this.dotColor = Colors.black, // 기본값은 검은색
  });

  @override
  State<HoneyLoadingAnimation> createState() => _HoneyLoadingAnimationState();
}

class _HoneyLoadingAnimationState extends State<HoneyLoadingAnimation>
    with TickerProviderStateMixin {
  late final List<AnimationController> _dotControllers;

  @override
  void initState() {
    super.initState();

    // 점 깜빡임 애니메이션 컨트롤러
    _dotControllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600), // 깜빡이는 시간
        vsync: this,
      ),
    );

    // 순차적으로 애니메이션 실행
    _startSequentialAnimations();
  }

  void _startSequentialAnimations() async {
    while (mounted) {
      for (int i = 0; i < _dotControllers.length; i++) {
        _dotControllers[i].forward(from: 0).then((_) {
          _dotControllers[i].reverse();
        });
        await Future.delayed(const Duration(milliseconds: 700));
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _dotControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isStationSelected) {
      // 스테이션 선택된 경우
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: widget.dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text('🍯'),
        ],
      );
    }

    // 순차적으로 깜빡이는 3개의 점
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedBuilder(
            animation: _dotControllers[index],
            builder: (context, child) {
              return Opacity(
                opacity: _dotControllers[index].value,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: widget.dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
