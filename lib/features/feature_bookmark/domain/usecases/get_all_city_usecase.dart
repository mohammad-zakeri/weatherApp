import '../../../../core/params/no_params.dart';
import '../../../../core/resourcies/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/city_entity.dart';
import '../repository/city_repository.dart';

class GetAllCityUseCase implements UseCase<DataState<List<City>>, NoParams>{
  GetAllCityUseCase(this._cityRepository);

  final CityRepository _cityRepository;

  @override
  Future<DataState<List<City>>> call(NoParams params) {
    return _cityRepository.getAllCityFromDB();
  }

}