import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../../../data/models/station.dart';
import '../../../data/models/rental.dart';
import '../../../data/models/notice.dart';
import '../../../data/repositories/station_repository.dart';
import '../../../data/repositories/rental_repository.dart';
import '../../../data/repositories/notice_repository.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final StationRepository _stationRepository;
  final NoticeRepository _noticeRepository;
  final LocationService _locationService;
  final StorageService _storageService;

  List<Station> _nearbyStations = [];
  List<Rental> _recentRentals = [];
  List<Rental> _activeRentals = [];
  List<Notice> _notices = [];
  Notice? _latestNotice;
  bool _isLoading = false;
  String? _error;
  bool _hasLocationPermission = false;
  Position? _currentLocation;

  HomeViewModel({
    StationRepository? stationRepository,
    RentalRepository? rentalRepository,
    NoticeRepository? noticeRepository,
    LocationService? locationService,
    AuthService? authService,
    StorageService? storageService,
  })  : _stationRepository = stationRepository ?? StationRepository.instance,
        _noticeRepository = noticeRepository ?? NoticeRepository(),
        _locationService = locationService ?? LocationService.instance,
        _storageService = storageService ?? StorageService.instance {
    _init();
  }

  List<Station> get nearbyStations => _nearbyStations;
  List<Rental> get recentRentals => _recentRentals;
  List<Rental> get activeRentals => _activeRentals;
  Notice? get latestNotice => _latestNotice;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasLocationPermission => _hasLocationPermission;
  Position? get currentLocation => _currentLocation;

  Future<void> _init() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _storageService.clearSelections();

      final position = await _locationService.getCurrentLocation();
      _hasLocationPermission = position != null;
      _currentLocation = position;

      if (_hasLocationPermission) {
        await _loadNearbyStations();
      }

      await Future.wait([
        _loadNotices(),
      ]);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadNearbyStations() async {
    if (!_hasLocationPermission) {
      _nearbyStations = [];
      return;
    }

    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        _nearbyStations = await _stationRepository.getNearbyStations();
      }
    } catch (e) {
      print('Failed to load nearby stations: $e');
      _nearbyStations = [];
    }
  }

  Future<void> _loadNotices() async {
    try {
      _notices = await _noticeRepository.getAll();
      _latestNotice = _notices.isNotEmpty ? _notices.first : null;
    } catch (e) {
      print('Failed to load notices: $e');
      _notices = [];
      _latestNotice = null;
    }
  }

  Future<void> refresh() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.wait([
        _loadNearbyStations(),
        _loadNotices(),
      ]);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> requestLocationPermission() async {
    final position = await _locationService.getCurrentLocation();
    _hasLocationPermission = position != null;
    _currentLocation = position;

    if (_hasLocationPermission) {
      await _loadNearbyStations();
    }

    notifyListeners();
    return _hasLocationPermission;
  }
}
