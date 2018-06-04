[TOC]

# 大厂开发区移动接口

## 登录
### 操作：登录

URL：/service/Login.ashx

参数：

| 键         | 值         | 类型   | 描述                          | 必须 |
|------------|------------|--------|-------------------------------|------|
| username   |            | string | 用户名称                      | 是   |
| password   |            | string | 密码                          | 是   |
| rememberMe | true/false | string | 记住我，下次自动登录，保存7天 | 否   |
| clientId   |            | string | 个推的clientID | 否   |
| iOS   |            | string | 是否是iOS | 否   |

自动登录时:

| 键    | 值 | 类型   | 描述 | 必须 |
|-------|----|--------|------|------|
| token |    | string | 令牌 | 是   |

返回值：

| 键           | 值             | 类型   | 描述           | 必须 | 存在条件        |
|--------------|----------------|--------|----------------|------|-----------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| organization |                | string | 用户所属组织   | 是   |                 |
| deptname     |                | string | 用户所属部门   | 是   |                 |
| occupation   |                | string | 用户职位       | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| tokenstr     | UUID           | string | 令牌           | 否   | status为success |
| bindresult   |                | string | 绑定结果       | 是   |                 |
| privilege   |                | json数组 | 权限集合       | 是   |                 |
| mobilePhone   |                | string | 手机号       | 是   |                 |

### 操作：登出

URL：/service/Logout.ashx

参数：

| 键    | 值 | 类型   | 描述 | 必须 |
|-------|----|--------|------|------|
| token |    | string | 令牌 | 是   |

返回值：

| 键      | 值             | 类型   | 描述     | 必须 | 存在条件       |
|---------|----------------|--------|----------|------|----------------|
| status  | success/failed | string | 状态     | 是   |                |
| errorNo |                | int    | 错误代码 | 否   | status为failed |

## 表单
### 操作：表单详情

URL：/service/form/FormDetail.ashx

参数：

| 键      |      值    | 类型   |   描述   | 必须 | 默认  |
|---------|------------|--------|----------|------|-------|
| workId  |            | string | 业务ID   | 是   |       |
| fkNode  |            | string | 节点ID   | 是   |       |
| formId  |            | string | 表单ID   | 是   |       |
| token   |            | string | 令牌     | 是   |       |

<span id="formDetailRet">返回值：Json数组，其中每个对象包含</span>

| 键                | 值             | 类型         | 描述                                | 必须 | 存在条件       |
|-------------------|----------------|--------------|-------------------------------------|------|----------------|
| GroupId           |                | string       | 组ID                              | 是   |                |
| Table             |                | string       | 表名                                | 是   |                |
| Field             |                | string       | 字段名                              | 是   |                |
| Label             |                | string       | 显示名称                            | 是   |                |
| DataType          |                | string       | 数据类型                            | 是   |                |
| Value             |                | string       | 值，也是ControlDataSource字典中的值 | 是   |                |
| ControlType       |                | string       | 控件类型                            | 是   |                |
| TextType          |                | string       | 文本类型，例如："date"、"意见"、"会签"      | 是   |                |
| ControlDataSource |                | Dictionary   | 控件数据源，用于下拉框              | 是   |                |
| ReadOnly          |                | bool         | 是否只读                            | 是   |                |
| MultiLine         |                | bool         | 是否多行                            | 是   |                |
| DateFormat        |                | string       | 日期格式                            | 是   |                |
| Suffix            |                | string       | 后缀，例如"万元"、"平方米"          | 是   |                |
| Columns           |                | json array   | 列数组，当前是数据网格              | 是   |                |

其中Columns中的每个对象

| 键                | 值             | 类型         | 描述                                | 必须 | 存在条件       |
|-------------------|----------------|--------------|-------------------------------------|------|----------------|
| Field             |                | string       | 字段名                              | 是   |                |
| Label             |                | string       | 显示名称                            | 是   |                |
| DataType          |                | string       | 数据类型                            | 是   |                |
| ControlType       |                | string       | 控件类型（目前没用）                | 是   |                |
| ControlDataSource |                | Dictionary   | 控件数据源，用于下拉框 （目前没用） | 是   |                |
| ReadOnly          |                | bool         | 是否只读                            | 是   |                |
| Values            |                | Dictionary   | 键：rowId，值：value                | 是   |                |

说明：控件类型有文本框、下拉框、日期框、数据网格、分组框、签字口令框、签字日期框。TextType会签表示会签意见子表

测试数据：郝继善，新建行文处理

### 操作：保存表单

URL：/service/form/Save.ashx

参数：

| 键           | 值 | 类型   | 描述           | 必须 | 默认 |
|--------------|----|--------|----------------|------|------|
| token  |    | string | 令牌 | 是   |      |
| workId       |    | string | 业务ID         | 是   |      |
| fId          |    | string | 父业务ID       | 是   |      |
| fkFlow       |    | string | 流程ID         | 是   |      |
| fkNode       |    | string | 节点ID         | 是   |      |
| formSaveStr  |    | string | 保存的json对象 | 是   |      |
| isEnd        |    | string | 是否保存到待办 | 否   | true |
| formId       |    | string | 表单ID，用于自动签字    | 是   |  |

其中formSaveStr，如下图所示。详细见[这里](http://localhost/lfyd/jsons/formSaveStr.json)
![formSaveStr](http://122.226.81.198:8082/lfyd/images/保存消息-formSaveStr结构.png)

> 注意："TS_Project"，"gc1"为表单详情返回值中的Table，"建设单位","项目总流水号"，"PROJECTNO"为Field
>
> 其中gc1 > Rows > Row中的每个对象：id为表单详情返回值Columns中对象的Values中的键rowId
>
> id为-1代表添加，deleteFlag为true代表删除，添加优先，其余的情况代表更新（如上图中的第二个）

返回值：

| 键      | 值             | 类型   | 描述     | 必须 | 存在条件       |
|---------|----------------|--------|----------|------|----------------|
| status  | success/failed | string | 状态     | 是   |                |
| errorNo |                | int    | 错误代码 | 否   | status为failed |

### 操作：选择发送人员

URL：/service/form/GetAccepter.ashx

参数：

| 键           | 值 | 类型   | 描述           | 必须 | 默认 |
|--------------|----|--------|----------------|------|------|
| workId       |    | string | 业务ID         | 是   |      |
| fId          |    | string | 父业务ID       | 是   |      |
| fkFlow       |    | string | 流程ID         | 是   |      |
| fkNode       |    | string | 节点ID         | 是   |      |


返回值：json数组，其中每个对象

| 键           | 值 | 类型   | 描述           | 必须 | 默认 |
|--------------|----|--------|----------------|------|------|
| toNode       |    | string | 下一节点ID     | 是   |      |
| name         |    | string | 节点名称       | 是   |      |
| organization |    | string | 组织结构       | 是   |      |

organization数组，如下图
<img src="http://122.226.81.198:8082/lfyd/images/选择发送人员-返回值结构.png">

> 注意：其中的id为发送表单时候用到的usernames

### 操作：发送表单

URL：/service/form/Send.ashx

参数：

| 键           | 值 | 类型   | 描述                              | 必须 | 默认 |
|--------------|----|--------|-----------------------------------|------|------|
| token        |    | string | 令牌                              | 是   |      |
| usernames    |    | string | 接收的1-n个用户名，中间以逗号分隔 | 是   |      |
| workId       |    | string | 业务ID                            | 是   |      |
| fId          |    | string | 父业务ID                          | 是   |      |
| fkFlow       |    | string | 流程ID                            | 是   |      |
| fkNode       |    | string | 节点ID                            | 是   |      |
| toNode       |    | string | 下一节点ID                        | 是   |      |

返回值：

| 键      | 值             | 类型   | 描述     | 必须 | 存在条件       |
|---------|----------------|--------|----------|------|----------------|
| status  | success/failed | string | 状态     | 是   |                |
| errorNo |                | int    | 错误代码 | 否   | status为failed |

### 操作：结案

URL：/service/form/End.ashx

参数：

| 键           | 值 | 类型   | 描述                              | 必须 | 默认 |
|--------------|----|--------|-----------------------------------|------|------|
| token        |    | string | 令牌                              | 是   |      |
| workId       |    | string | 业务ID                            | 是   |      |
| fId          |    | string | 父业务ID                          | 是   |      |
| fkFlow       |    | string | 流程ID                            | 是   |      |
| fkNode       |    | string | 节点ID                            | 是   |      |

返回值：

| 键      | 值             | 类型   | 描述     | 必须 | 存在条件       |
|---------|----------------|--------|----------|------|----------------|
| status  | success/failed | string | 状态     | 是   |                |
| errorNo |                | int    | 错误代码 | 否   | status为failed |

### 操作：回退

URL：/service/form/RollBack.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| workId      |    | string | 业务id       | 是   |      |
| fkFlow      |    | string | 流程id       | 是   |      |
| fkNode      |    | string | 节点id       | 是   |      |
| rollText    |    | string | 回退理由     | 否   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件        |
|-------------|----------------|-------------|------------------------------|------|-----------------|
| status      | success/failed | string      | 状态                         | 是   |                 |
| errorNo     |                | int         | 错误代码                     | 否   | status为failed  |


### 操作：会签意见

URL：/service/form/SignOpinion.ashx

参数：

| 键         | 值         | 类型   | 描述      | 必须 | 默认  |
|------------|------------|--------|----------|------|------|
| token      |            | string | 令牌     | 是   |       |
| workId     |            | string | 业务ID   | 是   |       |
| fkNode     |            | string | 节点ID   | 是   |       |
| content    |            | string | 内容     | 是   |       |

返回值：

| 键          | 值             | 类型        | 描述         | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------|------|-----------------|
| status      | success/failed | string      | 状态         | 是   |                 |


## 公文、项目
### 操作： 公文待办列表

URL：/service/gw/gwdblist.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| pageSize    |    | string | 每页数量     | 是   |      |
| pageIndex   |    | string | 第几页       | 是   |      |
| search      |    | string | 搜索字段     | 否   |      |


返回值：

| 键          | 值             | 类型   | 描述     | 必须 | 存在条件       |
|-------------|----------------|--------|----------|------|----------------|
| projectname |                | string | 项目名称 | 是   |                |
| rdt         |                | string | 发起时间 | 是   |                |
| projectno   |                | string | 项目编号 | 是   |                |
| flowname    |                | string | 公文类型 | 是   |                |
| isread      |                | string | 阅读状态 | 是   |                |
| formid      |                | string | 表单id   | 是   |                |
| workid      |                | string | 业务id   | 是   |                |
| fk_node     |                | string | 节点id   | 是   |                |
| fk_flow     |                | string | 流程id   | 是   |                |
| fid         |				   | string | 父业务id | 是   |                |

### 操作： 公文已办列表
----------

URL：/service/gw/gwyblist.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| pageSize    |    | string | 每页数量     | 是   |      |
| pageIndex   |    | string | 第几页       | 是   |      |
| search      |    | string | 搜索字段     | 否   |      |


返回值：

| 键          | 值             | 类型   | 描述     | 必须 | 存在条件       |
|-------------|----------------|--------|----------|------|----------------|
| projectname |                | string | 项目名称 | 是   |                |
| rdt         |                | string | 发起时间 | 是   |                |
| projectno   |                | string | 项目编号 | 是   |                |
| flowname    |                | string | 公文类型 | 是   |                |
| formid      |                | string | 表单id   | 是   |                |
| workid      |                | string | 业务id   | 是   |                |
| fk_node     |                | string | 节点id   | 是   |                |
| fk_flow     |                | string | 流程id   | 是   |                |
| fid         |				   | string | 父业务id | 是   |                |

### 操作： 公文收阅列表
----------

URL：/service/gw/gwsylist.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| pageSize    |    | string | 每页数量     | 是   |      |
| pageIndex   |    | string | 第几页       | 是   |      |
| search      |    | string | 搜索字段     | 否   |      |


返回值：

| 键          | 值             | 类型   | 描述     | 必须 | 存在条件       |
|-------------|----------------|--------|----------|------|----------------|
| projectname |                | string | 项目名称 | 是   |                |
| rdt         |                | string | 发起时间 | 是   |                |
| cyr         |                | string | 传阅人   | 是   |                |
| formid      |                | string | 表单id   | 是   |                |
| workid      |                | string | 业务id   | 是   |                |
| fk_node     |                | string | 节点id   | 是   |                |
| fk_flow     |                | string | 流程id   | 是   |                |
| fid         |				   | string | 父业务id | 是   |                |
| readstate   |				   | string | 1为已阅，0为未阅 | 是   |                |
| messageId   |				   | string | 消息ID | 是   |                |
| fileid   |				   | string | 文件ID | 是   |                |
| cyOpinion   |				   | string | 传阅意见 | 是   |                |

### 操作：案卷取回
----------

URL：/service/form/QuHui.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| workId      |    | string | 业务id       | 是   |      |
| isread      |    | string | 阅读状态     | 是   |      |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件        |
|-------------|----------------|-------------|------------------------------|------|-----------------|
| status      | success/failed | string      | 状态                         | 是   |                 |
| errorNo     |                | int         | 错误代码                     | 否   | status为failed  |

### 操作： 项目待办列表
----------

URL：/service/xm/xmdblist.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| pageSize    |    | string | 每页数量     | 是   |      |
| pageIndex   |    | string | 第几页       | 是   |      |
| search      |    | string | 搜索字段     | 否   |      |


返回值：

| 键          | 值             | 类型   | 描述     | 必须 | 存在条件       |
|-------------|----------------|--------|----------|------|----------------|
| projectname |                | string | 项目名称 | 是   |                |
| rdt         |                | string | 发起时间 | 是   |                |
| projectno   |                | string | 项目编号 | 是   |                |
| flowname    |                | string | 业务类型 | 是   |                |
| datet       |                | string | 剩余天数 | 是   |                |
| isread      |                | string | 阅读状态 | 是   |                |
| formid      |                | string | 表单id   | 是   |                |
| workid      |                | string | 业务id   | 是   |                |
| fk_node     |                | string | 节点id   | 是   |                |
| fk_flow     |                | string | 流程id   | 是   |                |
| fid         |				   | string | 父业务id | 是   |                |

### 操作： 项目已办列表
----------

URL：/service/xm/xmyblist.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| pageSize    |    | string | 每页数量     | 是   |      |
| pageIndex   |    | string | 第几页       | 是   |      |
| search      |    | string | 搜索字段     | 否   |      |


返回值：

| 键          | 值             | 类型   | 描述     | 必须 | 存在条件       |
|-------------|----------------|--------|----------|------|----------------|
| projectname |                | string | 项目名称 | 是   |                |
| rdt         |                | string | 发起时间 | 是   |                |
| projectno   |                | string | 项目编号 | 是   |                |
| flowname    |                | string | 业务类型 | 是   |                |
| formid      |                | string | 表单id   | 是   |                |
| workid      |                | string | 业务id   | 是   |                |
| fk_node     |                | string | 节点id   | 是   |                |
| fk_flow     |                | string | 流程id   | 是   |                |
| fid         |				   | string | 父业务id | 是   |                |

### 操作： 项目收阅列表
----------

URL：/service/xm/xmsylist.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| pageSize    |    | string | 每页数量     | 是   |      |
| pageIndex   |    | string | 第几页       | 是   |      |
| search      |    | string | 搜索字段     | 否   |      |


返回值：

| 键          | 值             | 类型   | 描述     | 必须 | 存在条件       |
|-------------|----------------|--------|----------|------|----------------|
| projectname |                | string | 项目名称 | 是   |                |
| rdt         |                | string | 发起时间 | 是   |                |
| cyr         |                | string | 传阅人   | 是   |                |
| formid      |                | string | 表单id   | 是   |                |
| workid      |                | string | 业务id   | 是   |                |
| fk_node     |                | string | 节点id   | 是   |                |
| fk_flow     |                | string | 流程id   | 是   |                |
| fid         |				   | string | 父业务id | 是   |                |
| readstate   |				   | string | 1为已阅，0为未阅 | 是   |                |
| messageId   |				   | string | 消息ID | 是   |                |
| fileid   |				   | string | 文件ID | 是   |                |
| cyOpinion   |				   | string | 传阅意见 | 是   |                |

### 操作： 公文、项目日志
----------

URL：/service/form/GetProjectLog.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| workid      |    | string | 业务id       | 是   |      |
| fk_flow     |    | string | 流程id       | 是   |      |

返回值：

| 键          | 值             | 类型   | 描述         | 必须 | 存在条件       |
|-------------|----------------|--------|--------------|------|----------------|
| ndfromt     |                | string | 上个环节     | 是   |                |
| ndtot       |                | string | 当前环节     | 是   |                |
| empfromt    |                | string | 发送者       | 是   |                |
| emptot      |                | string | 接收者       | 是   |                |
| action      |                | string | 动作         | 是   |                |

### 操作： 公文、项目树
----------

URL：/service/form/GetProjectTree.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| workid      |    | string | 业务id       | 是   |      |
| fk_flow     |    | string | 流程id       | 是   |      |


返回值：

| 键          | 值    | 类型   | 描述               | 必须 | 存在条件       |
|-------------|-------|--------|--------------------|------|----------------|
| text        |       | string | 业务类型：案卷编号 | 是   |                |
| formid      |       | string | 表单id             | 是   |                |
| workid      |       | string | 业务id             | 是   |                |
| fk_node     |       | string | 节点id             | 是   |                |

### 操作： 公文、项目的材料清单列表
----------

URL：/service/form/GetMaterialList.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| workid      |    | string | 业务id       | 是   |      |
| fk_flow     |    | string | 流程id       | 是   |      |

返回值：

| 键          | 值    | 类型   | 描述               | 必须 | 存在条件       |
|-------------|-------|--------|--------------------|------|----------------|
| templatename|       | string | 模版名称           | 是   |                |
| filename    |       | string | 文件名称           | 是   |                |
| filepath    |       | string | 文件路径           | 是   |                |
| extension   |       | string | 文件格式           | 是   |                |
| id          |       | string | 材料文件ID         | 是   |                |

### 操作： 公文、项目的表单列表
----------

URL：/service/form/GetFormList.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| workid      |    | string | 业务id       | 是   |      |
| fk_flow     |    | string | 流程id       | 是   |      |
| fk_node     |    | string | 节点id       | 是   |      |

返回值：

| 键          | 值    | 类型   | 描述               | 必须 | 存在条件       |
|-------------|-------|--------|--------------------|------|----------------|
| name        |       | string | 表单名称           | 是   |                |
| fid         |       | string | 父业务id             | 是   |                |
| workid      |       | string | 业务id             | 是   |                |
| fk_node     |       | string | 节点id             | 是   |                |
| fk_flow     |       | string | 流程id             | 是   |                |
| formid      |       | string | 表单id             | 是   |                |


### 操作： 未阅项目、公文消息数
----------

URL：/service/search/GetNotRead.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件  |
|-------------|----------------|-------------|------------------------------|------|-----------|
| documentNum |                | string      | 未阅公文数                   | 是   |           |


## 消息
----------

### 操作： 所有未读消息总数
----------

URL：/service/message/GetNumOfUnreadMessages.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |

返回值：

| 键          | 值             | 类型   | 描述               | 必须 | 存在条件        |
|-------------|----------------|--------|--------------------|------|-----------------|
| status      | success/failed | string | 状态               | 是   |                 |
| errorNo     |                | int    | 错误代码           | 否   | status为failed  |
| total       |                | int    | 消息数             | 否   | status为success |

### 操作： 按页获取未读消息
----------

URL：/service/message/GetPageUnreadMessages.ashx

参数：

| 键          | 值 | 类型   | 描述                                                           | 必须 | 默认 |
|-------------|----|--------|----------------------------------------------------------------|------|------|
| token       |    | string | 令牌                                                           | 是   |      |
| pageIndex   |    | string | 第几页                                                         | 是   |      |
| pageSize    |    | string | 每页数量                                                       | 是   |      |
| notIncludes |    | string | 以逗号分隔不包含的消息id，用于不返回已经显示的"收文提醒消息"） | 否   |      |

返回值：

| 键          | 值             | 类型   | 描述               | 必须 | 存在条件        |
|-------------|----------------|--------|--------------------|------|-----------------|
| status      | success/failed | string | 状态               | 是   |                 |
| errorNo     |                | int    | 错误代码           | 否   | status为failed  |
| counts      |                | int    | 总的消息数（不包含"收文提醒消息"）             | 否   | status为success |
| total       |                | int    | 返回的消息数       | 否   | status为success |
| rows        |                | int    | 消息数             | 否   | status为success |

其中rows中的每个对象:

| 键            | 值              | 类型   | 描述                        | 必须 | 存在条件         |
|---------------|-----------------|--------|-----------------------------|------|------------------|
| ID            |                 | string | 消息ID                      | 是   |                  |
| SENDTIIME     |                 | string | 发送时间                    | 是   |                  |
| MESSAGE_TYPE  |                 | string | 消息类型                    | 是   |                  |
| CONTENT       |                 | string | 内容                        | 是   |                  |
| AJLX          |规划业务/行政办公| string | 案卷类型，用于区分公文和业务| 否   |消息类型为案卷消息、督办、回退、传阅|


###~~ 操作： 所有未读消息~~
----------

URL：/service/message/GetUnreadMessages.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述               | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------------|------|-----------------|
| status      | success/failed | string      | 状态               | 是   |                 |
| errorNo     |                | int         | 错误代码           | 否   | status为failed  |
| content     |                | json Object | 消息数             | 否   | status为success |

总的返回值：如下图，其中的ID是接下要用到的messageId
<img src="http://122.226.81.198:8082/lfyd/images/未读消息-返回值结构.png">

###~~ 操作： 消息（非案卷消息）~~
----------

URL：/service/message/GetMessage.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| messageId   |    | string | 消息ID     | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述               | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------------|------|-----------------|
| status      | success/failed | string      | 状态               | 是   |                 |
| errorNo     |                | int         | 错误代码           | 否   | status为failed  |
| content     |                | string      | 内容               | 否   | status为success |

### 操作： 从消息中打开表单（案卷、回退、传阅、督办消息）
----------

URL：/service/message/GetFormFromMessage.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| messageId   |    | string | 消息ID       | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件        |
|-------------|----------------|-------------|------------------------------|------|-----------------|
| status      | success/failed | string      | 状态                         | 是   |                 |
| errorNo     |                | int         | 错误代码                     | 否   | status为failed  |
| form        |                | json Array  | [同表单详情](#formDetailRet) | 否   | status为success |
| workId      |                | string      | 业务ID                       | 否   | status为success |
| formId      |                | string      | 表单ID                       | 否   | status为success |
| fkFlow      |                | string      | 流程                         | 否   | status为success |
| fkNode      |                | string      | 节点                         | 否   | status为success |
| fId         |                | string      | 父业务ID                     | 否   | status为success |

### 操作： 从消息中打开表单（收文时限提醒消息）
----------

URL：/service/message/GetFormFromSWMessage.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| messageId   |    | string | 消息ID       | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件        |
|-------------|----------------|-------------|------------------------------|------|-----------------|
| status      | success/failed | string      | 状态                         | 是   |                 |
| errorNo     |                | int         | 错误代码                     | 否   | status为failed  |
| form        |                | json Array  | [同表单详情](#formDetailRet) | 否   | status为success |
| workId      |                | string      | 业务ID                       | 否   | status为success |
| formId      |                | string      | 表单ID                       | 否   | status为success |
| fkFlow      |                | string      | 流程                         | 否   | status为success |
| fkNode      |                | string      | 节点                         | 否   | status为success |
| fId         |                | string      | 父业务ID                     | 否   | status为success |

### 操作： 从消息中打开会议详情（会议消息）
----------

URL：/service/message/GetMeetingFromMessage.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| messageId   |    | string | 消息ID       | 是   |      |

返回值：

| 键			|      值    | 类型     | 描述			     | 必须 | 存在条件 |
|---------------|------------|----------|--------------------|------|----------|
| status        | success/failed | string | 状态             | 是   |                 |
| errorNo       |                | int    | 错误代码         | 否   | status为failed  |
| hymc		    |            | string   | 会议名称           | 是   |          |
| hybh		    |            | string   | 会议编号		     | 是   |          |
| hysj	    	|            | string   | 会议时间			 | 是   |          |
| hyzcr		    |            | string   | 会议主持人		 | 是   |          |
| hydd		    |            | string   | 会议地点			 | 是   |          |
| hylx			|            | string   | 会议类型  		 | 是   |          |
| hyry			|            | string   | 参会人员  		 | 是   |          |
| zzbm			|            | string   | 组织部门  		 | 是   |          |
| zzdw			|            | string   | 组织单位  		 | 是   |          |
| cjyr			|            | string   | 传纪要人  		 | 是   |          |
| jlr			|            | string   | 记录人    		 | 是   |          |
| kqr			|            | string   | 考勤人    		 | 是   |          |
| hynr			|            | string   | 会议内容  		 | 是   |          |
| name		    |            | string   | 附件名称			 | 否   |          |
| size		    |            | string   | 附件大小			 | 否   |          |
| path		    |            | string   | 附件路径			 | 否   |          |


### 操作： 消息标记为已读
----------

URL：/service/message/MarkMessageHasRead.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |
| messageId   |    | long   | 消息ID       | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件        |
|-------------|----------------|-------------|------------------------------|------|-----------------|
| status      | success/failed | string      | 状态                         | 是   |                 |
| errorNo     |                | int         | 错误代码                     | 否   | status为failed  |

### 操作： 多个消息标记为已读
----------

URL：/service/message/MarkMultiMessagesHasRead.ashx

参数：

| 键          | 值 | 类型   | 描述                 | 必须 | 默认 |
|-------------|----|--------|----------------------|------|------|
| token       |    | string | 令牌                 | 是   |      |
| messageIds  |    | string | 以逗号分隔的消息ID   | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件        |
|-------------|----------------|-------------|------------------------------|------|-----------------|
| status      | success/failed | string      | 状态                         | 是   |                 |
| errorNo     |                | int         | 错误代码                     | 否   | status为failed  |


###~~ 操作： 所有消息标记为已读~~
----------

URL：/service/message/MarkAllMessagesHasRead.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token       |    | string | 令牌         | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件        |
|-------------|----------------|-------------|------------------------------|------|-----------------|
| status      | success/failed | string      | 状态                         | 是   |                 |
| errorNo     |                | int         | 错误代码                     | 否   | status为failed  |

## 查询
----------
### 操作：综合查询
----------

URL：/service/form/ColligateSearch.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认 |
|-------------|----|----------|--------------|------|------|
| token       |    | string   | 令牌         | 是   |      |
| value       |    | string   | 搜索值       | 是   |      |
| pageSize    |    | string   | 每页数量     | 是   |      |
| pageIndex   |    | string   | 第几页       | 是   |      |

返回值：

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件         |
|---------|------------|--------|------------|------|------------------|
| blzt    |            | string | 办理状态   | 是   |                  |
| xmbh    |            | string | 项目编号   | 是   |                  |
| ajbh    |            | string | 案卷编号   | 是   |                  |
| ywlx    |            | string | 业务类型   | 是   |                  |
| xmmc    |            | string | 项目名称   | 是   |                  |
| zh      |            | string | 证号       | 是   |                  |
| zbks    |            | string | 主办科室   | 是   |                  |
| djsj    |            | string | 登记时间   | 是   |                  |
| workid  |            | string | 业务ID     | 是   |                  |
| fknode  |            | string | 节点ID     | 是   |                  |
| fid     |            | string | 父业务ID   | 是   |                  |
| formid  |            | string | 表单ID     | 是   |                  |

### 操作：高级查询
----------

URL：/service/form/AdvancedSearch.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认             |
|-------------|----|----------|--------------|------|------------------|
| token       |    | string   | 令牌         | 是   |                  |
| xmmc        |    | string   | 项目名称     | 否   |                  |
| jbr         |    | string   | 经办人       | 否   |                  |
| ywlx        |    | string   | 业务类型     | 否   |                  |
| pageSize    |    | string   | 每页数量     | 是   |                  |
| pageIndex   |    | string   | 第几页       | 是   |                  |

返回值：

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件 |
|---------|------------|--------|------------|------|----------|
| blzt    |            | string | 办理状态   | 是   |          |
| xmbh    |            | string | 项目编号   | 是   |          |
| ajbh    |            | string | 案卷编号   | 是   |          |
| ywlx    |            | string | 业务类型   | 是   |          |
| xmmc    |            | string | 项目名称   | 是   |          |
| zh      |            | string | 证号       | 是   |          |
| zbks    |            | string | 主办科室   | 是   |          |
| djsj    |            | string | 登记时间   | 是   |          |
| workid  |            | string | 业务ID     | 是   |          |
| fknode  |            | string | 节点ID     | 是   |          |
| fkflow  |            | string | 流程ID     | 是   |          |
| fid     |            | string | 父业务ID   | 是   |          |
| formid  |            | string | 表单ID     | 是   |          |

### 操作： 本人查询
----------

URL：/service/search/UserSelfSearch.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token      |    | string | 令牌       | 是   |      |
| search      |    | string | 查找的值       | 是   |      |
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件       |
|-------------|----------------|-------------|------------------------------|------|---------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| resutls      |                | json数组    | 错误代码       | 否   | status为success  |

其中results数组中的每个对象

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件         |
|---------|------------|--------|------------|------|------------------|
| blzt    |            | string | 办理状态   | 是   |                  |
| xmbh    |            | string | 项目编号   | 是   |                  |
| ajbh    |            | string | 案卷编号   | 是   |                  |
| ywlx    |            | string | 业务类型   | 是   |                  |
| xmmc    |            | string | 项目名称   | 是   |                  |
| zh      |            | string | 证号       | 是   |                  |
| zbks    |            | string | 主办科室   | 是   |                  |
| djsj    |            | string | 登记时间   | 是   |                  |
| workid  |            | string | 业务ID     | 是   |                  |
| fknode  |            | string | 节点ID     | 是   |                  |
| fid     |            | string | 父业务ID   | 是   |                  |
| formid  |            | string | 表单ID     | 是   |                  |

### 操作： 本局查询
----------

URL：/service/search/DepartmentSearch.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| deptname      |    | string | 部门名       | 是   |      |
| search      |    | string | 查找的值       | 是   |      |
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件       |
|-------------|----------------|-------------|------------------------------|------|---------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| resutls      |                | json数组    | 错误代码       | 否   | status为success  |

其中results数组中的每个对象

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件         |
|---------|------------|--------|------------|------|------------------|
| blzt    |            | string | 办理状态   | 是   |                  |
| xmbh    |            | string | 项目编号   | 是   |                  |
| ajbh    |            | string | 案卷编号   | 是   |                  |
| ywlx    |            | string | 业务类型   | 是   |                  |
| xmmc    |            | string | 项目名称   | 是   |                  |
| zh      |            | string | 证号       | 是   |                  |
| zbks    |            | string | 主办科室   | 是   |                  |
| djsj    |            | string | 登记时间   | 是   |                  |
| workid  |            | string | 业务ID     | 是   |                  |
| fknode  |            | string | 节点ID     | 是   |                  |
| fid     |            | string | 父业务ID   | 是   |                  |
| formid  |            | string | 表单ID     | 是   |                  |

### 操作： 综合查询
----------

URL：/service/search/OrganizationSearch.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| search      |    | string | 查找的值       | 是   |      |
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件       |
|-------------|----------------|-------------|------------------------------|------|---------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| resutls      |                | json数组    | 错误代码       | 否   | status为success  |

其中results数组中的每个对象

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件         |
|---------|------------|--------|------------|------|------------------|
| blzt    |            | string | 办理状态   | 是   |                  |
| xmbh    |            | string | 项目编号   | 是   |                  |
| ajbh    |            | string | 案卷编号   | 是   |                  |
| ywlx    |            | string | 业务类型   | 是   |                  |
| xmmc    |            | string | 项目名称   | 是   |                  |
| zh      |            | string | 证号       | 是   |                  |
| zbks    |            | string | 主办科室   | 是   |                  |
| djsj    |            | string | 登记时间   | 是   |                  |
| workid  |            | string | 业务ID     | 是   |                  |
| fknode  |            | string | 节点ID     | 是   |                  |
| fid     |            | string | 父业务ID   | 是   |                  |
| formid  |            | string | 表单ID     | 是   |                  |

### 操作： 本人高级查询
----------

URL：/service/search/AdvancedUserSelfSearch.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token      |    | string | 令牌       | 是   |      |
| xmmc        |    | string | 项目名称     | 否   |      |
| jbr         |    | string | 经办人       | 否   |      |
| ywlx        |    | string | 业务类型     | 否   |      |
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件       |
|-------------|----------------|-------------|------------------------------|------|---------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| resutls      |                | json数组    | 错误代码       | 否   | status为success  |

其中results数组中的每个对象

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件         |
|---------|------------|--------|------------|------|------------------|
| blzt    |            | string | 办理状态   | 是   |                  |
| xmbh    |            | string | 项目编号   | 是   |                  |
| ajbh    |            | string | 案卷编号   | 是   |                  |
| ywlx    |            | string | 业务类型   | 是   |                  |
| xmmc    |            | string | 项目名称   | 是   |                  |
| zh      |            | string | 证号       | 是   |                  |
| zbks    |            | string | 主办科室   | 是   |                  |
| djsj    |            | string | 登记时间   | 是   |                  |
| workid  |            | string | 业务ID     | 是   |                  |
| fknode  |            | string | 节点ID     | 是   |                  |
| fid     |            | string | 父业务ID   | 是   |                  |
| formid  |            | string | 表单ID     | 是   |                  |

### 操作： 本局高级查询
----------

URL：/service/search/AdvancedDepartmentSearch.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| deptname      |    | string | 部门名       | 是   |      |
| xmmc        |    | string | 项目名称     | 否   |      |
| jbr         |    | string | 经办人       | 否   |      |
| ywlx        |    | string | 业务类型     | 否   |      |
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件       |
|-------------|----------------|-------------|------------------------------|------|---------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| resutls      |                | json数组    | 错误代码       | 否   | status为success  |

其中results数组中的每个对象

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件         |
|---------|------------|--------|------------|------|------------------|
| blzt    |            | string | 办理状态   | 是   |                  |
| xmbh    |            | string | 项目编号   | 是   |                  |
| ajbh    |            | string | 案卷编号   | 是   |                  |
| ywlx    |            | string | 业务类型   | 是   |                  |
| xmmc    |            | string | 项目名称   | 是   |                  |
| zh      |            | string | 证号       | 是   |                  |
| zbks    |            | string | 主办科室   | 是   |                  |
| djsj    |            | string | 登记时间   | 是   |                  |
| workid  |            | string | 业务ID     | 是   |                  |
| fknode  |            | string | 节点ID     | 是   |                  |
| fid     |            | string | 父业务ID   | 是   |                  |
| formid  |            | string | 表单ID     | 是   |                  |

### 操作： 高级综合查询
----------

URL：/service/search/AdvancedOrganizationSearch.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| xmmc        |    | string | 项目名称     | 否   |      |
| jbr         |    | string | 经办人       | 否   |      |
| ywlx        |    | string | 业务类型     | 否   |      |
| pageIndex   |    | string | 第几页       | 是   |		|
| pageSize    |    | string | 每页大小     | 是   |		|


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件       |
|-------------|----------------|-------------|------------------------------|------|---------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| resutls      |                | json数组    | 错误代码       | 否   | status为success  |

其中results数组中的每个对象

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件         |
|---------|------------|--------|------------|------|------------------|
| blzt    |            | string | 办理状态   | 是   |                  |
| xmbh    |            | string | 项目编号   | 是   |                  |
| ajbh    |            | string | 案卷编号   | 是   |                  |
| ywlx    |            | string | 业务类型   | 是   |                  |
| xmmc    |            | string | 项目名称   | 是   |                  |
| zh      |            | string | 证号       | 是   |                  |
| zbks    |            | string | 主办科室   | 是   |                  |
| djsj    |            | string | 登记时间   | 是   |                  |
| workid  |            | string | 业务ID     | 是   |                  |
| fknode  |            | string | 节点ID     | 是   |                  |
| fid     |            | string | 父业务ID   | 是   |                  |
| formid  |            | string | 表单ID     | 是   |                  |

## 法律法规
### 操作：法律法规查詢

URL：/service/search/QueryLaw.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认					   |
|-------------|----|----------|--------------|------|--------------------------|
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |	条件全为空，返回全部   |
| fgmc		  |    | string   | 法规名称     | 否   |						   |
| fgbh		  |    | string   | 法规编号     | 否   |						   |
| fxjg		  |    | string   | 发行机关     | 否   |						   |
| t1		  |    | string   | 发行时间从   | 否   |						   |
| t2		  |    | string   | 发行时间至   | 否   |						   |

返回值：

| 键      |      值    | 类型     | 描述       | 必须 | 存在条件 |
|---------|------------|----------|------------|------|----------|
| fgmc    |            | string   | 法规名称   | 是   |          |
| fgbh	  |            | string   | 法规编号   | 是   |          |
| fxjg	  |            | string   | 发行机关   | 是   |          |
| fxsj	  |            | string   | 发行时间   | 是   |          |
| fglb	  |            | string   | 法规类别   | 是   |          |
| info	  |            | string   | 备注       | 是   |          |
| name	  |            | string   | 附件名称   | 否   |          |
| size	  |            | string   | 附件大小   | 否   |          |
| path	  |            | string   | 附件路径   | 否   |          |

## 通知通告
### 操作：通知通告列表

URL：/service/search/GetNoticeList.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认					   |
|-------------|----|----------|--------------|------|--------------------------|
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |

返回值：

| 键			|      值    | 类型     | 描述			     | 必须 | 存在条件 |
|---------------|------------|----------|--------------------|------|----------|
| emergency     |            | string   | 1：紧急 0：不紧急  | 是   |          |
| noticename    |            | string   | 通知名称		     | 是   |          |
| releasedate   |            | string   | 发布时间			 | 是   |          |
| enddate	    |            | string   | 有效期限			 | 是   |          |
| orgname	    |            | string   | 发布处室			 | 是   |          |
| noticecontent	|            | string   | 主要内容  		 | 是   |          |
| name		    |            | string   | 附件名称			 | 否   |          |
| size		    |            | string   | 附件大小			 | 否   |          |
| path		    |            | string   | 附件路径			 | 否   |          |

## 会议
----------
### 操作：会议展示列表
----------

URL：/service/search/GetMeetList.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认					   |
|-------------|----|----------|--------------|------|--------------------------|
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |
| hymc		  |    | string   | 会议名称     | 否   |						   |
| hylx		  |    | string   | 会议类型     | 否   |						   |
| zzbm		  |    | string   | 组织部门     | 否   |						   |
| chry		  |    | string   | 参会人员     | 否   |						   |
| t1	 	  |    | string   | 开始时间     | 否   |						   |
| t2		  |    | string   | 结束时间     | 否   |						   |

返回值：

| 键			|      值    | 类型     | 描述			     | 必须 | 存在条件 |
|---------------|------------|----------|--------------------|------|----------|
| hymc		    |            | string   | 会议名称           | 是   |          |
| hybh		    |            | string   | 会议编号		     | 是   |          |
| hysj	    	|            | string   | 会议时间			 | 是   |          |
| hyzcr		    |            | string   | 会议主持人		 | 是   |          |
| hydd		    |            | string   | 会议地点			 | 是   |          |
| hylx			|            | string   | 会议类型  		 | 是   |          |
| hyry			|            | string   | 参会人员  		 | 是   |          |
| zzbm			|            | string   | 组织部门  		 | 是   |          |
| zzdw			|            | string   | 组织单位  		 | 是   |          |
| cjyr			|            | string   | 传纪要人  		 | 是   |          |
| jlr			|            | string   | 记录人    		 | 是   |          |
| kqr			|            | string   | 考勤人    		 | 是   |          |
| hynr			|            | string   | 会议内容  		 | 是   |          |
| name		    |            | string   | 附件名称			 | 否   |          |
| size		    |            | string   | 附件大小			 | 否   |          |
| path		    |            | string   | 附件路径			 | 否   |          |

## 新闻浏览
### 操作：新闻浏览列表
----------

URL：/service/search/GetNewsList.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认					   |
|-------------|----|----------|--------------|------|--------------------------|
| pageIndex   |    | string   | 第几页       | 是   |						   |
| pageSize    |    | string   | 每页大小     | 是   |						   |

返回值：

| 键			|      值    | 类型     | 描述			     | 必须 | 存在条件 |
|---------------|------------|----------|--------------------|------|----------|
| title		    |            | string   | 新闻名称           | 是   |          |
| brief		    |            | string   | 新闻简介		     | 是   |          |
| sender	   	|            | string   | 发布人			 | 是   |          |
| starttime     |            | string   | 发起时间  		 | 是   |          |
| newstype      |            | string   | 新闻类型  		 | 是   |          |
| endtime		|            | string   | 有效时间			 | 是   |          |
| content		|            | string   | 新闻内容  		 | 是   |          |

## 用户
----------
### 操作：修改密码
----------

URL：/service/user/ModifyPassword.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认					   |
|-------------|----|----------|--------------|------|--------------------------|
| token       |    | string   | 令牌         | 是   |						   |
| oldPassword |    | string   | 旧密码       | 是   |						   |
| newPassword |    | string   | 新密码       | 是   |						   |

返回值：

| 键          | 值             | 类型        | 描述         | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------|------|-----------------|
| status      | success/failed | string      | 状态         | 是   |                 |
| errorNo     |                | int         | 错误代码     | 否   | status为failed  |

### 操作：意见反馈
----------

URL：/service/user/Feedback.ashx

参数：

| 键          | 值 | 类型     | 描述                       | 必须 | 默认			 |
|-------------|----|----------|----------------------------|------|------------------|
| content     |    | string   | 意见内容                   | 是   |					 |
| token       |    | string   | 令牌，有令牌表示非匿名提交 | 否   |					 |

返回值：

| 键          | 值             | 类型        | 描述         | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------|------|-----------------|
| status      | success/failed | string      | 状态         | 是   |                 |
| errorNo     |                | int         | 错误代码     | 否   | status为failed  |

## 推送

###~~ 操作：推送的离线消息已接收~~
----------

URL：/service/message/push/EchoOver.ashx

参数：

| 键          | 值 | 类型     | 描述                       | 必须 | 默认			 |
|-------------|----|----------|----------------------------|------|------------------|
| token       |    | string   | 令牌，有令牌表示非匿名提交 | 是   |					 |
| offlineMessageId     |    | long   | 离线消息ID          | 是   |					 |

返回值：

| 键          | 值             | 类型        | 描述         | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------|------|-----------------|
| status      | success/failed | string      | 状态         | 是   |                 |
| errorNo     |                | int         | 错误代码     | 否   | status为failed  |

说明：
离线消息会有12小时的有效时间，如果用户离线12小时，个推不再发送该条消息。
如果没有反馈给服务器已接收，服务器会重新发送一条新的离线消息给个推服务器，直到消息已读。

### 离线消息格式
----------

| 键          | 值 | 类型     | 描述                       | 必须 | 默认			 |
|-------------|----|----------|----------------------------|------|------------------|
| content     |    | string   | 消息内容                   | 是   |					 |
| messageId     |    | long   | 消息ID                   | 是   |					 |
| unreadMessageNum     |    | int   | 未读消息总数                   | 是   |					 |

### 操作：绑定用户设备

URL：/service/message/push/BindUserDevice.ashx

参数：

| 键         | 值         | 类型   | 描述                          | 必须 |
|------------|------------|--------|-------------------------------|------|
| token      |            | string | 令牌                          | 是   |
| clientId   |            | string | 个推的clientID                | 是   |
| iOS        |            | string | 是否是iOS                     | 否   |

返回值：

| 键          | 值             | 类型        | 描述         | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------|------|-----------------|
| status      | success/failed | string      | 状态         | 是   |                 |
| errorNo     |                | int         | 错误代码     | 否   | status为failed  |

## 其它

### 操作： 打开附件（法律法规、通知通告、会议展示）

URL：/service/search/PreviewFile.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| path        |    | string | 附件路径     | 是   |      |
| name        |    | string | 附件名称     | 是   |      |

返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件                                                   |
|-------------|----------------|-------------|------------------------------|------|------------------------------------------------------------|
| urlpath     |                | 数组        | 图片地址                     | 否   |  图片或word会返回图片地址，TXT直接返回文本，pdf返回下载地址|

### 操作： 阅读文件

URL：/service/form/ReadFile.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| filepath    |    | string | 文件路径     | 是   |      |
| filetype    |    | string | 文件格式     | 是   |      |
| id          |    | string | 材料文件ID   | 是   |      |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件                                                   |
|-------------|----------------|-------------|------------------------------|------|------------------------------------------------------------|
| urlpath     |                | 数组        | 图片地址                     | 否   |  图片或word会返回图片地址，TXT直接返回文本，pdf返回下载地址|

### 操作：获取业务类型

URL：/service/form/GetFlowName.ashx

参数：

| 键          | 值 | 类型     | 描述         | 必须 | 默认             |
|-------------|----|----------|--------------|------|------------------|
| metatype    |    | string   | 元数据类型   | 是   |  0:业务、1:公文  |

返回值：

| 键      |      值    | 类型   | 描述       | 必须 | 存在条件 |
|---------|------------|--------|------------|------|----------|
| results |            | 数组   | 业务类型   | 是   |          |

### 操作： 拟文阅读word文件
----------

URL：/service/form/GetWordFile.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| workId      |    | string | 业务ID       | 是   |      |
| fkFlow     |    | string | 流程ID       | 是   |      |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件                                                   |
|-------------|----------------|-------------|------------------------------|------|---------------|
| urlpath     |                | 数组        | 图片地址                     | 否   |               |

### 操作： 获取移动权限
----------

URL：/service/privilege/GetPrivilege.ashx

参数：

| 键          | 值 | 类型   | 描述         | 必须 | 默认 |
|-------------|----|--------|--------------|------|------|
| token      |    | string | 令牌       | 是   |      |


返回值：

| 键          | 值             | 类型        | 描述                         | 必须 | 存在条件       |
|-------------|----------------|-------------|------------------------------|------|---------------|
| status       | success/failed | string | 登录成功，失败 | 是   |                 |
| errorNo      |                | int    | 错误代码       | 否   | status为failed  |
| privilege   |                | json数组 | 权限集合       | 否   | status为success       |

说明：

所有权限

|	名称		|
|-----------|
|一张图|
|本人查询|
|本局查询|
|综合查询|

### 操作：填写收阅意见
---------

URL：/service/form/ReplyOpinion.ashx

参数：

| 键         | 值         | 类型   | 描述                          | 必须 |
|------------|------------|--------|-------------------------------|------|
| messageId  |            | string | 消息ID                          | 是   |
| fileId   |            | string | 文件ID                | 是   |
| content        |            | string | 内容                     | 否   |

返回值：

| 键          | 值             | 类型        | 描述         | 必须 | 存在条件        |
|-------------|----------------|-------------|--------------|------|-----------------|
| status      | success/failed | string      | 状态         | 是   |                 |
