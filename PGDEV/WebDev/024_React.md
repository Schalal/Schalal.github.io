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

虚拟DOM由ReactElement组成$$\iff$$DOM由DOMElement组成

React元素---->React---->虚拟DOM---->React DOM---->实际DOM

### 组件

React中的组件具有良好的封装性、复用性和组合性。（目前感觉与Qt、MFC等中的“组件”基本上是一致的。）

## 2 \<Hello World/>:第一个组件

+ 使用```ReactDOM.render```进行渲染，```ReactDOM.render(element, container[, callback])```
+ 使用```React.createElement```创建React元素，```React.createElement(type, [props], [...children])```
  + type是表示要创建的HTML元素标签的字符串，如"div"、"span"等
  + props指定HTML元素的属性
  + children指定在该组件中嵌套的子组件
  + eg:
 ```JavaScript
import React from "react";
import { render } from "react-dom";
//node就是在html文件中的<div id="root"></div>
const node = document.getElementById("root");
//创建元素
const root = React.createElement(
  "div",
  {},
  React.createElement(
    "h1",
    {},
    "Hello, world!",
    React.createElement(
      "a",
      { href: "mailto:mark@ifelse.io" },
      React.createElement("h1", {}, "React In Action"),
      React.createElement("em", {}, "...and now it really is!")
    )
  )
);
//使用创建的元素进行渲染
render(root, node);
```
+ Raect会递归地对一系列React元素进行求值，来确定它应该如何为组件形成虚拟DOM
+ 创建React的类：
  ```JavaScript
    //继承了React.Component抽象基类
    class MyReactClassComponent extends Component{
        render() {}
    }
  ```
+ 所谓的高阶组件：不直接显示而是修改或是增强其他组件的组件
+ React类组件是“有状态组件”，React类组件的render方法可以访问内嵌数据（持久化内部组件状态）
+ 使用PropTypes（对应props-types类）指定组件期望的属性
```JavaScript
import React, { Component } from "react";
import { render } from "react-dom";
import PropTypes from "prop-types";
const node = document.getElementById("root");
//Post组件类
class Post extends Component {
  render() {
    return React.createElement(
      "div",
      {
        className: "post" //#C
      },
      React.createElement(
        "h2",
        {
          className: "postAuthor",
          id: this.props.id
        },
        this.props.user, //#D
        React.createElement(
          "span",
          {
            className: "postBody" //#E
          },
          this.props.content //#F
        )
      )
    );
  }
}
//类似于构造类的成员变量的相关声明
Post.propTypes = {
  user: PropTypes.string.isRequired, //#G
  content: PropTypes.string.isRequired, //#G
  id: PropTypes.number.isRequired //#G
};
//通过给定参数创建Post类对应的元素
const App = React.createElement(Post, {
  id: 1, //#H
  content: " said: This is a post!", //#H
  user: "mark" //#H
});
//使用App元素渲染node
render(App, node);
```
```JavaScript
import React, { Component } from "react";
import { render } from "react-dom";
import PropTypes from "prop-types";
const node = document.getElementById("root");
//Post类
class Post extends Component {
  render() {
    return React.createElement(
      "div",
      {
        className: "post"
      },
      React.createElement(
        "h2",
        {
          className: "postAuthor",
          id: this.props.id
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "postBody"
          },
          this.props.content
        ),
        this.props.children
      )
    );
  }
}
Post.propTypes = {
  user: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  id: PropTypes.number.isRequired
};
//Comment类
class Comment extends Component {
  render() {
    console.log("yo");
    return React.createElement(
      "div",
      {
        className: "comment"
      },
      React.createElement(
        "h2",
        {
          className: "commentAuthor"
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "commentContent"
          },
          this.props.content
        )
      )
    );
  }
}
Comment.propTypes = {
  id: PropTypes.number.isRequired,
  content: PropTypes.string.isRequired,
  user: PropTypes.string.isRequired
};
//Post类型的元素嵌套Comment类型的元素
const App = React.createElement(
  Post,
  {
    id: 1,
    content: " said: This is a post!",
    user: "mark"
  },
  React.createElement(Comment, {
    id: 2,
    user: "bob",
    content: " commented: wow! how cool!"
  })
);
render(App, node);
```
+ 类组件既有可变状态也有不可变状态，一般组件只有不可变状态（可变和不可变指的是对象在被创建后其值是否可以被改变的状态）。通过```this.state```访问可变状态，通过```this.props```访问不可变的属性。状态和属性是React中数据的运输工具。
+ 设定初始状态：
```JavaScript
import React, { Component } from "react";
import { render } from "react-dom";
import PropTypes from "prop-types";

const node = document.getElementById("root");

class Post extends Component {
  render() {
    return React.createElement(
      "div",
      {
        className: "post"
      },
      React.createElement(
        "h2",
        {
          className: "postAuthor",
          id: this.props.id
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "postBody"
          },
          this.props.content
        ),
        this.props.children
      )
    );
  }
}

Post.propTypes = {
  user: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  id: PropTypes.number.isRequired
};

class Comment extends Component {
  render() {
    return React.createElement(
      "div",
      {
        className: "comment"
      },
      React.createElement(
        "h2",
        {
          className: "commentAuthor"
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "commentContent"
          },
          this.props.content
        )
      )
    );
  }
}

Comment.propTypes = {
  id: PropTypes.number.isRequired,
  content: PropTypes.string.isRequired,
  user: PropTypes.string.isRequired
};
//constructor：构造函数，根据内容动态赋值
class CreateComment extends Component {
  constructor(props) {
    super(props);
    this.state = {
      content: "",
      user: ""
    };
  }
  render() {
    return React.createElement(
      "form",
      {
        className: "createComment"
      },
      React.createElement("input", {
        type: "text",
        placeholder: "Your name",
        value: this.state.user
      }),
      React.createElement("input", {
        type: "text",
        placeholder: "Thoughts?"
      }),
      React.createElement("input", {
        type: "submit",
        value: "Post"
      })
    );
  }
}
CreateComment.propTypes = {
  content: PropTypes.string
};

const App = React.createElement(
  Post,
  {
    id: 1,
    content: " said: This is a post!",
    user: "mark"
  },
  React.createElement(Comment, {
    id: 2,
    user: "bob",
    content: " commented: wow! how cool!"
  }),
  React.createElement(CreateComment)
);
render(App, node);
```
+ 使用```setState(function(prevState,props)->nextState,callback)->void```来更新构造函数中的初始化状态。一般的JavaScript的直接赋值与React的```this.setState```的区别在于后者更高效。
+ React实现了一个合成事件系统作为虚拟DOM的一部分，其会将浏览器中的事件转化为React应用事件，可以设置响应浏览器事件的事件处理器，区别在于React的事件处理器是设置在Raect元素上的、而不是用addEventListener,可以利用这些事件更新组件的状态。
```JavaScript
import React from "react";
import { render } from "react-dom";
import PropTypes from "prop-types";

const node = document.getElementById("root");

class Post extends React.Component {
  render() {
    return React.createElement(
      "div",
      {
        className: "post"
      },
      React.createElement(
        "h2",
        {
          className: "postAuthor",
          id: this.props.id
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "postBody"
          },
          this.props.content
        ),
        this.props.children
      )
    );
  }
}

Post.propTypes = {
  user: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  id: PropTypes.number.isRequired
};

class Comment extends React.Component {
  render() {
    return React.createElement(
      "div",
      {
        className: "comment"
      },
      React.createElement(
        "h2",
        {
          className: "commentAuthor"
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "commentContent"
          },
          this.props.content
        )
      )
    );
  }
}

Comment.propTypes = {
  id: PropTypes.number.isRequired,
  content: PropTypes.string.isRequired,
  user: PropTypes.string.isRequired
};

class CreateComment extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      content: "",
      user: ""
    };
    //在构造函数中进行事件绑定
    this.handleUserChange = this.handleUserChange.bind(this);
    this.handleTextChange = this.handleTextChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  handleUserChange(event) {
    const val = event.target.value;
    this.setState(() => ({
      user: val
    }));
  }
  handleTextChange(event) {
    const val = event.target.value;
    this.setState({
      content: val
    });
  }
  handleSubmit(event) {
    event.preventDefault();
    this.setState(() => ({
      user: "",
      content: ""
    }));
  }
  render() {
    return React.createElement(
      "form",
      {
        className: "createComment",
        onSubmit: this.handleSubmit
      },
      React.createElement("input", {
        type: "text",
        placeholder: "Your name",
        value: this.state.user,
        onChange: this.handleUserChange
      }),
      React.createElement("input", {
        type: "text",
        placeholder: "Thoughts?",
        value: this.state.content,
        onChange: this.handleTextChange
      }),
      React.createElement("input", {
        type: "submit",
        value: "Post"
      })
    );
  }
}
CreateComment.propTypes = {
  onCommentSubmit: PropTypes.func.isRequired,
  content: PropTypes.string
};

const App = React.createElement(
  Post,
  {
    id: 1,
    content: " said: This is a post!",
    user: "mark"
  },
  React.createElement(Comment, {
    id: 2,
    user: "bob",
    content: " commented: wow! how cool!"
  }),
  React.createElement(CreateComment)
);
render(App, node);
```
+ “既然有办法监听事件并修改组件状态，就有办法用单向数据流创建新组件”——在React中，数据自顶向下流动，即**从父组件向子组件**流动。当创建复合组件时，可以通过属性向子组件传递信息并在子组件中使用这些信息——JavaScript中函数可以作为参数，可以通过函数实现属性值的传递
```JavaScript
import React, { Component } from "react";
import { render } from "react-dom";
import PropTypes from "prop-types";

const node = document.getElementById("root");
//数据
const data = {
  post: {
    id: 123,
    content:
      "What we hope ever to do with ease, we must first learn to do with diligence. — Samuel Johnson",
    user: "Mark Thomas"
  },
  comments: [
    {
      id: 0,
      user: "David",
      content: "such. win."
    },
    {
      id: 1,
      user: "Haley",
      content: "Love it."
    },
    {
      id: 2,
      user: "Peter",
      content: "Who was Samuel Johnson?"
    },
    {
      id: 3,
      user: "Mitchell",
      content: "@Peter get off Letters and do your homework"
    },
    {
      id: 4,
      user: "Peter",
      content: "@mitchell ok :P"
    }
  ]
};

class Post extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    return React.createElement(
      "div",
      {
        className: "post"
      },
      React.createElement(
        "h2",
        {
          className: "postAuthor",
          id: this.props.id
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "postBody"
          },
          this.props.content
        ),
        this.props.children
      )
    );
  }
}

Post.propTypes = {
  user: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  id: PropTypes.number.isRequired
};

class Comment extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    return React.createElement(
      "div",
      {
        className: "comment"
      },
      React.createElement(
        "h2",
        {
          className: "commentAuthor"
        },
        this.props.user,
        React.createElement(
          "span",
          {
            className: "commentContent"
          },
          this.props.content
        )
      )
    );
  }
}

Comment.propTypes = {
  id: PropTypes.number.isRequired,
  content: PropTypes.string.isRequired,
  user: PropTypes.string.isRequired
};

class CreateComment extends Component {
  constructor(props) {
    super(props);
    this.state = {
      content: "",
      user: ""
    };
    this.handleUserChange = this.handleUserChange.bind(this);
    this.handleTextChange = this.handleTextChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  //调用父组件作为属性传入的onComment函数，传入来自表单的数据并重置表单
  handleUserChange(event) {
    const val = event.target.value;
    this.setState(() => ({
      user: val
    }));
  }
  handleTextChange(event) {
    const val = event.target.value;
    this.setState({
      content: val
    });
  }
  handleSubmit(event) {
    event.preventDefault();
    this.props.onCommentSubmit({
      user: this.state.user.trim(),
      content: this.state.content.trim()
    });

    this.setState(() => ({
      user: "",
      content: ""
    }));
  }
  render() {
    return React.createElement(
      "form",
      {
        className: "createComment",
        onSubmit: this.handleSubmit  //设置的方法绑定到onSubmit事件
      },
      React.createElement("input", {
        type: "text",
        placeholder: "Your name",
        value: this.state.user,
        onChange: this.handleUserChange
      }),
      React.createElement("input", {
        type: "text",
        placeholder: "Thoughts?",
        value: this.state.content,
        onChange: this.handleTextChange
      }),
      React.createElement("input", {
        type: "submit",
        value: "Post"
      })
    );
  }
}
CreateComment.propTypes = {
  onCommentSubmit: PropTypes.func.isRequired,
  content: PropTypes.string
};

class CommentBox extends Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: this.props.comments
    };
    this.handleCommentSubmit = this.handleCommentSubmit.bind(this);
  }
  handleCommentSubmit(comment) {
    const comments = this.state.comments;
    comment.id = Date.now();
    const newComments = comments.concat([comment]);
    this.setState({
      comments: newComments
    });
  }
  render() {
    return React.createElement(
      "div",
      {
        className: "commentBox"
      },
      React.createElement(Post, {
        id: this.props.post.id,
        content: this.props.post.content,
        user: this.props.post.user
      }),
      this.state.comments.map(function(comment) {
        return React.createElement(Comment, {
          key: comment.id,
          id: comment.id,
          content: comment.content,
          user: comment.user
        });
      }),
      React.createElement(CreateComment, {
        onCommentSubmit: this.handleCommentSubmit
      })
    );
  }
}

CommentBox.propTypes = {
  post: PropTypes.object,
  comments: PropTypes.arrayOf(PropTypes.object)
};

render(
  React.createElement(CommentBox, {
    comments: data.comments,
    post: data.post
  }),
  node
);
```
+ JSX：对ECMAScript的一种类XML风格的语法拓展，但没有定义任何语义，专门提供给预处理器使用，可以通过类SML风格的代码创建React元素。
```JavaScript
import React, { Component } from "react";
import { render } from "react-dom";
import PropTypes from "prop-types";

const node = document.getElementById("root");

const data = {
  post: {
    id: 123,
    content:
      "What we hope ever to do with ease, we must first learn to do with diligence. — Samuel Johnson",
    user: "Mark Thomas"
  },
  comments: [
    {
      id: 0,
      user: "David",
      content: "such. win."
    },
    {
      id: 1,
      user: "Haley",
      content: "Love it."
    },
    {
      id: 2,
      user: "Peter",
      content: "Who was Samuel Johnson?"
    },
    {
      id: 3,
      user: "Mitchell",
      content: "@Peter get off Letters and do your homework"
    },
    {
      id: 4,
      user: "Peter",
      content: "@mitchell ok :P"
    }
  ]
};
class Post extends Component {
  render() {
    return (
      <div className="post">
        <h2 className="postAuthor">{this.props.user}</h2>
        <span className="postBody">{this.props.content}</span>
        {this.props.children}
      </div>
    );
  }
}
Post.propTypes = {
  user: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  id: PropTypes.number.isRequired
};

class Comment extends Component {
  render() {
    return (
      <div className="comment">
        <h2 className="commentAuthor">{this.props.user + " : "}</h2>
        <span className="commentContent">{this.props.content}</span>
      </div>
    );
  }
}

Comment.propTypes = {
  id: PropTypes.number.isRequired,
  content: PropTypes.string.isRequired,
  user: PropTypes.string.isRequired
};

class CreateComment extends Component {
  constructor(props) {
    super(props);
    this.state = {
      content: "",
      user: ""
    };
    this.handleUserChange = this.handleUserChange.bind(this);
    this.handleTextChange = this.handleTextChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  handleUserChange(event) {
    this.setState({
      user: event.target.value
    });
  }
  handleTextChange(event) {
    this.setState({
      content: event.target.value
    });
  }
  handleSubmit(event) {
    event.preventDefault();
    this.props.onCommentSubmit({
      user: this.state.user.trim(),
      content: this.state.content.trim()
    });
    this.setState({
      user: "",
      content: ""
    });
  }
  render() {
    return (
      <form onSubmit={this.handleSubmit} className="createComment">
        <input
          value={this.state.user}
          onChange={this.handleUserChange}
          placeholder="Your name"
          type="text"
        />
        <input
          value={this.state.content}
          onChange={this.handleTextChange}
          placeholder="Thoughts?"
          type="text"
        />
        <button type="submit">Post</button>
      </form>
    );
  }
}

class CommentBox extends Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: this.props.comments
    };
    this.handleCommentSubmit = this.handleCommentSubmit.bind(this);
  }
  handleCommentSubmit(comment) {
    const comments = this.state.comments;
    comment.id = Date.now();
    const newComments = comments.concat([comment]);
    this.setState({
      comments: newComments
    });
  }
  render() {
    return (
      <div className="commentBox">
        <Post
          id={this.props.post.id}
          content={this.props.post.content}
          user={this.props.post.user}
        />
        {this.state.comments.map(function(comment) {
          return (
            <Comment
              key={comment.id}
              content={comment.content}
              user={comment.user}
            />
          );
        })}
        <CreateComment onCommentSubmit={this.handleCommentSubmit} />
      </div>
    );
  }
}

CommentBox.propTypes = {
  post: PropTypes.object,
  comments: PropTypes.arrayOf(PropTypes.object)
};

render(<CommentBox comments={data.comments} post={data.post} />, node);
```