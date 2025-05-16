import '../models/rental.dart';
import 'base_repository.dart';

class RentalRepository implements BaseRepository<Rental> {
  static final RentalRepository _instance = RentalRepository._internal();
  static RentalRepository get instance => _instance;

  final Map<String, Rental> _rentals = {};

  RentalRepository._internal();

  @override
  Future<Rental> get(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _rentals[id] ??
        Rental(
          id: id,
          userId: 'test-user-id',
          accessoryId: 'A1',
          stationId: 'S1',
          accessoryName: '보조배터리 10000mAh',
          stationName: '강남역점',
          totalPrice: 5000,
          status: RentalStatus.active,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
  }

  @override
  Future<List<Rental>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    return _rentals.values.toList();
  }

  @override
  Future<Rental> create(Rental rental) async {
    await Future.delayed(const Duration(seconds: 1));
    _rentals[rental.id] = rental;
    return rental;
  }

  @override
  Future<Rental> update(Rental rental) async {
    await Future.delayed(const Duration(seconds: 1));
    _rentals[rental.id] = rental;
    return rental;
  }

  @override
  Future<void> delete(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _rentals.remove(id);
  }

  Future<List<Rental>> getByUser(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _rentals.values.where((rental) => rental.userId == userId).toList();
  }

  Future<List<Rental>> getActiveRentals() async {
    await Future.delayed(const Duration(seconds: 1));
    return _rentals.values
        .where((rental) => rental.status == RentalStatus.active)
        .toList();
  }

  Future<List<Rental>> getRentalHistory(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _rentals.values.where((rental) => rental.userId == userId).toList();
  }

  Future<List<Rental>> getRecentRentals() async {
    await Future.delayed(const Duration(seconds: 1));
    return _rentals.values.toList();
  }

  Future<void> returnRental(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    final rental = _rentals[id];
    if (rental != null) {
      _rentals[id] = Rental(
        id: rental.id,
        userId: rental.userId,
        accessoryId: rental.accessoryId,
        stationId: rental.stationId,
        accessoryName: rental.accessoryName,
        stationName: rental.stationName,
        totalPrice: rental.totalPrice,
        status: RentalStatus.completed,
        createdAt: rental.createdAt,
        updatedAt: DateTime.now(),
      );
    }
  }
}
