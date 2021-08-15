# 4-6 常用组件，Model/View, 对话框与多窗体

## 4 常用界面设计组件

### 4.1 字符串与输入输出

一些要点：

+ QLabel用于显示字符串，QLineEdit用于显示和输入字符串
+ 字符串转数字eg:

```C++
toInt(bool* ok=Q_NULLPTR, int base=10);
toDouble(bool* ok=Q_NULLPTR);
```

+ 数字转字符串eg:

```C++
//两个静态函数
QString number(int n, int base = 10);
QString asprintf(const char *cformat, ...);
//公有函数
QString &setNum(int n, int base = 10);
```

+ 进制转换：配合字符串转数字+setNum()函数即可
+ isNull()和isEmpty()的区别：只有对未赋值的字符串isNull()才返回true, 而对空字符串isNull()返回false、isNull()返回true
+ QString类的常用函数（只列举名字）还有append、prepend、toUpper、toLower、count、size、length、trimmed、simplified、indexOf、lastIndexOf、contains、section、endsWith、startsWith、left、right登等

### 4.2 SpinBox

QSpinBox用于整数的显示和输入，一般显示十进制数，也可显示二进制、十六进制数，可以在显示框中添加前缀和后缀；QDoubleSpinBox用于浮点数的显示和输入，可以设置小数位数，也可以设置显示的前缀和后缀。

使用二者读取和设置数据时无需做字符串和数字之间的转换。

### 4.3 其他输入和现实组件

|组件类名|概述|
|:----:|:----|
|QSlider|滑动条，通过滑动设置数值|
|QScrollBar|滚动条，通过滚动设置数值|
|QProgressBar|进度条，一般用于显示任务进度|
|QDial|表盘式输入组件，通过转动表针获得输入值|
|QLCDNumber|模仿LCD数字的显示组件，可以显示整数或浮点数|

### 4.4 时间日期与定时器

|类名称|概述|
|:----:|:----|
|QTime|时间数据类型，仅表示时间|
|QData|日期数据类型，仅表示日期|
|QDataTime|日期时间数据类型，表示日期和时间|
|QTimeEdit|编辑和显示时间的组件|
|QDataEdit|编辑和显示日期的组件|
|QDataTimeEdit|编辑和显示日期和时间的组件|
|QCalendarWidget|日历形式选择日期的组件|

时间转字符串：

```C++
QString toString(const QString &format) const
QString toString(Qt::DateFormat format = Qt::TextDate) const
QString toString(QStringView format) const
//如：currentDateTime.toString("hh:mm:ss");
```

字符串转时间：

```C++
//QData、QDataTime也与此一致
QTime fromString(const QString &string, Qt::DateFormat format = Qt::TextDate)
QTime fromString(const QString &string, const QString &format)
```

QTimer类——定时器，其主要属性是interval，即定时中断的周期，单位为毫秒；主要信号是timeout()，在定时中断时发射此信号。

### 4.5 QComboBox和QPlainTextEdit

QComboBox是下拉列表组件类，其提供了一个下拉列表供用户选择，也可以直接当作一个QLineEdit用作输入，其每个item还可以关联一个QVariant类型的变量，用于存储一些不可见数据。

QPlainTextEdit是用于编辑多行文本的编辑器，可以编辑普通文本，QTextEdit则是一个可以编辑带格式文本的组件，以HTML标记符定义文本格式。QTextPlainEdit的文字内容以QTextDocument类型存储，有自带的右键快捷菜单（createStandardContextMenu()）

### 4.6~4.8

使用item的Widget类型的组件，每个item可以存储文字、文字格式、自定义数据等：

|组件类名|概述|
|:----:|:----|
|QListWidget|每一行是一个item|
|QTreeWidget|每个结点是一个item|
|QTableWidget|每个单元格是一个item|

如果希望QToolButton实现已有的QAction功能，只需要使用setDefaultAction(QAction*)即可。

创建右键快捷菜单实例：

```C++
void MainWindow::customContextMenu(const QPoint& pos)
{
    Q_UNUSED(POS);
    QMenu* menuList=new QMenu(this);  //声明一个菜单对象并为其开辟空间
    //添加QAction
    menuList->addAction(ui->actListIni);
    menuList->addSeparator();
    menuList->addAction(ui->actListDelete);
    menuList->exec(QCursor::pos());//在鼠标光标位置显示右键快捷菜单
    delete menuList;//释放菜单对象
}
```

QTableWidet一些常用操作：

|操作类型|概述|
|:----:|:----|
|设置表头|setHorizontalHeaderItem()或setHorizontalHeaderLabels()|
|初始化表格数据|创建一个QTableWidgetItem对象后再setItem即可|
|获得当前单元格数据|item()|
|插入、删除|insertRow()、removeRow()、addRow()|
|自动调整行高和列宽|resizeColumnsToContents()、resizeRowsToContents()|

## 5 Model/View结构

### 5.1 Model/View结构

Model/View结构（模型/视图结构）是Qt中用界面组件显示与编辑数据的一种结构，视图是显示和编辑数据的界面组件，模型是视图和原始数据之间的接口。该结构的典型应用是在数据库应用程序中（用户在界面上执行各种操作实际上是修改了界面组件所关联的数据库内的数据）。

基本概念：

+ 数据（Data）：实际的数据，如数据库的一个数据表
+ 视图（View）：屏幕上的显示组件，视图从数据模型中获取每个数据项的模型索引，通过模型索引获得数据，然后为界面组件提供待显示的数据
+ 模型（Model）：与实际数据通信，为视图组件提供数据接口，即从原始数据提取需要的内容，用于视图组件的显示和编辑
+ 代理（Delegate）：让用户定制数据的界面显示和编辑方式（即在视图组件上为编辑数据提供编辑器）

模型、视图和代理之间使用信号和槽通信。当数据源发生变化时，数据模型发射信号通知视图组件；当用户在界面上操作上时，视图组件发射信号表示这些操作信息；当编辑数据时，代理发射信号告诉数据模型和视图组件编辑器的状态。

数据模型的基本类别为QAbstractItemModel，其子类有QAbstractListModel、QAbstractProxyModel、QAbstractTableModel、QStandardItemModel、QFileSystemModel，其下还有相关子类，用户可以继承自定义。

视图组件包括QListView、QTreeView、QTableView、QColumnView（用多个QListView显示树状层次结构）、QHeaderView（提供行表头和列表头的视图组件），前三个View类的分别都有一个Widget子类。

视图组件在显示数据时，只需调用setModel()函数，为视图组件设置一个数据模型就能实现视图组件与数据模型之间的关联在视图组件上的修改将自动保存到关联的数据模型里，一个数据模型可以同时在多个视图组件里显示数据。

### 5.2~5.4

QFileSystemModel提供了一个可用于访问本机文件系统的数据模型（需要为其设置根目录，setRootPath()），如与QTreeView配合可以目录树的形式显示本机的文件系统。

QStringListModel用千处理字符串列表的数据模型，它可以作为QListView的数据模型，在界面上显示和编辑字符串列表。
QStringListModel的setStringList(）函数可以初始化数据模型的字符串列表的内容，stringList()函数返回数据模型内的字符串列表，在关联的ListView组件里编辑修改数据后，数据都会及时更新到数据模型内的字符串列表里。

QStandardltemModel是标准的以项数据为基础的标准数据模型类，通常与QTableView组合成Model/View结构，实现通用的二维数据的管理功能。

### 5.5 自定义代理

QAbstractItemDelegate的主要子类是QItemDelegate和QStyledItemDelegate，必须实现以下四个函数：

+ createEditor()：函数创建用于编辑模型数据的widget组件，如QComboBox组件；
+ getModelData()：从数据模型获取数据供widget组件编辑；
+ setModelData()：将widget组件上的数据更新到数据模型；
+ updateEditorGeometry()：用于给widget组件设置一个合适的大小。

## 第6章 对话框与多窗体设计

### 6.1 标准对话框

常用标准对话框及其常用静态函数名：

|对话框类|常用静态函数名|
|:----:|:----|
|QFileDialog|QString getOpenFileName()<br>QString getSaveFileName()<br>QUrl getOpenFileUrl()|
|QColorDialog|QColor getColor()|
|QFontDialog|QFont getFont()|
|QInputDialog|QString getText()<br>double getDouble()<br>int getInt()<br>QString getItem()|
|QMessageBox|StandardButton information()<br>StandardButton question()<br>StandardButton critical()<br>StandardButton warning()<br>void about()<br>void aboutQt()|

### 6.2 自定义对话框及其调用

自定义窗口一般从QDialog继承，并且可以采用UI设计器可视化地设计对话框。对话框的调用一般包括创建对话框、传递数据给对话框、显示对话框获取输入、判断对话框单击按钮的返回类型、获取对话框输入数据等过程。

模态（Modal）/非模态对话框：模态显示（exec()）的对话框运行后不允许鼠标再点击其他对话框，直至对话框退出；非模态显示（show()）的对话框运行后允许继续点击其他窗口。

事件 (event) 是由窗口系统产生的由某些操作触发的特殊函数，例如鼠标操作、键盘操作的一些事件，从QWidget继承的事件主要有：

+ closeEvent()：窗口关闭时的触发事件
+ showEvent(）：窗口显示时触发的事件
+ paintEvent(）：窗口绘制事件， 第 8 章介绍绘图时会用到
+ mouseMoveEvent(）：鼠标移动事件
+ mousePressEvent(）：鼠标键按下事件
+ mouseReleaseEvent(）： 鼠标键释放事件
+ keyPressEvent(）：键盘按键按下事件
+ keyReleaseEvent(）：键盘按键释放事件

要利用某个事件进行一些处理， 需要在窗口类里重定义事件函数并编写响应代码。

### 6.3 多窗体程序设计

常用的窗体基类是 QWidget、 QDialog 和 QMainWindow, 在创建GUI应用程序时选择窗体基类就是从这 3 个类中选择。 QWidget 直接继承千 QObject, 是 QDialog 和 QMainWindow 的父类，其他继承千 QWidget 的窗体类还有 QSplashScreen、 QMdiSubWindow 和 QDesktopWidget。 此外还有QWindow类。

窗体组件的一些重要属性的设置包括setAttribute()、setWindowFlags()、setWindowState()、setWindowModality()、setWindowOpacity()等。

### 6.4 MDI程序设计

MDI，Multi-Document Interface，多文档界面，需要在主窗口区域放置一个QMdiArea作为子窗口的容器，子窗体类可以是QFormDoc

### 6.5 Splash与登录窗口

一般的大型应用程序在启动时会显示一个启动画面，即Splash窗口。Splash窗口是一个无边对话框，一般显示一个图片，展示软件的信息。Splash窗口显示时，程序在后台做一些比较耗时的启动准备工作，Splash窗口显示一段时间后自动关闭，然后软件的主窗口显示出来。Qt有一有个QSplashScreen类可以实现Splash窗口的功能，它提供了载入图片，自动设置窗口无边框效果等功能。