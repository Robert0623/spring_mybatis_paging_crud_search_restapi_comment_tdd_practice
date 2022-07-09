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

### ch4-5 - 게시판 읽기, 쓰기, 삭제, 수정 기능 구현 - 1
- BoardController 
1. @GetMapping("/list") - list, pageHandler, page, pageSize를 모델에 추가해서 boardList.jsp로 보냄.
2. @GetMapping("/read") - boardDto, page, pageSize를 모델에 추가해서 board.jsp로 보냄. 
3. @PostMapping("/remove") - page, pageSize를 모델에 추가해서 '/board/list'로 msg를 보내고 리다이렉트.  

- boardList.jsp 
1. title에 a태그를 추가하고, bno, page, pageSize를 EL로 URL재작성.
2. board.jsp에서 삭제버튼을 눌러서 삭제하면 Js로 메세지 출력.

- board.jsp
1. Js로 목록버튼을 누르면 page와 pageSize정보를 가지고 '/board/list', GET으로 컨트롤러로 가도록.
2. Js로 삭제버튼을 누르면 page와 pageSize정보를 가지고 '/board/remove', POST로 컨트롤러로 가도록.

### ch4-6 - 게시판 읽기, 쓰기, 삭제, 수정 기능 구현 - 2
- boardMapper.xml - update SQL문의 where 조건에 writer 추가
- boardList.jsp - 버튼태그 추가, write 할 때 msg 추가
- boardServiceImpl - write에 예외 발생시켜서 테스트
- board.jsp, BoardController - 삭제, 수정기능 구현

## 07.09
### ch4-7 - 게시판 검색 기능 추가하기 - 1
- pom.xml - gbee를 검색해서 log4jdbc를 추가
- log4dbc.log4j2.properties, logback.xml - log4jdbc를 사용하기 위한 설정파일 추가
- root-context.xml - log4jdbc를 사용하기위한 dataSource의 property태그 중 driverClassName, url 변경
- mybatis-config.xml - typeAlias에 SearchCondition 추가
- SerchCondition - 검색을 위해 domain에 생성(DTO)
- boardMapper.xml - 검색을 위해 searchSelectPage, searchResultCnt로 SQL문 추가
- BoardDao, BoardDaoImpl - DAO에 mapper.xml을 보고 searchSelectPage, searchResultCnt 추가
- BoardDaoImplTest - searchSelectPage, searchResultCnt 추가했으니 테스트코드로 테스트

### ch4-8 - 게시판 검색 기능 추가하기 - 2
- board.jsp, boardList.jsp - css 수정 및 ```<c:out>```태그로 보안 강화, core_rt, fmt_rt
- BoardController - list메서드에 SearchCondition을 이용하도록 수정
- SearchCondition - getQueryString메서드 추가
- PageHandler - SearchCondition을 이용하도록 수정
- PageHandlerTest - 주석처리
- BoardService, BoardServiceImpl - DAO를 보고 검색 관련 메서드 작성
- BoardServiceImplTest - 추가한 검색 관련 메서드 테스트
- boardMapper.xml - 검색 option 추가
- BoardDaoImplTest - 검색 option 별 테스트 추가