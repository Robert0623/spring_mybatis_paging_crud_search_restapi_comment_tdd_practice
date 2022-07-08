# 스프링 MyBatis, 페이징, CRUD, 검색기능, REST API, Ajax, 댓글 기능 구현 복습 및 훈련

## 07.07
### ch4-1 - MyBatis의 소개와 설정
- web.xml - 한글 변환 필터 추가
- root-context.xml - MySQL Jdbc 드라이버, TxManager, sqlSessionFactory, sqlSession, component-scan bean으로 추가
- servlet-context.xml - view-controller bean으로 추가
- pom.xml - 3장의 설정파일 + mybatis, mybatis-spring 추가
- mybatis-config.xml - mybatis 설정파일, typeAliases
- home.jsp, HomeController - 삭제 
- index.jsp, loginForm.jsp, menu.css, LoginController, User, UserDao, UserDaoImpl - 3장과 동일

### ch4-2 - MyBatis로 DAO 작성하기
- root-context.xml - mapperLocations태그 주석을 품
- mybatis-config.xml - typeAlias태그 주석을 품
- boardMapper.xml - mapper 작성
- BoardDto - DTO 작성
- BoardDao - BoardDaoImpl을 extract interface로 작성
- BoardDaoImpl - SqlSession을 주입받아서, boardMapper를 보고 작성
- BoardDaoImplTest - BoardDao의 select 메서드 테스트

### ch4-3 - 게시판 목록 만들기와 페이징 - TDD - 1
- PageHandler - 게시판 페이지 만들기
- PageHandlerTest - 게시판 페이지 테스트

## 07.08
### ch4-4 - 게시판 목록 만들기와 페이징 - TDD - 2
- PageHandler - beginPage 수정, iv 접근제어자 수정, getter & setter 생성
- PageHandlerTest - page가 10일 때 beginPage가 1이 아닌 11이 나오는 오류 발생. 수정 후 테스트 코드로 확인.
- UserDaoImpl - spring-jdbc 사용 코드. ResultSet을 try-with-resources문에 넣어놔서 autoclose로 인한 오류 발생. setString을 호출한 뒤에 ResultSet을 넣어서 해결. 
- BoardDto - 실수로 생성자 매개변수에 writer 대신 bno를 넣음. bno를 writer로 수정.
- boardMapper.xml - 관리자 권한 삭제 SQL문 추가
- boardDao, boardDaoImpl - boardMapper.xml를 보고 추가 작성.
- boardDaoImplTest - 게시판 목록과 페이지 확인을 위한 더미데이터 추가, boardDao의 CRUD메서드 테스트
- BoardService, BoardServiceImpl - BoardDao를 보고 작성.
- BoardController - @GetMapping에 getPage를 list로 모델에 저장. page, pageSize를 매개변수로 받아서, offset과 pageSize를 모델에 저장. 
- boardList.jsp - 반복문으로 게시판 목록, 페이지 화면 추가