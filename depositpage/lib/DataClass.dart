import 'dart:convert';




DataClass loginModelFromJson(String str) => DataClass.fromJson(json.decode(str));

String loginModelToJson(DataClass data) => json.encode(data.toJson());


class DataClass {
  DataClass(
      {this.overallBalanceInUsd,
        this.status,
        this.msg,
        this.deposit,
        this.depositHistory,
        this.username});


  String? overallBalanceInUsd;
  String? status;
  String? msg;
  List<Deposit>? deposit;
  List<DepositHistory>? depositHistory;
  String? username;



  DataClass.fromJson(Map<String, dynamic> json) {
    overallBalanceInUsd = json['overall_balance_in_usd'];
    status = json['status'];
    msg = json['msg'];
    if (json['deposit'] != null) {
      deposit = <Deposit>[];
      json['deposit'].forEach((v) {
        deposit?.add(new Deposit.fromJson(v));
      });
    }
    if (json['deposit_history'] != null) {
      depositHistory = <DepositHistory>[];
      json['deposit_history'].forEach((v) {
        depositHistory!.add(new DepositHistory.fromJson(v));
      });
    }
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overall_balance_in_usd'] = this.overallBalanceInUsd;
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.deposit != null) {
      data['deposit'] = this.deposit!.map((v) => v.toJson()).toList();
    }
    if (this.depositHistory != null) {
      data['deposit_history'] =
          this.depositHistory!.map((v) => v.toJson()).toList();
    }
    data['username'] = this.username;
    return data;
  }
}

class Deposit {
  String? currencyId;
  String? currencyName;
  String? currencySymbol;
  String? currencyImage;
  String? currencyType;
  String? cryptoAddress;
  String? qrcode;

  Deposit(
      {this.currencyId,
        this.currencyName,
        this.currencySymbol,
        this.currencyImage,
        this.currencyType,
        this.cryptoAddress,
        this.qrcode,
        });

  Deposit.fromJson(Map<String, dynamic> json) {
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    currencySymbol = json['currency_symbol'];
    currencyImage = json['currency_image'];
    currencyType = json['currency_type'];
    cryptoAddress = json['crypto_address'];
    qrcode = json['qrcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_image'] = this.currencyImage;
    data['currency_type'] = this.currencyType;
    data['crypto_address'] = this.cryptoAddress;
    data['qrcode'] = this.qrcode;
    return data;
  }
}

class DepositHistory {
  String? currencyImage;
  String? amount;
  String? currencySymbol;
  String? status;
  String? datetime;

  DepositHistory(
      {this.currencyImage,
        this.amount,
        this.currencySymbol,
        this.status,
        this.datetime});

  DepositHistory.fromJson(Map<String, dynamic> json) {
    currencyImage = json['currency_image'];
    amount = json['amount'];
    currencySymbol = json['currency_symbol'];
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_image'] = this.currencyImage;
    data['amount'] = this.amount;
    data['currency_symbol'] = this.currencySymbol;
    data['status'] = this.status;
    data['datetime'] = this.datetime;
    return data;
  }
}