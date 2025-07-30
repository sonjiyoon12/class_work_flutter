void main() {
  // 서버에서 받는 JSON 응답 형태는 크게 2가지 타입으로 나뉩니다.

  // 1. JSON Object Type - 단일 객체
  String jsonStr1 = '''
    { 
        "UserId" : 1,
        "title" : "my Title",
        "completed" : true 
    }
    ''';

  // 2. JSON Array Type - 객체들의 배열
  String jsonStr2 = '''
    [
      { 
          "UserId" : 1,
          "title" : "my Title",
          "completed" : true 
      },
      {
       
          "UserId" : 1,
          "title" : "my Title",
          "completed" : true 
      }
    ]
    ''';

  // HTTP 응답 구조
  // http.Response
  // ---- statusCode (int)
  // ---- header (Map<String, String>)
  // ---- body (String) --> JSON 형식의 문자열 데이터
}
