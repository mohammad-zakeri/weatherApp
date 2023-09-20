import '../../../../core/resourcies/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/city_entity.dart';
import '../repository/city_repository.dart';

class SaveCityUseCase implements UseCase<DataState<City>, String>{
  SaveCityUseCase(this._cityRepository);

  final CityRepository _cityRepository;

  @override
  Future<DataState<City>> call(String params) {
    return _cityRepository.saveCityToDB(params);
  }

}