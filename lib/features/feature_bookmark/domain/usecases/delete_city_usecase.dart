import '../../../../core/resourcies/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/city_repository.dart';

class DeleteCityUseCase implements UseCase<DataState<String>, String>{
  DeleteCityUseCase(this._cityRepository);

  final CityRepository _cityRepository;

  @override
  Future<DataState<String>> call(String params) {
    return _cityRepository.deleteCityByName(params);
  }

}