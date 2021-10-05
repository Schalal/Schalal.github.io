# React

## 0 前言

本部分的参考书目为《React实战》（译本，原书为《React IN ACTION》,作者为Mark Tielens Thomas，译者为任发科、陈伟、蒋峰、邱巍），人民邮电出版社，2020年5月第一版。

## 1 初识React

React是一个用于构建跨平台用户界面的JavaScript库，最初由Facebook创建并开源，给予开发者强大的**思维模型**并帮助开发者以声明式和**组件**驱动的方式构建用户界面（高性能地构建UI应用）。

+ 思维模型：广泛地使用了函数式和面向对象编程的概念
+ 高性能UI构建：以组件作为构建页面的基本单元，组件是易于理解的、可以与其他组件集成，遵循可预测的生命周期，能够维护自己的内部状态，与常规JS兼容，是React的主要单元，是封装的基本单元。利用数据（属性和状态）将UI渲染为输出

React库-----React核心，react-dom（渲染器，针对的是浏览器环境和服务器端渲染），react-native（专注于原生平台，为IOS、Android创建React应用），...

与Angular这样的“紧密集成型”框架相比，React更灵活，迁移更加方便，React“仅是视图”、与JS全面互操作。

### 虚拟DOM

React鼓励使用声明式编程而非命令式编程，开发人员要声明组件在不同状态下的行为和外观，而React的内部机制处理管理更新、更新UI以反映更改等的复杂性。其中的关键技术就是虚拟DOM，这种虚拟DOM是模仿或镜像存在于浏览器之中的文档对象模型的数据结构或数据结构的集合。虚拟DOM会作为应用程序代码和浏览器DOM之间的中间层，虚拟DOM向开发者隐藏了变更检测与管理的复杂性、并将其转移到专门的抽象层。

什么是DOM？DOM（Document Object Model）是一个允许JS与不同类型文档（HTML、SVG、XML）进行交互的编程接口，有一个标准驱动的规范，提供了访问、存储和操纵文档中不同部分的结构化方式，即浏览器的Web API使开发者可以使用JS通过DOM与Web文档进行交互。从较高层次上来讲，DOM是一种反映了XML文档层次结构的树形结构，这棵树由子树组成，子树由节点构成，节点时组成Web页面和应用的div和其他元素。如```document.findElemenyByID```就是这种DOM的API之一。使用React时几乎不用再显式地使用DOM。

在大型Web应用中直接使用DOM可能会有一些问题，如当数据变化时，我们希望通过UI更新来反映，但是通常难以以一种有效且易于理解的当时来实现（当访问、修改或创建DOM元素时，浏览器常常要在一个结构化的树上执行查询来找到指定的元素，如果进行重新布局、缩放等其他操作，计算量往往很大，虚拟DOM可以在一定的限制下帮助优化DOM的更新）。React的虚拟DOM在兼顾性能的前提下，提供了健壮的API、简单的思维模型和诸如跨浏览器兼容性等其他特性（React可以执行智能更新，并且只更新已更改的部分，因为它可以使用启发式的对比方法计算DOM中的哪些部分需要更新）。

React的虚拟DOM由React的元素组成，React元素是React中轻量、无状态、不可变的基类，有ReactComponentElement和ReactDOMElement两种类型，前者对应React组件的一个函数或类，后者是DOM元素的虚拟表示。

### 组件

React中的组件具有良好的封装性、复用性和组合性。（目前感觉与Qt、MFC等中的“组件”基本上是一致的。）

## 2 \<Hello World/>:第一个组件

+ 使用```ReactDOM.render```进行渲染，```ReactDOM.render(element, container[, callback])```
+ 使用```React.createElement```创建React元素，```React.createElement(type, [props], [...children])```
+ 创建React的类：
  ```JavaScript
    //继承了React.Component抽象基类
    class MyReactClassComponent extends Component{
        render() {}
    }
  ```