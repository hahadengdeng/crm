<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<!--Author: W3layouts
Author URL: http://w3l3ayouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE HTML>
<html lang="zxx">

<head>
	<title>Validate Login & Register Forms Flat Responsive Widget Template :: w3layouts</title>
	<!-- Meta tag Keywords -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="UTF-8" />
	<meta name="keywords" content="Validate Login & Register Forms Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
	<script>
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}

		if (top.location!=self.location){
			top.location="login.action";
		}
	</script>
	<!-- Meta tag Keywords -->

	<!-- css files -->
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<!-- Style-CSS -->
	<link href="css/font-awesome.min.css" rel="stylesheet">
	<!-- Font-Awesome-Icons-CSS -->
	<!-- //css files -->
	<!-- web-fonts -->
	<link href="//fonts.googleapis.com/css?family=Magra:400,700&amp;subset=latin-ext" rel="stylesheet">
	<!-- //web-fonts -->
</head>

<body>
<!-- title -->

<!-- //title -->

<!-- content -->
<div class="container-agille">
	<div class="formBox level-login">
		<div class="box boxShaddow"></div>
		<div class="box loginBox">
			<h3>Login Here</h3>
			<form class="form" action="${pageContext.request.contextPath}/login.action" method="post" >
				<div class="f_row-2">
					<input type="text" class="input-field" placeholder="Username" name="username" required>
				</div>
				<div class="f_row-2 ">
					<input type="password" name="password" placeholder="Password" class="input-field" required>
				</div>
				<div class="f_row-2 last">
					<input type="checkbox" name="remember" /> remember me  ?
 				</div>
				<input class="submit-w3" type="submit" value="Login">

			</form>
		</div>
		<div class="box forgetbox agile">
			<a href="#" class="back icon-back">
				<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
					 viewBox="0 0 199.404 199.404" style="enable-background:new 0 0 199.404 199.404;" xml:space="preserve">
						<polygon points="199.404,81.529 74.742,81.529 127.987,28.285 99.701,0 0,99.702 99.701,199.404 127.987,171.119 74.742,117.876
			  199.404,117.876 " />
					</svg>
			</a>
			<h3>Reset Password</h3>
			<form class="form" action="#" method="post">
				<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.</p>
				<div class="f_row last">
					<label>Email Id</label>
					<input type="email" name="email" placeholder="Email" class="input-field" required>
					<u></u>
				</div>
				<button class="btn button submit-w3">
					<span>Reset</span>
				</button>
			</form>
		</div>
		<div class="box registerBox wthree">
			<span class="reg_bg"></span>
			<h3>Register</h3>
			<form class="form" action="${pageContext.request.contextPath}/register.action" method="post" id="registerForm">
				<div class="f_row-2">
					<input type="text" class="input-field" placeholder="Username" name="username" id="username" required>
				</div>
				<div class="f_row-2 last">
					<input type="password" name="password" placeholder="Password" id="password" class="input-field" required>
				</div>
				<div class="f_row-3 last">
					<input type="password" name="password2" placeholder="Confirm Password" id="password2" class="input-field" required>
				</div>
				<div class="f_row-4 last">
					<input type="text" name="tel" placeholder="tel" id="tel" class="input-field" required>
				</div>
				<div class="f_row-5 last">
					<input type="text" name="name" placeholder="name" id="name" class="input-field" required>
				</div>
				<div class="f_row-6 last">
					<input type="text" name="email" placeholder="email" id="email" class="input-field">
				</div>
				<div class="f_row-7 last" hidden>
					<select id="dept" name="dept.deptid" style="width:100%;height: 53px" required>
						<option value="2">commissioner</option>
					</select>
				</div>
				<input class="submit-w3" type="submit" value="Register">
			</form>
		</div>
		<a href="#" class="regTag icon-add">
			<i class="fa fa-repeat" aria-hidden="true"></i>

		</a>
	</div>
</div>
<!-- //content -->


<!-- js files -->
<!-- Jquery -->
<script src="javascript/jquery-2.2.3.min.js"></script>
<!-- //Jquery -->
<!-- input fields js -->
<script src="javascript/input-field.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<%--<script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>--%>

<!-- //input fields js -->
<style>
	.error{
		color:red;
	}
</style>
<!-- password-script -->
<script>

	$.validator.setDefaults({
		submitHandler: function(form) {

			form.submit();
		}
	});

	$().ready(function() {
		$("#registerForm").validate({
			rules: {
				username: {
					required:true,
					remote:{
						url:"${pageContext.request.contextPath}/checkLoginName.action",
						type:"post",
						data:{
							username:function () {
								return $("#username").val();
							}
						}
					}
				},
				password: "required",
				password2:{
					required: true,
					equalTo:"#password"
				},

				tel: {
					required: true,
					tel:true
				},
				name: {
					required: true,
					minlength: 2,
				},
				email: {
					email: true
				}
			},
			messages: {
				username: {
					required:"请注册您的登录名",
					remote:"用户名已存在"
				},
				password: {
					required: "请输入密码",
				},
				password2: {
					required: "请输入密码",
					equalTo: "两次密码输入不一致"
				},
				tel: {
					required: "请输入电话号码",
					tel: "电话号码格式不正确"
				},
				name:{
					required:"请输入您的真实姓名",
					minlength:"名字的长度必须大于2"
				},
				email:{
					email:"请输入正确的邮箱"
				}
			}
		});
	});
</script>
<!-- //password-script -->
<!-- //js files -->


</body>

</html>