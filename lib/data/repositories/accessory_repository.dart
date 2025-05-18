import '../models/accessory.dart';

class AccessoryRepository {
  Future<List<Accessory>> getAll() async {
    // 시뮬레이션을 위한 더미 데이터
    await Future.delayed(const Duration(seconds: 1));
    return [
      // 충전기
      Accessory(
        id: 'charger-1',
        name: '노트북 고출력 충전기',
        description: '100W PD 고속 충전기',
        pricePerHour: 2000,
        category: AccessoryCategory.charger,
        isAvailable: true,
        imageUrl: 'assets/images/items/charger-1.jpg', // canva
      ),
      Accessory(
        id: 'charger-2',
        name: '3 Port PD 충전기',
        description: '110W 퀵차지 충전기',
        pricePerHour: 1500,
        category: AccessoryCategory.charger,
        isAvailable: true,
        imageUrl: 'assets/images/items/charger-2.jpeg', // canva
      ),
      Accessory(
        id: 'charger-3',
        name: '2 Port 충전기',
        description: '65W 듀얼 퀵차지 충전기',
        pricePerHour: 1000,
        category: AccessoryCategory.charger,
        isAvailable: true,
        imageUrl:
            'assets/images/items/charger-3.jpeg', // [Freepik] charger-usb-cable-type-c-white-isolated-background
      ),
      Accessory(
        id: 'charger-4',
        name: '5 Port PD 퀵차지 멀티 충전기',
        description: '228W 멀티 PD 퀵차지 충전기',
        pricePerHour: 1000,
        category: AccessoryCategory.charger,
        isAvailable: false,
        imageUrl:
            'assets/images/items/charger-4.jpeg', // GettyImages-1479104893
      ),

      // 케이블
      Accessory(
        id: 'cable-1',
        name: 'HDMI 케이블',
        description: '4K 지원 HDMI 2.0',
        pricePerHour: 1000,
        category: AccessoryCategory.cable,
        isAvailable: true,
        imageUrl: 'assets/images/items/cable-1.jpeg', // GettyImages-478051415
      ),
      Accessory(
        id: 'cable-2',
        name: 'DP 케이블',
        description: '4K 지원 DisplayPort 1.4',
        pricePerHour: 1000,
        category: AccessoryCategory.cable,
        isAvailable: true,
        imageUrl: 'assets/images/items/cable-2.jpg', // canva
      ),
      Accessory(
        id: 'cable-3',
        name: 'C to C 케이블',
        description: '100W PD 지원',
        pricePerHour: 500,
        category: AccessoryCategory.cable,
        isAvailable: true,
        imageUrl: 'assets/images/items/cable-3.jpeg', // canva
      ),
      Accessory(
        id: 'cable-4',
        name: 'C to A 케이블',
        description: '고속 데이터 전송',
        pricePerHour: 500,
        category: AccessoryCategory.cable,
        isAvailable: false,
        imageUrl:
            'assets/images/items/cable-4.jpg', // [Freepik] usb-cable-type-c-white-isolated-background
      ),

      // 독
      Accessory(
        id: 'dock-1',
        name: 'SD 카드 독 (Type-C)',
        description: 'SD/MicroSD 지원',
        pricePerHour: 1500,
        category: AccessoryCategory.dock,
        isAvailable: true,
        imageUrl: 'assets/images/items/dock-1.png', // canva
      ),
      Accessory(
        id: 'dock-2',
        name: 'USB 독 (Type-C)',
        description: 'USB 3.0 4포트',
        pricePerHour: 1500,
        category: AccessoryCategory.dock,
        isAvailable: true,
        imageUrl:
            'assets/images/items/dock-2.png', // [Freepik] usb-hubs-digital-device
      ),
      Accessory(
        id: 'dock-3',
        name: '멀티 독 (Type-C)',
        description: 'HDMI, USB, SD 카드 지원',
        pricePerHour: 2000,
        category: AccessoryCategory.dock,
        isAvailable: false,
        imageUrl:
            'assets/images/items/dock-3.png', // [pexels] pexels-rann-vijay-677553-7742582
      ),

      // 보조배터리
      Accessory(
        id: 'powerbank-1',
        name: '노트북용 보조배터리',
        description: '20000mAh, 100W PD',
        pricePerHour: 3000,
        category: AccessoryCategory.powerBank,
        isAvailable: true,
        imageUrl:
            'assets/images/items/powerbank-1.jpeg', // [Freepik] png-power-bank-isolated-white-background
      ),
      Accessory(
        id: 'powerbank-2',
        name: '휴대폰용 보조배터리',
        description: '10000mAh, 25W',
        pricePerHour: 1500,
        category: AccessoryCategory.powerBank,
        isAvailable: false,
        imageUrl:
            'assets/images/items/powerbank-2.jpeg', // [Freepik] png-power-bank-isolated-white-background
      ),

      // 기타
      Accessory(
        id: 'etc-1',
        name: '발표용 리모콘',
        description: '레이저 포인터 내장',
        pricePerHour: 1000,
        category: AccessoryCategory.etc,
        isAvailable: false,
        imageUrl: 'assets/images/items/etc-1.png', // canva
      ),

      Accessory(
        id: 'etc-2',
        name: '펜타그래프 키보드',
        description: 'Logitech MX Keys mini',
        pricePerHour: 1000,
        category: AccessoryCategory.etc,
        isAvailable: true,
        imageUrl: 'assets/images/items/keyboard.webp',
      ),

      Accessory(
        id: 'etc-3',
        name: '무소음 블루투스 마우스',
        description: 'Logitech MX Anywhere 3S',
        pricePerHour: 1000,
        category: AccessoryCategory.etc,
        isAvailable: true,
        imageUrl: 'assets/images/items/mouse.webp',
      ),
    ];
  }

  Future<Accessory> get(String id) async {
    final accessories = await getAll();
    return accessories.firstWhere((a) => a.id == id);
  }
}
