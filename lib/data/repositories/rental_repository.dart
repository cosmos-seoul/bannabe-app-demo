import '../models/rental.dart';
import 'base_repository.dart';

class RentalRepository implements BaseRepository<Rental> {
  static final RentalRepository _instance = RentalRepository._internal();
  static RentalRepository get instance => _instance;

  RentalRepository._internal();

  @override
  Future<Rental> get(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    final now = DateTime.now();
    return Rental(
      id: id,
      userId: 'test-user-id',
      accessoryId: 'A1',
      stationId: 'S1',
      accessoryName: '보조배터리 10000mAh',
      stationName: '강남역점',
      totalPrice: 5000,
      status: RentalStatus.active,
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  Future<List<Rental>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<Rental> create(Rental rental) async {
    await Future.delayed(const Duration(seconds: 1));
    return rental;
  }

  @override
  Future<Rental> update(Rental rental) async {
    await Future.delayed(const Duration(seconds: 1));
    return rental;
  }

  @override
  Future<void> delete(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<Rental>> getByUser(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<List<Rental>> getActiveRentals() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<List<Rental>> getRentalHistory(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<List<Rental>> getRecentRentals() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<void> returnRental(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: 실제 API 연동
  }
}
