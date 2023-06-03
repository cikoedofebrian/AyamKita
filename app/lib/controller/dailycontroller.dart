import 'package:app/constant/appformat.dart';
import 'package:app/helper/customexception.dart';
import 'package:app/model/dataharianmodel.dart';
import 'package:app/model/musimmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyController extends ChangeNotifier {
  List<MusimModel> _musimList = [];

  List<MusimModel> get musimList => _musimList;

  int getTotalProfit(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int totalProfit = 0;
    for (var i in selectedMusim.list) {
      totalProfit += i.harga;
    }
    return totalProfit;
  }

  int getTotalStock(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int totalProfit = 0;
    for (var i in selectedMusim.list) {
      totalProfit += i.harga;
    }
    return totalProfit;
  }

  int getTotalObat(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int hargaObat = 0;
    for (var i in selectedMusim.list) {
      hargaObat += i.hargaObat;
    }
    return hargaObat;
  }

  int getTotalPakan(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int hargaPakan = 0;
    for (var i in selectedMusim.list) {
      hargaPakan += i.hargaPakan;
    }
    return hargaPakan;
  }

  int getTotalDead(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int totalDead = 0;
    for (var i in selectedMusim.list) {
      totalDead += i.kematian;
    }
    return totalDead;
  }

  Future<void> fetchData(String farmId) async {
    try {
      _musimList = [];
      final musim = await FirebaseFirestore.instance
          .collection('musim')
          .where('peternakanId', isEqualTo: farmId)
          .get();

      for (var i in musim.docs) {
        final result = await FirebaseFirestore.instance
            .collection('data_harian')
            // .orderBy('tanggal', descending: false)
            .where('musimId', isEqualTo: i.id)
            .get();
        List<DataHarianModel> emptyList = [];
        for (var e in result.docs) {
          final newData = DataHarianModel.fromJson(e.data());

          emptyList.add(newData);
        }
        emptyList.sort((a, b) => DateFormat('dd-MM-yyyy')
            .parse(a.tanggal)
            .compareTo(DateFormat('dd-MM-yyyy').parse(b.tanggal)));
        musimList.add(MusimModel.fromJson(i.data(), i.id, emptyList));
      }

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  int indexActive() {
    int result = musimList.indexWhere((element) => element.status == true);
    return result;
  }

  Future<DataHarianModel?> checkDate(DateTime date, int index) async {
    for (var i in musimList[index].list) {
      final data = DateFormat('dd-MM-yyyy').parse(i.tanggal);
      if (DateTime(data.year, data.month, data.day) ==
          DateTime(date.year, date.month, date.day)) {
        return i;
      }
    }
    return null;
  }

  bool anyActive() {
    for (var i in musimList) {
      if (i.status == true) {
        return true;
      }
    }
    return false;
  }

  Future<void> addData(
    DateTime date,
    int umur,
    double pakan,
    int hargaPakan,
    int kematian,
    int keluar,
    int hargaObat,
    String obat,
    int index,
    int harga,
    bool isDone,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('data_harian').add({
        'tanggal': AppFormat.intDateFromDateTime(date),
        'umur': umur,
        'pakan': pakan,
        'harga_pakan': hargaPakan,
        'kematian': kematian,
        'keluar': keluar,
        'obat': obat,
        'harga_obat': hargaObat,
        'musimId': _musimList[index].musimId,
        'harga': harga,
      });
      if (isDone) {
        _musimList[index].status = false;

        await FirebaseFirestore.instance
            .collection('musim')
            .doc(_musimList[index].musimId)
            .update({
          'status': false,
        });
      }

      _musimList[index].list.add(DataHarianModel(
          umur: umur,
          pakan: pakan,
          hargaPakan: hargaPakan,
          kematian: kematian,
          keluar: keluar,
          obat: obat,
          hargaObat: hargaObat,
          harga: harga,
          tanggal: AppFormat.intDateFromDateTime(date)));
      notifyListeners();
    } catch (error) {
      if (error is FirebaseException) {
        throw CustomException(error.message!);
      } else {
        print(error);
      }
    }
  }

  Future<void> addMusim(
      String tipe, int jumlah, int harga, String peternakanId) async {
    try {
      final result = await FirebaseFirestore.instance.collection('musim').add({
        'peternakanId': peternakanId,
        'tipe': tipe,
        'jumlah': jumlah,
        'harga': harga,
        'status': true,
        'mulai': AppFormat.intDateFromDateTime(
          DateTime.now(),
        ),
      });

      _musimList.add(
        MusimModel(
          musimId: result.id,
          peternakanId: peternakanId,
          harga: harga,
          jumlah: jumlah,
          tipe: tipe,
          status: true,
          list: [],
          mulai: AppFormat.intDateFromDateTime(
            DateTime.now(),
          ),
        ),
      );

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
