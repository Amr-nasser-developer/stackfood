import 'package:stackfood_multivendor/features/home/domain/models/banner_model.dart';
import 'package:stackfood_multivendor/features/home/domain/models/cashback_model.dart';
import 'package:stackfood_multivendor/features/home/domain/repositories/home_repository_interface.dart';
import 'package:stackfood_multivendor/features/home/domain/services/home_service_interface.dart';

class HomeService implements HomeServiceInterface {
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeService({required this.homeRepositoryInterface});

  @override
  Future<BannerModel?> getBannerList() async {
    return await homeRepositoryInterface.getList();
  }

  @override
  Future<List<CashBackModel>?> getCashBackOfferList() async {
    return await homeRepositoryInterface.getCashBackOfferList();
  }

  @override
  Future<CashBackModel?> getCashBackData(double amount) async {
    return await homeRepositoryInterface.getCashBackData(amount);
  }

}