import '../models/station.dart';

class StationRepository {
  static final StationRepository _instance = StationRepository._internal();
  static StationRepository get instance => _instance;

  StationRepository._internal();

  Future<List<Station>> getNearbyStations() async {
    // TODO: 실제 API 연동
    await Future.delayed(const Duration(seconds: 1));
    return [
      const Station(
        id: 1,
        name: '건국대학교 제1학생회관',
        address: '서울 광진구 화양동 능동로 120',
        latitude: 37.541703,
        longitude: 127.077831,
        business_time: '10:00 - 21:00',
        stations_status: '영업중',
        grade: '1',
      ),
      const Station(
        id: 2,
        name: '건국대학교 공학관 A동',
        address: '서울 광진구 화양동 능동로 120',
        latitude: 37.541670,
        longitude: 127.078833,
        business_time: '10:00 - 21:00',
        stations_status: '영업중',
        grade: '1',
      ),
      const Station(
        id: 3,
        name: '건국대학교 예술디자인 대학',
        address: '서울 광진구 화양동 능동로 120',
        latitude: 37.542911,
        longitude: 127.073029,
        business_time: '07:00 - 22:00',
        stations_status: '영업중',
        grade: '1',
      ),
    ];
  }

  Future<Station?> getStation(int id) async {
    final stations = await getNearbyStations();
    return stations.firstWhere(
      (station) => station.id == id,
      orElse: () => throw Exception('Station not found'),
    );
  }
}
