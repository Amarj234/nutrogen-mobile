import 'package:nutrogen/data/model/package_list_model.dart';
import 'package:nutrogen/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'paywall_provider.g.dart';

@riverpod
FutureOr<List<PackageR>> packageListCall(
  PackageListCallRef ref, {
  required String branchId,
}) async {
  return (await ref
              .watch(userRepositoryProvider)
              .packageList(branchId: branchId))
          ?.r ??
      [];
}

String priceAccordingType({required String? type, required PackageR? package}) {
  String price = '0';
  if (type == 'y') {
    if (package?.priceType == 'm') {
      price = '${(package?.price ?? 0) * 12}';
    } else {
      price = '${(package?.price ?? 0)}';
    }
  } else {
    if (package?.priceType == 'm') {
      price = '${(package?.price ?? 0)}';
    } else {
      price = '${(package?.price ?? 0) / 12}';
    }
  }

  return price;
}
