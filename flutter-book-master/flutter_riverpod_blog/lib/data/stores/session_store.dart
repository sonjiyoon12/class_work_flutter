import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/dtos/user_request.dart';
import 'package:flutter_blog/data/models/user.dart';
import 'package:flutter_blog/data/repositories/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 1. 창고 관리자
final sessionProvider = Provider<SessionStore>((ref) {
  return SessionStore();
});

// 2. 창고 데이터
class SessionUser {
  User? user;
  String? jwt;
  bool? isLogin;

  SessionUser();
}

// 3. 창고
class SessionStore extends SessionUser {
  final mContext = navigatorKey.currentContext;

  // 로그인
  Future<void> login(LoginReqDTO loginReqDTO) async {
    Logger().d("login");

    // 1. Repository 메소드를 호출하여 응답 결과 및 데이터 받음.
    ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);

    // 응답 결과 값이 1일 경우
    if (responseDTO.code == 1) {
      // 2. 토큰을 휴대폰에 저장
      await secureStorage.write(key: "jwt", value: responseDTO.token);

      // 3. 로그인 상태 등록
      this.user = responseDTO.data;
      this.jwt = responseDTO.token!;
      this.isLogin = true;

      // 4. 페이지 이동
      Navigator.popAndPushNamed(mContext!, Move.postListPage);
    } else {
      // 실패 시 스낵바
      ScaffoldMessenger.of(mContext!)
          .showSnackBar(SnackBar(content: Text("로그인 실패 : ${responseDTO.msg}")));
    }
  }

  // 회원 가입
  Future<void> join(JoinReqDTO reqDTO) async {
    Logger().d("join");

    // 1. Repository 메소드를 호출하여 응답 결과 및 데이터 받음.
    ResponseDTO responseDTO = await UserRepository().fetchJoin(reqDTO);

    // 응답 결과 값이 1일 경우
    if (responseDTO.code == 1) {
      // 2. 페이지 이동
      Navigator.pushNamed(mContext!, Move.loginPage);
    } else {
      // 실패 시 스낵바
      ScaffoldMessenger.of(mContext!)
          .showSnackBar(SnackBar(content: Text("회원가입 실패")));
    }
  }

  // 로그아웃
  Future<void> logout() async {
    this.user = null;
    this.jwt = null;
    this.isLogin = false;
    await secureStorage.delete(key: "jwt");
    Logger().d("세션 종료 및 디바이스 JWT 삭제");
  }
}
