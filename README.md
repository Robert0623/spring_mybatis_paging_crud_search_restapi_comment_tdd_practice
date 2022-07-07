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