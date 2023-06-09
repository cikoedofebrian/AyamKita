import 'package:app/constant/app_format.dart';
import 'package:app/model/m_data_harian.dart';
import 'package:app/model/m_periode.dart';
import 'package:app/widget/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

class CDataHarian extends ChangeNotifier {
  List<MPeriode> _musimList = [];

  List<MPeriode> get musimList => _musimList;

  List<MDataHarian> getDataHarian(int index) {
    return musimList[index].list;
  }

  MDataHarian? getTanggal(DateTime tanggal, int index) {
    try {
      return getDataHarian(index).firstWhere(
          (element) => AppFormat.stringtoDateTime(element.tanggal) == tanggal);
    } catch (err) {
      return null;
    }
  }

  int getTotalSellings(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int totalProfit = 0;
    for (var i in selectedMusim.list) {
      totalProfit += i.harga * i.keluar;
    }
    return totalProfit - (selectedMusim.jumlah * selectedMusim.harga);
  }

  int getTotalStock(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int totalStock = 0;
    for (var i in selectedMusim.list) {
      totalStock += (i.keluar + i.kematian);
    }
    return selectedMusim.jumlah - totalStock;
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

  String getPeriod(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    if (selectedMusim.status == false) {
      return "${AppFormat.fDate(selectedMusim.mulai)} - ${AppFormat.fDate(selectedMusim.list.last.tanggal)}";
    }
    return "${AppFormat.fDate(selectedMusim.mulai)} - Sekarang";
  }

  double getTotalPakan(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    double hargaPakan = 0;
    for (var i in selectedMusim.list) {
      hargaPakan += i.hargaPakan * i.pakan;
    }
    return hargaPakan;
  }

  int getTotalSell(String musimId) {
    final selectedMusim =
        _musimList.firstWhere((element) => element.musimId == musimId);
    int terjual = 0;
    for (var i in selectedMusim.list) {
      terjual += i.keluar;
    }
    return terjual;
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
        List<MDataHarian> emptyList = [];
        for (var e in result.docs) {
          final newData = MDataHarian.fromJson(e.data());

          emptyList.add(newData);
        }
        emptyList.sort((a, b) => DateFormat('dd-MM-yyyy')
            .parse(a.tanggal)
            .compareTo(DateFormat('dd-MM-yyyy').parse(b.tanggal)));
        musimList.add(MPeriode.fromJson(i.data(), i.id, emptyList));
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  int indexActive() {
    int result = musimList.indexWhere((element) => element.status == true);
    return result;
  }

  Future<MDataHarian?> getTambahData(DateTime date, int index) async {
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

  Future<bool> validasiForm(BuildContext context, int index,
      DateTime initialDate, GlobalKey<FormState> formKey) async {
    var isConfirmed = false;
    if (musimList[index].list.isNotEmpty) {
      final parsedDate =
          DateFormat('dd-MM-yyyy').parse(musimList[index].list.last.tanggal);
      Duration difference = initialDate.difference(parsedDate);
      if (difference > const Duration(days: 1)) {
        customDialog(
            context, 'Gagal', 'Isilah data harian sebelumnya terlebih dahulu!');
        return isConfirmed;
      }
    } else {
      if (AppFormat.intDateFromDateTime(initialDate) !=
          musimList[index].mulai) {
        customDialog(
            context, 'Gagal', 'Isilah data harian sebelumnya terlebih dahulu!');
        return isConfirmed;
      }
    }

    if (initialDate.isAfter(DateTime.now())) {
      customDialog(context, 'Gagal', 'Tidak boleh mengisi di masa depan');
      return isConfirmed;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await NDialog(
        title: const Text('Konfirmasi'),
        content: const Text(
            'Yakin ingin menyimpan data? Data yang sudah disimpan tidak dapat dirubah'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tidak'),
          ),
          TextButton(
              onPressed: () {
                isConfirmed = true;
                Navigator.pop(context);
              },
              child: const Text('Iya'))
        ],
      ).show(context);
    } else {
      customDialog(context, 'Gagal!', 'Data tidak boleh kosong');
    }
    return isConfirmed;
  }

  Future<void> updateDataHarian(
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
    BuildContext context,
  ) async {
    final int stockdifference = getTotalStock(musimList[index].musimId);
    final total = stockdifference - (keluar + kematian);
    if (total < 0) {
      // ignore: use_build_context_synchronously
      customDialog(context, 'Gagal', 'Stok hanya tersisa $stockdifference');
      return;
    }
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
      if (total == 0) {
        _musimList[index].status = false;
        await FirebaseFirestore.instance
            .collection('musim')
            .doc(_musimList[index].musimId)
            .update({
          'status': false,
        });
      }
      _musimList[index].list.add(MDataHarian(
          umur: umur,
          pakan: pakan,
          hargaPakan: hargaPakan,
          kematian: kematian,
          keluar: keluar,
          obat: obat,
          hargaObat: hargaObat,
          harga: harga,
          tanggal: AppFormat.intDateFromDateTime(date)));
      // ignore: use_build_context_synchronously
      customDialog(context, 'Berhasil!', 'Data berhasil ditambahkan!');
      notifyListeners();
    } catch (err) {
      NDialog(
        content: const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Simpan data gagal!',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'))
        ],
      ).show(context);
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
        MPeriode(
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
      rethrow;
    }
  }
}
