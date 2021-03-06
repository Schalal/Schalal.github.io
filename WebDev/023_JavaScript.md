# JavaScript基础

## 参考书目

JSP Web应用开发（第2版），殷立峰等，2019年，清华大学出版社
ES6 标准入门（第3版），阮一峰，2017年9月，电子工业出版社

## 概述

JavaScript是一种基于对象（Object）的、事件驱动（Event Driven）的具有安全性能的解释性脚本语言，采用小程序段的方式进行编程。使用JavaScript语言编写的小程序段可以嵌入HTML网页文件中，由客户端的浏览器解释执行，不需要占用服务端的资源，不需要经过Web服务器即可对用户的操作做出相应，使网页更好地与用户交互，能适当地减小服务端的压力，减少用户等待的时间。

JavaScript也能够与服务器进行交互，功能也很强大，目前主流的AJAX也是依赖于JavaScript而存在的。

与此对应的是服务器语言，需要将命令上传至服务器，由服务器处理后回传处理结果，如ASP、ASP.NET、PHP、JSP等。

Java和JavaScipt的区别：

||Java|JavaScript|
|:----:|:----:|:----:|
|面向对象|完全面向对象|只是“基于对象”，本身提供了丰富的内部对象供设计人员使用|
|类型|编译型，必须经过编译器编译成字节码，然后由指定操作系统的JVM解释执行|解释型，浏览器解释执行|
|变量|强类型变量检查|弱类型，变量在使用前不需要声明数据类型，解释器在运行时检查其数据类型|
|代码格式|HTML无关，必须通过像HTML中引用外部媒体那样进行装载，代码以字节代码的形式独立地保存在单独的文档中|文本字符格式，可以直接嵌入HTML中，并且可以动态装载|
|嵌入标志|```<applet>...</applet>```|```<script>...</script>```|
|编译种类|静态联编，Java的对象引用必须在编译时进行，以使编译器能够实现强类型检查|动态联编，运行时才检查|

在JSP中使用JavaScript小程序：

+ 法1：直接嵌入
```JSP
<script language="JavaScript">
//JS小程序代码
</script>
```
+ 法2：引用外部JS文件
```JSP
<script language="JavaScript" src="javasc01.js">
//JS小程序代码
</script>
```

## JavaScript的数据类型、运算符

这里只挑一些比较特殊的：

+ 位运算符：>>>：填0右移
+ 