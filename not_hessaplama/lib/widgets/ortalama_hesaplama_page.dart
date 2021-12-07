import 'package:flutter/material.dart';
import 'package:not_hesaplama/constant/app_constants.dart';
import 'package:not_hesaplama/helper/data_helper.dart';
import 'package:not_hesaplama/model/ders.dart';
import 'package:not_hesaplama/widgets/harf_dropdown_widgets.dart';
import 'package:not_hesaplama/widgets/kredi_dropdown_widgets.dart';
import 'package:not_hesaplama/widgets/ortalama_goster_widgets.dart';

import 'ders_listesi.dart';

class OrtalamaHesaplama extends StatefulWidget {
  OrtalamaHesaplama({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplama> createState() => _OrtalamaHesaplamaState();
}

class _OrtalamaHesaplamaState extends State<OrtalamaHesaplama> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double secilenHarfDegeri = 1;
  double secilenKrediDegeri = 2;
  String girilenDersAdi = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            Sabitler.anaBaslik,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                  dersSayisi: DataHelper.tumEklenenDersler.length,
                  ortalama: DataHelper.ortalamaHesapla(),
                ),
              ),
            ],
          ),
          Expanded(
            child: DersListesi(
              onDismiss: (index) {
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormField(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: HarfDropDownWidget(onHarfSecildi: (harf) {
                    secilenHarfDegeri = harf;
                  }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: KrediDropDownWidget(onKrediSecildi: (kredi) {
                    secilenKrediDegeri = kredi;
                  }),
                ),
              ),
              IconButton(
                onPressed: _dersEkleveOrtalamaHesapla,
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return "Ders Adını Giriniz";
        } else
          return null;
      },
      decoration: InputDecoration(
        hintText: "Ders adını giriniz",
        border: OutlineInputBorder(
          borderRadius: Sabitler.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.2),
      ),
    );
  }

  _createDropDownMenuItem(String harf, double deger) {
    return DropdownMenuItem(
      child: Text(harf),
      value: deger,
    );
  }

  void _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
