<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fastcampus</title>
  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: "Noto Sans KR", sans-serif;
    }
    .container {
      width : 50%;
      margin : auto;
    }
    .writing-header {
      position: relative;
      margin: 20px 0 0 0;
      padding-bottom: 10px;
      border-bottom: 1px solid #323232;
    }
    input {
      width: 100%;
      height: 35px;
      margin: 5px 0px 10px 0px;
      border: 1px solid #e9e8e8;
      padding: 8px;
      background: #f8f8f8;
      outline-color: #e6e6e6;
    }
    textarea {
      width: 100%;
      background: #f8f8f8;
      margin: 5px 0px 10px 0px;
      border: 1px solid #e9e8e8;
      resize: none;
      padding: 8px;
      outline-color: #e6e6e6;
    }
    .frm {
      width:100%;
    }
    .btn {
      background-color: rgb(236, 236, 236); /* Blue background */
      border: none; /* Remove borders */
      color: black; /* White text */
      padding: 6px 12px; /* Some padding */
      font-size: 16px; /* Set a font size */
      cursor: pointer; /* Mouse pointer on hover */
      border-radius: 5px;
    }
    .btn:hover {
      text-decoration: underline;
    }

    .comment_area {
      width: 50%;
      height: 500px;
      margin: auto;
      /*background-color: green;*/
    }
    .comment_area > input {
      background-color: #f8f8f8;
      outline-color: #e6e6e6;
    }
    #modBtn, #sendBtn {
      background-color: rgb(236, 236, 236); /* Blue background */
      border: none; /* Remove borders */
      color: black; /* White text */
      padding: 6px 12px; /* Some padding */
      font-size: 16px; /* Set a font size */
      cursor: pointer; /* Mouse pointer on hover */
      border-radius: 5px;
    }
    #commentList {
      margin: auto;
      width: 100%;
      height: 500px;
    }
    .commenter {
      font-weight: bold;
      font-size: 20px;
    }
    .comment {
      background-color: #f8f8f8;
      outline-color: #e6e6e6;
      height: 40px;
      line-height: 40px;
      border: 1px solid #e9e8e8;
    }
    .delBtn, .modBtn, .replyBtn, #wrtRepBtn {
      margin-right: 10px;
      font-size:10pt;
      color : black;
      background-color: #eff0f2;
      text-decoration: none;
      padding : 5px 10px 5px 10px;
      border-radius: 5px;
      cursor: pointer;
    }
    .delBtn {
      margin-left: 10px;
    }

  </style>
</head>
<body>
<div id="menu">
  <ul>
    <li id="logo">fastcampus</li>
    <li><a href="<c:url value='/'/>">Home</a></li>
    <li><a href="<c:url value='/board/list'/>">Board</a></li>
    <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
    <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
    <li><a href=""><i class="fa fa-search"></i></a></li>
  </ul>
</div>
</div>
<script>
  let msg = "${msg}";
  if(msg=="WRT_ERR") alert("????????? ????????? ?????????????????????. ?????? ????????? ?????????.");
  if(msg=="MOD_ERR") alert("????????? ????????? ?????????????????????. ?????? ????????? ?????????.");
</script>
<div class="container">
  <h2 class="writing-header">????????? ${mode=="new" ? "?????????" : "??????"}</h2>
  <form id="form" class="frm" action="" method="post">
    <input type="hidden" name="bno" value="${boardDto.bno}">

    <input name="title" type="text" value="<c:out value='${boardDto.title}'/>" placeholder="  ????????? ????????? ?????????." ${mode=="new" ? "" : "readonly='readonly'"}><br>
    <textarea name="content" rows="20" placeholder=" ????????? ????????? ?????????." ${mode=="new" ? "" : "readonly='readonly'"}><c:out value="${boardDto.content}"/></textarea><br>

    <c:if test="${mode eq 'new'}">
      <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> ??????</button>
    </c:if>
    <c:if test="${mode ne 'new'}">
      <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> ?????????</button>
    </c:if>
    <c:if test="${boardDto.writer eq loginId}">
      <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> ??????</button>
      <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> ??????</button>
    </c:if>
    <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> ??????</button>
  </form>
</div>
<script>
  $(document).ready(function(){
    let formCheck = function() {
      let form = document.getElementById("form");
      if(form.title.value=="") {
        alert("????????? ????????? ?????????.");
        form.title.focus();
        return false;
      }
      if(form.content.value=="") {
        alert("????????? ????????? ?????????.");
        form.content.focus();
        return false;
      }
      return true;
    }
    $("#writeNewBtn").on("click", function(){
      location.href="<c:url value='/board/write'/>";
    });
    $("#writeBtn").on("click", function(){
      let form = $("#form");
      form.attr("action", "<c:url value='/board/write'/>");
      form.attr("method", "post");
      if(formCheck())
        form.submit();
    });
    $("#modifyBtn").on("click", function(){
      let form = $("#form");
      let isReadonly = $("input[name=title]").attr('readonly');
      // 1. ?????? ????????????, ?????? ????????? ??????
      if(isReadonly=='readonly') {
        $(".writing-header").html("????????? ??????");
        $("input[name=title]").attr('readonly', false);
        $("textarea").attr('readonly', false);
        $("#modifyBtn").html("<i class='fa fa-pencil'></i> ??????");
        return;
      }
      // 2. ?????? ????????????, ????????? ????????? ????????? ??????
      form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
      form.attr("method", "post");
      if(formCheck())
        form.submit();
    });
    $("#removeBtn").on("click", function(){
      if(!confirm("????????? ?????????????????????????")) return;
      let form = $("#form");
      form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
      form.attr("method", "post");
      form.submit();
    });
    $("#listBtn").on("click", function(){
      location.href="<c:url value='/board/list${searchCondition.queryString}'/>";
    });
  }); //ready??? ???
</script>

<%--?????? html--%>
<div class="comment_area">
comment: <input type="text" name="comment" placeholder="????????? ???????????????"><br>
<button id="sendBtn" type="button">????????????</button>
<button id="modBtn" type="button">????????????</button>
<div id="commentList"></div>
<div id="replyForm" style="display:none">
  <input type="text" name="replyComment">
  <button id="wrtRepBtn" type="button">??????</button>
</div>
</div>

<script>
  let bno = "<c:out value='${boardDto.bno}'/>";

  let showList = function(bno) {
    $.ajax({
      type:'GET',       // ?????? ?????????
      url: '/ch4/comments?bno='+bno,  // ?????? URI
      success : function(result){
        $("#commentList").html(toHtml(result));    // ??????????????? ????????? ???????????? ????????? ??????
      },
      error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
    }); // $.ajax()
  }

  $(document).ready(function(){
    //  ?????? ?????? scipt ??????
    showList(bno);

    $("#modBtn").click(function(){
      let cno = $(this).attr("data-cno");
      let comment = $("input[name=comment]").val();

      if(comment.trim()=='') {
        alert("????????? ??????????????????.");
        $("input[name=comment]").focus()
        return;
      }

      $.ajax({
        type:'PATCH',       // ?????? ?????????
        url: '/ch4/comments/'+cno,  // ?????? URI // /ch4/comments/70 PATCH
        headers : { "content-type": "application/json"}, // ?????? ??????
        data : JSON.stringify({cno:cno, comment:comment}),  // ????????? ????????? ?????????. stringify()??? ????????? ??????.
        success : function(result){
          alert(result);
          showList(bno);
        },
        error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
      }); // $.ajax()
    });

    $("#wrtRepBtn").click(function(){
      let comment = $("input[name=replyComment]").val();
      let pcno = $("#replyForm").parent().attr("data-pcno");

      if(comment.trim()=='') {
        alert("????????? ??????????????????.");
        $("input[name=comment]").focus()
        return;
      }

      $.ajax({
        type:'POST',       // ?????? ?????????
        url: '/ch4/comments?bno='+bno,  // ?????? URI // /ch4/comments?bno=1085 POST
        headers : { "content-type": "application/json"}, // ?????? ??????
        data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // ????????? ????????? ?????????. stringify()??? ????????? ??????.
        success : function(result){
          alert(result);
          showList(bno);
        },
        error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
      }); // $.ajax()

      $("#replyForm").css("display", "none")
      $("input[name=replyComment]").val('')
      $("#replyForm").appendTo("body");
    });

    $("#sendBtn").click(function(){
      let comment = $("input[name=comment]").val();

      if(comment.trim()=='') {
        alert("????????? ??????????????????.");
        $("input[name=comment]").focus()
        return;
      }

      $.ajax({
        type:'POST',       // ?????? ?????????
        url: '/ch4/comments?bno='+bno,  // ?????? URI // /ch4/comments?bno=1085 POST
        headers : { "content-type": "application/json"}, // ?????? ??????
        data : JSON.stringify({bno:bno, comment:comment}),  // ????????? ????????? ?????????. stringify()??? ????????? ??????.
        success : function(result){
          alert(result);
          showList(bno);
        },
        error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
      }); // $.ajax()
    });

    $("#commentList").on("click", ".modBtn", function() {
      let cno = $(this).parent().attr("data-cno");
      let comment = $("div.comment", $(this).parent()).text();

      //1. comment??? ????????? input??? ????????????
      $("input[name=comment]").val(comment);
      //2. cno ????????????
      $("#modBtn").attr("data-cno", cno);
    });

    $("#commentList").on("click", ".replyBtn", function(){
      //1. replyForm??? ?????????
      $("#replyForm").appendTo($(this).parent());

      // 2. ????????? ????????? ?????? ????????????,
      $("#replyForm").css("display", "block");
    });

    // $(".delBtn").click(function(){
    $("#commentList").on("click", ".delBtn", function(){
      let cno = $(this).parent().attr("data-cno");
      let bno = $(this).parent().attr("data-bno");

      $.ajax({
        type:'DELETE',
        url: '/ch4/comments/'+cno+'?bno='+bno,  // ?????? URI
        success : function(result){
          alert(result)
          showList(bno);
        },
        error   : function(){ alert("error") } // ????????? ???????????? ???, ????????? ??????
      }); // $.ajax()
    });//end ??????script
  });

  //?????? script2 ??????
  let toHtml = function(comments) {
    let addZero = function(value=1){
      return value > 9 ? value : "0"+value;
    }

    let dateToString = function(ms=0) {
      let date = new Date(ms);

      let yyyy = date.getFullYear();
      let mm = addZero(date.getMonth() + 1);
      let dd = addZero(date.getDate());

      let HH = addZero(date.getHours());
      let MM = addZero(date.getMinutes());
      let ss = addZero(date.getSeconds());

      return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;
    }


    let tmp = "<div>";

    comments.forEach(function(comment){
      tmp += '<div data-cno='+comment.cno
      tmp += ' data-pcno='+comment.pcno
      tmp += ' data-bno='+comment.bno + '>'
      if(comment.cno!=comment.pcno)
        tmp += '???'
      tmp += ' <span class="commenter">' + comment.commenter + '</span>'
      tmp += ' <div class="comment">' + comment.comment + '</div>'
      tmp += dateToString(comment.up_date)
      tmp += '<button class="delBtn">??????</button>'
      tmp += '<button class="modBtn">??????</button>'
      tmp += '<button class="replyBtn">??????</button>'
      tmp += '</div>'
    })

    return tmp + "</div>";
  } //?????? script2 ???
</script>
</body>
</html>