# Java基础

## 参考资源

+ JSP Web应用开发（第2版），殷立峰等，2019年，清华大学出版社
+ [W3CSchoolJava教程](https://www.w3cschool.cn/java/java-tutorial.html)

## 概述

Java 是由Sun Microsystems公司于1995年5月推出的高级程序设计语言，可运行于多个平台，如Windows, MacOS，及UNIX等版本的系统。

其主要特性有：

主要特性

+ 语法简单：Java语言的语法与C语言和C++语言很接近。另一方面，Java丢弃了C++中很难理解的特性，如操作符重载、多继承、自动的强制类型转换。特别地，Java语言不使用指针，而是引用。并提供了自动的内存管理。

+ 面向对象：Java语言提供类、接口和继承等原语，为了简单起见，只支持类之间的单继承，但支持接口之间的多继承，并支持类与接口之间的实现机制（关键字为implements）。Java语言全面支持动态绑定，而C++语言只对虚函数使用动态绑定。总之，Java语言是一个纯的面向对象程序设计语言。

+ 分布式：Java语言支持Internet应用的开发，在基本的Java应用编程接口中有一个网络应用编程接口（java net），它提供了用于网络应用编程的类库，包括URL、URLConnection、Socket、ServerSocket等。Java的RMI（远程方法激活）机制也是开发分布式应用的重要手段。

+ 健壮：Java的强类型机制、异常处理、垃圾的自动收集等是Java程序健壮性的重要保证。对指针的丢弃是Java的明智选择。Java的安全检查机制使得Java更具健壮性。

+ 安全：Java通常被用在网络环境中，为此，Java提供了一个安全机制以防恶意代码的攻击。除了Java语言具有的许多安全特性以外，Java对通过网络下载的类具有一个安全防范机制（类ClassLoader），如分配不同的名字空间以防替代本地的同名类、字节代码检查，并提供安全管理机制（类SecurityManager）。

+ 体系结构中立：Java程序（后缀为java的文件）在Java平台上被编译为体系结构中立的字节码格式（后缀为class的文件），然后可以在实现这个Java平台的任何系统中运行（**注意，不是编译成exe，而是编译成字节码**）。这种途径适合于异构的网络环境和软件的分发。

+ 可移植：可移植性来源于体系结构中立性，另外，Java还严格规定了各个基本数据类型的长度。Java系统本身也具有很强的可移植性，Java编译器是用Java实现的，Java的运行环境是用ANSI C实现的。

+ 解释型：如前所述，Java程序在Java平台上被编译为字节码格式，然后可以在实现这个Java平台的任何系统中运行。在运行时，Java平台中的Java解释器对这些字节码进行解释执行，执行过程中需要的类在联接阶段被载入到运行环境中。

+ 高性能：与那些解释型的高级脚本语言相比，Java的确是高性能的。事实上，Java的运行速度随着JIT(Just-In-Time）编译器技术的发展越来越接近于C++。

+ 多线程：在Java语言中，线程是一种特殊的对象，它必须由Thread类或其子（孙）类来创建。通常有两种方法来创建线程：其一，使用型构为Thread(Runnable)的构造子将一个实现了Runnable接口的对象包装成一个线程，其二，从Thread类派生出子类并重写run方法，使用该子类创建的对象即为线程。值得注意的是Thread类已经实现了Runnable接口，因此，任何一个线程均有它的run方法，而run方法中包含了线程所要运行的代码。线程的活动由一组方法来控制。Java语言支持多个线程的同时执行，并提供多线程之间的同步机制（关键字为synchronized）。

+ 动态：Java语言的设计目标之一是适应于动态变化的环境。Java程序需要的类能够动态地被载入到运行环境，也可以通过网络来载入所需要的类。这也有利于软件的升级。另外，Java中的类有一个运行时刻的表示，能进行运行时刻的类型检查。

基本语法
+ 大小写敏感：Java是大小写敏感的，这就意味着标识符Hello与hello是不同的。
+ 类名：对于所有的类来说，类名的首字母应该大写。如果类名由若干单词组成，那么每个单词的首字母应该大写。
+ 方法名：所有的方法名都应该以小写字母开头。如果方法名含有若干单词，则后面的每个单词首字母大写。
+ 源文件名：源文件名必须和类名相同。当保存文件的时候，你应该使用类名作为文件名保存（切记Java是大小写敏感的），文件名的后缀为.java。（如果文件名和类名不相同则会导致编译错误）。
+ 主方法入口：所有的Java 程序```由public static void main(String[] args)```方法开始执行。

Java修饰符
+ 访问控制修饰符 : default, public , protected, private（与C++一致）
+ 非访问控制修饰符 : final, abstract, static，synchronized 和 volatile
  + static：声明静态变量/静态方法（静态方法不能使用类的非静态变量。静态方法从参数列表得到数据，然后计算这些数据。）
  + final：final 变量能被显式地初始化并且只能初始化一次。被声明为final的对象的引用不能指向不同的对象。但是 final 对象里的数据可以被改变。也就是说 final 对象的引用不能改变，但是里面的值可以改变。final 修饰符通常和 static 修饰符一起使用来创建类常量。
  + abstarct: 抽象类不能用来实例化对象，声明抽象类的唯一目的是为了将来对该类进行扩充。一个类不能同时被 abstract 和 final 修饰。如果一个类包含抽象方法，那么该类一定要声明为抽象类，否则将出现编译错误。
  + synchronized: synchronized 关键字声明的方法同一时间只能被一个线程访问。Synchronized 修饰符可以应用于四个访问修饰符。
  + transient: 序列化的对象包含被 transient 修饰的实例变量时，java 虚拟机 (JVM) 跳过该特定的变量。该修饰符包含在定义变量的语句中，用来预处理类和变量的数据类型。
  + volatile: volatile 修饰的成员变量在每次被线程访问时，都强迫从共享内存中重读该成员变量的值。而且，当成员变量发生变化时，强迫线程将变化值回写到共享内存。这样在任何时刻，两个不同的线程总是看到某个成员变量的同一个值。

## Java的对象和类

类中的类型变量：（与C++一致）
+ 局部变量：在方法、构造方法或者语句块中定义的变量被称为局部变量。变量声明和初始化都是在方法中，方法结束后，变量就会自动销毁。
+ 类变量（静态变量）：类变量也声明在类中、方法体之外，但必须声明为 static 类型(与C++的静态成员含义一致)。
  + 静态变量可以通过：ClassName.VariableName 的方式访问
  + 静态变量在程序开始时创建，在程序结束时销毁
  + 静态变量被声明为 public static final 类型时，名称必须使用大写字母
+ 成员变量（非静态变量）：成员变量是定义在类中，方法体之外的变量。这种变量在创建对象的时候实例化。成员变量可以被类中方法、构造方法和特定类的语句块访问。

构造方法：与类名一致，可以声明多个，如：

```Java
public class Puppy{
   int puppyAge;
   public Puppy(String name){
      // 这个构造器仅有一个参数：name
      System.out.println("Passed Name is :" + name ); 
   }

   public void setAge( int age ){
       puppyAge = age;
   }

   public int getAge( ){
       System.out.println("Puppy's age is :" + puppyAge ); 
       return puppyAge;
   }

   public static void main(String []args){
      /* 创建对象 */
      Puppy myPuppy = new Puppy( "tommy" );
      /* 通过方法来设定age */
      myPuppy.setAge( 2 );
      /* 调用另一个方法获取age */
      myPuppy.getAge( );
      /*你也可以像下面这样访问成员变量 */
      System.out.println("Variable Value :" + myPuppy.puppyAge ); 
   }
}
```

继承：extends关键字，**Java 只支持单继承，也就是说，一个类不能继承多个类**，e.g.

```Java
// A.java
public class A {
    private int i;
    protected int j;
    public void func() {
    }
}
// B.java
public class B extends A {
    public int z;
    public void fund(){
    }
}
```

Java中的重写（Override）和重载（Overload）是两个不同的概念。

重写是**子类对父类**的允许访问的方法的实现过程进行重新编写，**返回值和形参都不能改变**，其好处在于子类可以根据需要，定义特定于自己的行为。当需要在子类中调用父类的被重写方法时，要使用 super 关键字。

重载是在**一个类**里面，**方法名字相同，而参数不同**。返回类型可以相同也可以不同。每个重载的方法（或者构造函数）都必须有一个独一无二的参数类型列表。最常用的地方就是构造器的重载。

Java中同样有抽象类和抽象方法的概念，与C++中抽象类和纯虚函数的概念一致，即：抽象类除了不能实例化对象之外，类的其它功能依然存在，成员变量、成员方法和构造方法的访问方式和普通类一样。由于抽象类不能实例化对象，所以抽象类必须被继承，才能被使用。声明抽象方法会造成以下两个结果：如果一个类包含抽象方法，那么该类必须是抽象类。任何子类必须重写父类的抽象方法，或者声明自身为抽象类。

源文件命名规则：
当在一个源文件中定义多个类，并且还有​import​语句和​package​ 语句时，要特别注意这些规则。

+ 一个源文件中只能有一个 ​public​ 类
+ 一个源文件可以有多个非​public​类
+ 源文件的名称应该和​public​类的类名保持一致。例如：源文件中​public​类的类名是​Employee​，那么源文件应该命名为​Employee.java​。
+ 如果一个类定义在某个包（包主要用来对类和接口进行分类。当开发 Java 程序时，可能编写成百上千的类，因此很有必要对类和接口进行分类。）中，那么​package​语句应该在源文件的首行。
+ 如果源文件包含​import​语句（在 Java 中，如果给出一个完整的限定名，包括包名、类名，那么 Java 编译器就可以很容易地定位到源代码或者类。​Import​ 语句就是用来提供一个合理的路径，使得编译器可以找到某个类），那么应该放在​package​语句和类定义之间。如果没有​package​语句，那么​import​语句应该在源文件中最前面。
​+ import​语句和​package​语句对源文件中定义的所有类都有效。在同一源文件中，不能给不同的类不同的包声明。
+ 类有若干种访问级别，并且类也分不同的类型：抽象类和​final​类等。这些将在访问控制章节介绍。
+ 除了上面提到的几种类型，Java 还有一些特殊的类，如：内部类、匿名类。

```import```示例：

```Java
//文件一，Employee.java
import java.io.*;
public class Employee{
   String name;
   int age;
   String designation;
   double salary;
   // Employee 类的构造器
   public Employee(String name){
      this.name = name;
   }
   // 设置age的值
   public void empAge(int empAge){
      age =  empAge;
   }
   /* 设置designation的值*/
   public void empDesignation(String empDesig){
      designation = empDesig;
   }
   /* 设置salary的值*/
   public void empSalary(double empSalary){
      salary = empSalary;
   }
   /* 打印信息 */
   public void printEmployee(){
      System.out.println("Name:"+ name );
      System.out.println("Age:" + age );
      System.out.println("Designation:" + designation );
      System.out.println("Salary:" + salary);
   }
}
//文件二，EmployeeTest.java
//程序都是从 ​main​方法开始执行。为了能运行这个程序，必须包含 ​main​ 方法并且创建一个实例对象。
import java.io.*;
public class EmployeeTest{

   public static void main(String args[]){
      /* 使用构造器创建两个对象 */
      Employee empOne = new Employee("James Smith");
      Employee empTwo = new Employee("Mary Anne");

      // 调用这两个对象的成员方法
      empOne.empAge(26);
      empOne.empDesignation("Senior Software Engineer");
      empOne.empSalary(1000);
      empOne.printEmployee();

      empTwo.empAge(21);
      empTwo.empDesignation("Software Engineer");
      empTwo.empSalary(500);
      empTwo.printEmployee();
   }
}

```

## 数据类型

Java语言提供了八种基本类型。六种数字类型（四个整数型（byte, short, long, int），两个浮点型（float, double）），一种字符类型（char），还有布尔型（boolean）。

引用类型变量由类的构造函数创建，可以使用它们访问所引用的对象。这些变量在声明时被指定为一个特定的类型，比如Employee、Pubby等。变量一旦声明后，类型就不能被改变了。对象、数组都是引用数据类型。所有引用类型的默认值都是null。

常量：以final关键字标识，如```final double PI=3.1415926```

## 数据运算

（只挑需要注意的）

（假设A=60（00111100），B=13（00001101））
|操作符|描述|例子|
|:----:|:----:|:----:|
|＆|按位与操作符，当且仅当两个操作数的某一位都非0时候结果的该位才为1。|（A＆B），得到12，即0000 1100|
|\||按位或操作符，只要两个操作数的某一位有一个非0时候结果的该位就为1。|	（A\|B）得到61，即 0011 1101|
|^|按位异或操作符，两个操作数的某一位不相同时候结果的该位就为1。|（A^B）得到49，即 0011 0001|
|~|按位补运算符翻转操作数的每一位。|（~A）得到-61，即1100 0011|
|<< |按位左移运算符。左操作数按位左移右操作数指定的位数。|A << 2得到240，即 1111 0000|
|>> |按位右移运算符。左操作数按位右移右操作数指定的位数。|A >> 2得到15即 1111|
|>>> |按位右移补零操作符。左操作数的值按右操作数指定的位数右移，移动得到的空位以零填充。|A>>>2得到15即0000 1111|

也支持三元运算符（?:）、+=这种赋值运算符，还有一个instanceof运算符（该运算符用于操作对象实例，检查该对象是否是一个特定类型（类类型或接口类型），如```boolean x=y instanceof z```）

## 循环与条件语句

除了一般的与C/C++完全一致的三种循环体（while、do...while和for）外，还有一种主要用于数组的循环体（称为for...each循环）：
```Java
for(type element: array)
{
   //代码句子
}
```

if...else的语句用法与C/C++也是完全一致的，支持switch...case语句，也与C/C++也是完全一致。

## 基本类

+ Number类：一般情况下我们会使用数据的基本数据类型：byte、int、short、long、double、float、boolean、char；对应的封装类型也有八种：Byte、Integer、Short、Long、Double、Float、Character、Boolean；Number 类是 java.lang 包下的一个抽象类，**封装类型都是用 final 声明了，不可以被继承重写**；在实际情况中编译器会自动的将基本数据类型装箱成对象类型，或者将对象类型拆箱成基本数据类型。
+ Math类
+ Character类
+ String类
+ StringBuffer和StringBuilder类：当对字符串进行修改的时候，需要使用 StringBuffer 和 StringBuilder 类。和String类不同的是，StringBuffer 和 StringBuilder 类的对象能够被多次的修改，并且不产生新的未使用对象。StringBuilder 类在 Java 5 中被提出，它和 StringBuffer 之间的最大不同在于 StringBuilder 的方法不是线程安全的（线程安全就是多线程访问时，采用了加锁机制，当一个线程访问该类的某个数据时，进行保护，其他线程不能进行访问直到该线程读取完，其他线程才可使用。不会出现数据不一致或者数据污染。线程不安全就是不提供数据访问保护，有可能出现多个线程先后更改数据造成所得到的数据是脏数据）。**由于 StringBuilder 相较于 StringBuffer 有速度优势，所以多数情况下建议使用 StringBuilder 类。然而在应用程序要求线程安全的情况下，则必须使用 StringBuffer 类**。
+ 数组：声明方式为```dataType[] arrayRefVar;```（推荐）或```dataType arrayRefVar[];```（不推荐），创建方式有```arrayRefVar = new dataType[arraySize];```、```dataType[] arrayRefVar = new dataType[arraySize];```、```dataType[] arrayRefVar = {value0, value1, ..., valuek};```，索引值也是从0开始。
  + 数组可以作为函数的参数或返回值，如：
```Java
public static void printArray(int[] array) {
  for (int i = 0; i < array.length; i++) {
     System.out.print(array[i] + " ");
   }
 }
```
  + ava.util.Arrays 类能方便地操作数组，它提供的所有方法都是静态的。具有以下功能：
    + 给数组赋值：通过 fill 方法。
    + 对数组排序：通过 sort 方法，按升序。
    + 比较数组：通过 equals 方法比较数组中元素值是否相等。
    + 查找数组元素：通过 binarySearch 方法能对排序好的数组进行二分查找法操作。
+ 时间日期
+ 正则表达式：正则表达式定义了字符串的模式。正则表达式可以用来搜索、编辑或处理文本。正则表达式并不仅限于某一种语言，但是在每种语言中有细微的差别。Java正则表达式和Perl的是最为相似的。
  + java.util.regex包主要包括以下三个类：
    + Pattern类：pattern对象是一个正则表达式的编译表示。Pattern类没有公共构造方法。要创建一个Pattern对象，你必须首先调用其公共静态编译方法，它返回一个Pattern对象。该方法接受一个正则表达式作为它的第一个参数。
    + Matcher类：Matcher对象是对输入字符串进行解释和匹配操作的引擎。与Pattern类一样，Matcher也没有公共构造方法。你需要调用Pattern对象的matcher方法来获得一个Matcher对象。
    + PatternSyntaxException：PatternSyntaxException是一个非强制异常类，它表示一个正则表达式模式中的语法错误。

## IO基础

Java.io 包几乎包含了所有操作输入、输出需要的类。所有这些流类代表了输入源和输出目标。Java.io 包中的流支持很多种格式，比如：基本类型、对象、本地化字符集等等。一个流可以理解为一个数据的序列。输入流表示从一个源读取数据，输出流表示向一个目标写数据。Java为I/O 提供了强大的而灵活的支持，使其更广泛地应用到文件传输和网络编程中。

控制台输入：```BufferedReader br = new BufferedReader(new InputStreamReader(System.in));```

java.util.Scanner是Java5的新特征，我们可以通过 Scanner 类来获取用户的输入。e.g.：

```Java
import java.util.Scanner; 

public class ScannerDemo {  
    public static void main(String[] args) {  
        Scanner scan = new Scanner(System.in); 
		// 从键盘接收数据  

		//next方式接收字符串
        System.out.println("next方式接收：");
        // 判断是否还有输入
        if(scan.hasNext()){   
        	String str1 = scan.next();
         //next()方法：以空格为终止字符；
         //nextLine()方法：以Enter为终止字符
        	System.out.println("输入的数据为："+str1);  
        }  

    }  
} 
```

控制台的输出由 print() 和 println() 完成。这些方法都由类 PrintStream 定义，System.out 是该类对象的一个引用。
PrintStream 继承了 OutputStream 类，并且实现了方法 write()。这样，write() 也可以用来往控制台写操作。

文件流：```InputStream f = new FileInputStream("C:/java/hello");```、```OutputStream f = new FileOutputStream("C:/java/hello")```，还有一些关于文件和 I/O 的类，我们也需要知道：File Class、FileReader Class、FileWriter Class。

## 异常

可以使用```try...catch...finally```语句来针对异常进行处理；使用throws/throw来抛出异常，e.g.

```Java
public class className
{
   public void deposit(double amount) throws RemoteException
   {
      // Method implementation
      throw new RemoteException();
   }
   //Remainder of class definition
}
```

## 接口

接口（英文：Interface），在JAVA编程语言中是一个抽象类型，是抽象方法的集合，接口通常以interface来声明。一个类通过继承接口的方式，从而来继承接口的抽象方法。

**接口并不是类**，编写接口的方式和类很相似，但是它们属于不同的概念。类描述对象的属性和方法。接口则包含类要实现的方法。除非实现接口的类是抽象类，否则该类要定义接口中的所有方法。接口无法被实例化，但是可以被实现。

接口与类相似点：

+ 一个接口可以有多个方法。
+ 接口文件保存在.java结尾的文件中，文件名使用接口名。
+ 接口的字节码文件保存在.class结尾的文件中。
+ 接口相应的字节码文件必须在与包名称相匹配的目录结构中。

接口与类的区别：

+ 接口不能用于实例化对象。
+ 接口没有构造方法。
+ 接口中所有的方法必须是抽象方法。
+ 接口不能包含成员变量，除了static和final变量。
+ 接口不是被类继承了，而是要被类实现。
+ 接口支持多重继承。

接口的声明
```Java
可见度 interface 接口名称 [extends 其他的类名] {
        // 声明变量
        // 抽象方法
}
```

接口有以下特性：

+ 接口是隐式抽象的，当声明一个接口的时候，不必使用abstract关键字。
+ 接口中每一个方法也是隐式抽象的，声明时同样不需要abstract关键子。
+ 接口中的方法都是公有的。

一个接口能继承另一个接口，和类之间的继承方式比较相似。接口的继承使用extends关键字，子接口继承父接口的方法。一个接口可以继承多个接口，e.g.```public interface Hockey extends Sports, Event```。

类使用implements关键字实现接口，一个类可以实现多个接口。在类声明中，Implements关键字放在class声明后面。```... 类名 ... implements 接口名称[, 其他接口, 其他接口..., ...]{...}```

标识接口：标识接口是没有任何方法和属性的接口.它仅仅表明它的类属于一个特定的类型,供其他代码来测试允许做一些事情。标识接口作用：简建立一个公共的父接口；向一个类添加数据类型。

## 包(package)
为了更好地组织类，Java提供了包机制，用于区别类名的命名空间。包的作用：

+ 把功能相似或相关的类或接口组织在同一个包中，方便类的查找和使用。
+ 如同文件夹一样，包也采用了树形目录的存储方式。同一个包中的类名字是不同的，不同的包中的类的名字是可以相同的，当同时调用两个不同包中相同类名的类时，应该加上包名加以区别。因此，包可以避免名字冲突。
+ 包也限定了访问权限，拥有包访问权限的类才能访问某个包中的类。

e.g. ```package pkg1[．pkg2[．pkg3…]];```

导入包：```import package1[.package2…].(classname|*);```

类放在包中会有两种主要的结果：
+ 包名成为类名的一部分。
+ 包名必须与相应的字节码所在的目录结构相吻合。

## 泛型（类似于C++的模板）

## 序列化

【待理解】

## 多线程

【待理解】
