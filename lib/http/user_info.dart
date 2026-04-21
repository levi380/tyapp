import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

// {
//   "id": 101244,
//   "tenantId": 0,
//   "accessToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ7XCJhY2NvdW50VHlwZVwiOjAsXCJjcmVhdGVUaW1lXCI6XCIyMDI0LTAzLTEwIDEwOjIxOjQzLjI0NTcyMzYxNFwiLFwiZW1haWxcIjpcImJvYm9rYTIwMDFAZ21haWwuY29tXCIsXCJpZFwiOjEwMTI0NCxcIm1lbWJlckxldmVsXCI6MCxcIm5pY2tuYW1lXCI6XCJib2Jva2EyMDAxXCIsXCJzdGF0dXNcIjoxLFwidGVuYW50SWRcIjowLFwidXNlcm5hbWVcIjpcImJvYm9rYTIwMDFcIn0iLCJleHAiOjE3MTAwNzY5MDN9.o61yUehXC0tNXFduqWy-HmlJ9TgS5LlCo_o9OBVN_gA",
//   "refreshToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ7XCJhY2NvdW50VHlwZVwiOjAsXCJjcmVhdGVUaW1lXCI6XCIyMDI0LTAzLTEwIDEwOjIxOjQzLjI0NTcyMzYxNFwiLFwiZW1haWxcIjpcImJvYm9rYTIwMDFAZ21haWwuY29tXCIsXCJpZFwiOjEwMTI0NCxcIm1lbWJlckxldmVsXCI6MCxcIm5pY2tuYW1lXCI6XCJib2Jva2EyMDAxXCIsXCJzdGF0dXNcIjoxLFwidGVuYW50SWRcIjowLFwidXNlcm5hbWVcIjpcImJvYm9rYTIwMDFcIn0iLCJleHAiOjE3MTAwNzY5MDN9.o61yUehXC0tNXFduqWy-HmlJ9TgS5LlCo_o9OBVN_gA",
//   "phoneNumber": null,
//   "username": "boboka2001",
//   "nickname": "boboka2001",
//   "password": "Fx123456",
//   "gender": null,
//   "headerImg": null,
//   "email": "boboka2001@gmail.com",
//   "birthday": null,
//   "memberLevel": 0,
//   "address": null,
//   "accountType": 0,
//   "parentId": null,
//   "parentName": null,
//   "channelId": null,
//   "channelCode": null,
//   "status": 1,
//   "createTime": "2024-03-10 10:21:43"
// }

class tsUserInfo {
  int? id;
  int? tenantId;
  String? accessToken;
  String? refreshToken;
  String? phoneNumber;
  String? username;
  String? nickname;
  String? password;
  Object? gender;
  String? headerImg;
  String? email;
  String? areaCode;
  String? birthday;
  int? memberLevel;
  Object? address;
  int? accountType;
  Object? parentId;
  String? parentName;
  String? channelId;
  String? channelCode;
  int? status;
  int? createTime;

  tsUserInfo({
    this.id,
    this.tenantId,
    this.accessToken,
    this.refreshToken,
    this.phoneNumber,
    this.username,
    this.nickname,
    this.password,
    this.gender,
    this.areaCode,
    this.headerImg,
    this.email,
    this.birthday,
    this.memberLevel,
    this.address,
    this.accountType,
    this.parentId,
    this.parentName,
    this.channelId,
    this.channelCode,
    this.status,
    this.createTime,
  });

  factory tsUserInfo.fromJson(Map<String, dynamic> json) {
    // log("UserInfo------------$json");

    return tsUserInfo(
      id: asT<int>(json['id']),
      tenantId: asT<int>(json['tenantId']),
      accessToken: asT<String>(json['accessToken']),
      refreshToken: asT<String>(json['refreshToken']),
      phoneNumber: asT<String>(json['phoneNumber']),
      username: asT<String>(json['username']),
      nickname: asT<String>(json['nickname']),
      password: asT<String>(json['password']),
      gender: asT<Object>(json['gender']),
      areaCode: asT<String>(json['areaCode']),
      headerImg: asT<String>(json['headerImg']),
      email: asT<String>(json['email']),
      birthday: asT<String>(json['birthday']),
      memberLevel: asT<int>(json['memberLevel']),
      address: asT<Object>(json['address']),
      accountType: asT<int>(json['accountType']),
      parentId: asT<Object>(json['parentId']),
      parentName: asT<String>(json['parentName']),
      channelId: asT<String>(json['channelId']),
      channelCode: asT<String>(json['channelCode']),
      status: asT<int>(json['status']),
      createTime: asT<int>(json['createTime']),
    );
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'tenantId': tenantId,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'phoneNumber': phoneNumber,
        'username': username,
        'nickname': nickname,
        'password': password,
        'gender': gender,
        'areaCode': areaCode,
        'headerImg': headerImg,
        'email': email,
        'birthday': birthday,
        'memberLevel': memberLevel,
        'address': address,
        'accountType': accountType,
        'parentId': parentId,
        'parentName': parentName,
        'channelId': channelId,
        'channelCode': channelCode,
        'status': status,
        'createTime': createTime,
      };
}

// {
//     "code": 10000,
// "data": {
//     "id": 101311,
//     "username": "6yFAP6Vgw0s5",
//     "usernameStatus": 0,
//     "headImg": "https://dev1-xg-aws-bucket.s3.me-central-1.amazonaws.com/platform/png/9525aa8e7e43494684a1d19eea990b51_默认头像9.png",
//     "nickname": "6yFAP6Vgw0s5",
//     "gender": 1,
//     "birthDay": "1990-01-01",
//     "phoneNumber": "",
//     "registerIp": "172.31.5.29",
//     "realName": "",
//     "accountType": 0,
//     "fullAddress": null,
//     "createTime": "2024-03-13 17:50:48",
//     "memberDays": 6,
//     "parentId": 0,
//     "parentName": null,
//     "areaCode": null
// },
//     "message": null
// }

class UserDetail {
  UserDetail(
      {this.id,
      this.username,
      this.usernameStatus,
      this.headImg,
      this.nickname,
      this.gender,
      this.birthDay,
      this.phoneNumber,
      this.registerIp,
      this.realName,
      this.email,
      this.accountType,
      this.fullAddress,
      this.createTime,
      this.memberDays,
      this.parentId,
      this.parentName,
      this.isRecharge,
      this.areaCode,
      this.credit});

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    // print("UserDetail--------$json");

    return UserDetail(
        id: asT<int>(json['id']),
        username: asT<String>(json['username']),
        usernameStatus: asT<int>(json['usernameStatus']),
        headImg: asT<String>(json['headImg']),
        nickname: asT<String>(json['nickname']),
        gender: asT<int>(json['gender']),
        birthDay: asT<String>(json['birthDay']),
        phoneNumber: asT<String>(json['phoneNumber']),
        registerIp: asT<String>(json['registerIp']),
        realName: asT<String>(json['realName']),
        accountType: asT<int>(json['accountType']),
        fullAddress: asT<String>(json['fullAddress']),
        createTime: asT<int>(json['createTime']),
        memberDays: asT<int>(json['memberDays']),
        parentId: asT<int>(json['parentId']),
        parentName: asT<String>(json['parentName']),
        areaCode: asT<String>(json['areaCode']),
        isRecharge: asT<int>(json['areaCode']),
        email: asT<String>(json['email']),
        credit: "");
  }

  int? id;
  String? username;
  int? usernameStatus;
  String? headImg;
  String? nickname;
  int? gender;
  String? birthDay;
  String? phoneNumber;
  String? registerIp;
  String? realName;
  String? email;
  int? accountType;
  String? fullAddress;
  int? createTime;
  int? memberDays;
  int? parentId;
  String? parentName;
  String? areaCode;
  String? credit;
  int? isRecharge;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'usernameStatus': usernameStatus,
        'headImg': headImg,
        'nickname': nickname,
        'gender': gender,
        'birthDay': birthDay,
        'phoneNumber': phoneNumber,
        'registerIp': registerIp,
        'realName': realName,
        'accountType': accountType,
        'fullAddress': fullAddress,
        'createTime': createTime,
        'memberDays': memberDays,
        'parentId': parentId,
        'email': email,
        'parentName': parentName,
        'areaCode': areaCode,
        'credit': credit,
        'isRecharge': isRecharge
      };
}

// {
//         "memberInfoIsFull": true,
//         "phoneIsBind": false,
//         "phoneNumber": "",
//         "isRealName": false,
//         "realName": "",
//         "mailIsBind": false,
//         "mail": "",
//         "withdrawAccountIsBind": true,
//         "transactionPasswordHasSet": true,
//         "modifyDefaultLoginPwd": true
//     }

class AccountState {
  AccountState({
    this.memberInfoIsFull,
    this.phoneIsBind,
    this.phoneNumber,
    this.isRealName,
    this.realName,
    this.mailIsBind,
    this.mail,
    this.withdrawAccountIsBind,
    this.transactionPasswordHasSet,
    this.modifyDefaultLoginPwd,
  });

  factory AccountState.fromJson(Map<String, dynamic> json) {
    return AccountState(
      memberInfoIsFull: asT<bool>(json['memberInfoIsFull']),
      phoneIsBind: asT<bool>(json['phoneIsBind']),
      phoneNumber: asT<String>(json['phoneNumber']),
      isRealName: asT<bool>(json['isRealName']),
      realName: asT<String>(json['realName']),
      mailIsBind: asT<bool>(json['mailIsBind']),
      mail: asT<String>(json['mail']),
      withdrawAccountIsBind: asT<bool>(json['withdrawAccountIsBind']),
      transactionPasswordHasSet: asT<bool>(json['transactionPasswordHasSet']),
      modifyDefaultLoginPwd: asT<bool>(json['modifyDefaultLoginPwd']),
    );
  }

  bool? memberInfoIsFull;
  bool? phoneIsBind;
  String? phoneNumber;
  bool? isRealName;
  String? realName;
  bool? mailIsBind;
  String? mail;
  bool? withdrawAccountIsBind;
  bool? transactionPasswordHasSet;
  bool? modifyDefaultLoginPwd;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'memberInfoIsFull': memberInfoIsFull,
        'phoneIsBind': phoneIsBind,
        'phoneNumber': phoneNumber,
        'isRealName': isRealName,
        'realName': realName,
        'mailIsBind': mailIsBind,
        'mail': mail,
        'withdrawAccountIsBind': withdrawAccountIsBind,
        'transactionPasswordHasSet': transactionPasswordHasSet,
        'modifyDefaultLoginPwd': modifyDefaultLoginPwd,
      };
}

class MemberBanksItem {
  MemberBanksItem({
    this.id,
    this.memberId,
    this.accountName,
    this.phoneNumber,
    this.bankName,
    this.bankCard,
    this.bankAddress,
    this.currency,
    this.status,
    this.createTime,
  });

  factory MemberBanksItem.fromJson(Map<String, dynamic> json) {
    return MemberBanksItem(
      id: asT<int?>(json['id']),
      memberId: asT<int?>(json['memberId']),
      accountName: asT<String?>(json['accountName']),
      phoneNumber: asT<String?>(json['phoneNumber']),
      bankName: asT<String?>(json['bankName']),
      bankCard: asT<String?>(json['bankCard']),
      bankAddress: asT<String?>(json['bankAddress']),
      currency: asT<String?>(json['currency']),
      status: asT<int?>(json['status']),
      createTime: asT<String?>(json['createTime']),
    );
  }

  int? id;
  int? memberId;
  String? accountName;
  String? phoneNumber;
  String? bankName;
  String? bankCard;
  String? bankAddress;
  String? currency;
  int? status;
  String? createTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'memberId': memberId,
        'accountName': accountName,
        'phoneNumber': phoneNumber,
        'bankName': bankName,
        'bankCard': bankCard,
        'bankAddress': bankAddress,
        'currency': currency,
        'status': status,
        'createTime': createTime,
      };
}
