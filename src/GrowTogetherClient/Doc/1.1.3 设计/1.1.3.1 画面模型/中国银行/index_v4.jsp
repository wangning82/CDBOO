<!DOCTYPE html>
<!-- saved from url=(0041)http://www.zi-han.net/theme/hplus/?v=4.1# -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp">
  <title>页</title>
  <!--[if lt IE 9]>
  <meta http-equiv="refresh" content="0;ie.html" />
  <![endif]-->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.metisMenu.js"></script>
<script src="js/jquery.slimscroll.min.js"></script>
<script src="js/layer.min.js"></script>
<script src="js/hplus.min.js"></script>
<script type="text/javascript" src="js/contabs.min.js"></script>
<script src="js/pace.min.js"></script>
<link rel="stylesheet" href="src/font/typicons.min.css">
<link rel="stylesheet" href="src/font/typicons.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css" id="layui_layer_skinmoonstylecss">
</head>

<body >
  <div class="body_s">
     <div style="margin-top:10px;">
<div class="row">
                    <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>表单 <small>包括自定义样式的复选和单选按钮</small></h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="form_basic.html#">
                                        <i class="fa fa-wrench"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-user">
                                        <li><a href="form_basic.html#">选项1</a>
                                        </li>
                                        <li><a href="form_basic.html#">选项2</a>
                                        </li>
                                    </ul>
                                    <a class="close-link">
                                        <i class="fa fa-times"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <form method="get" class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">普通</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">带说明信息</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control"> <span class="help-block m-b-none">帮助文本，可能会超过一行，以块级元素显示</span>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">密码</label>

                                        <div class="col-sm-10">
                                            <input type="password" class="form-control" name="password">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">提示</label>

                                        <div class="col-sm-10">
                                            <input type="text" placeholder="提示信息" class="form-control">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">禁用</label>

                                        <div class="col-lg-10">
                                            <input type="text" disabled="" placeholder="已被禁用" class="form-control">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">静态控制</label>

                                        <div class="col-lg-10">
                                            <p class="form-control-static">i@zi-han.net</p>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">复选框&单选框
                                            <br/>
                                            <small class="text-navy">普通Bootstrap元素</small>
                                        </label>

                                        <div class="col-sm-10">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" value="">选项1</label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" checked="" value="option1" id="optionsRadios1" name="optionsRadios">选项1</label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" value="option2" id="optionsRadios2" name="optionsRadios">选项2</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">内联复选框</label>

                                        <div class="col-sm-10">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" value="option1" id="inlineCheckbox1">a</label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" value="option2" id="inlineCheckbox2">b</label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" value="option3" id="inlineCheckbox3">c</label>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">复选框&单选框
                                            <br/><small class="text-navy">自定义样式</small>
                                        </label>

                                        <div class="col-sm-10">
                                            <div class="checkbox i-checks">
                                                <label>
                                                    <input type="checkbox" value=""> <i></i> 选项1</label>
                                            </div>
                                            <div class="checkbox i-checks">
                                                <label>
                                                    <input type="checkbox" value="" checked=""> <i></i> 选项2（选中）</label>
                                            </div>
                                            <div class="checkbox i-checks">
                                                <label>
                                                    <input type="checkbox" value="" disabled="" checked=""> <i></i> 选项3（选中并禁用）</label>
                                            </div>
                                            <div class="checkbox i-checks">
                                                <label>
                                                    <input type="checkbox" value="" disabled=""> <i></i> 选项4（禁用）</label>
                                            </div>
                                            <div class="radio i-checks">
                                                <label>
                                                    <input type="radio" value="option1" name="a"> <i></i> 选项1</label>
                                            </div>
                                            <div class="radio i-checks">
                                                <label>
                                                    <input type="radio" checked="" value="option2" name="a"> <i></i> 选项2（选中）</label>
                                            </div>
                                            <div class="radio i-checks">
                                                <label>
                                                    <input type="radio" disabled="" checked="" value="option2"> <i></i> 选项3（选中并禁用）</label>
                                            </div>
                                            <div class="radio i-checks">
                                                <label>
                                                    <input type="radio" disabled="" name="a"> <i></i> 选项4（禁用）</label>
                                            </div>
                                        </div>
                                    </div>
                              
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Select</label>

                                        <div class="col-sm-10">
                                            <select class="form-control m-b" name="account">
                                                <option>选项 1</option>
                                                <option>选项 2</option>
                                                <option>选项 3</option>
                                                <option>选项 4</option>
                                            </select>

                                            <div class="col-lg-4 m-l-n">
                                                <select class="form-control" multiple="">
                                                    <option>选项 1</option>
                                                    <option>选项 2</option>
                                                    <option>选项 3</option>
                                                    <option>选项 4</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group has-success">
                                        <label class="col-sm-2 control-label">验证通过</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group has-warning">
                                        <label class="col-sm-2 control-label">未填写</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group has-error">
                                        <label class="col-sm-2 control-label">验证未通过</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">自定义尺寸</label>

                                        <div class="col-sm-10">
                                            <input type="text" placeholder=".input-lg" class="form-control input-lg m-b">
                                            <input type="text" placeholder="Default input" class="form-control m-b">
                                            <input type="text" placeholder=".input-sm" class="form-control input-sm">
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">列尺寸</label>

                                        <div class="col-sm-10">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <input type="text" placeholder=".col-md-2" class="form-control">
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" placeholder=".col-md-3" class="form-control">
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="text" placeholder=".col-md-4" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">文本框组</label>

                                        <div class="col-sm-10">
                                            <div class="input-group m-b"><span class="input-group-addon">@</span> 
                                                <input type="text" placeholder="用户名" class="form-control">
                                            </div>
                                            <div class="input-group m-b">
                                                <input type="text" class="form-control"> <span class="input-group-addon">.00</span>
                                            </div>
                                            <div class="input-group m-b"><span class="input-group-addon">&yen;</span> 
                                                <input type="text" class="form-control"> <span class="input-group-addon">.00</span>
                                            </div>
                                            <div class="input-group m-b"><span class="input-group-addon"> <input type="checkbox"> </span> 
                                                <input type="text" class="form-control">
                                            </div>
                                            <div class="input-group"><span class="input-group-addon"> <input type="radio"> </span> 
                                                <input type="text" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">按钮插件</label>

                                        <div class="col-sm-10">
                                            <div class="input-group m-b"><span class="input-group-btn">
                                            <button type="button" class="btn btn-primary">搜</button> </span> 
                                                <input type="text" class="form-control">
                                            </div>
                                            <div class="input-group">
                                                <input type="text" class="form-control"> <span class="input-group-btn"> <button type="button" class="btn btn-primary">搜索
                                        </button> </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">带下拉框</label>

                                        <div class="col-sm-10">
                                            <div class="input-group m-b">
                                                <div class="input-group-btn">
                                                    <button data-toggle="dropdown" class="btn btn-white dropdown-toggle" type="button">操作 <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="form_basic.html#">选项1</a>
                                                        </li>
                                                        <li><a href="form_basic.html#">选项2</a>
                                                        </li>
                                                        <li><a href="form_basic.html#">选项3</a>
                                                        </li>
                                                        <li class="divider"></li>
                                                        <li><a href="form_basic.html#">选项4</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <input type="text" class="form-control">
                                            </div>
                                            <div class="input-group">
                                                <input type="text" class="form-control">

                                                <div class="input-group-btn">
                                                    <button data-toggle="dropdown" class="btn btn-white dropdown-toggle" type="button">操作 <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu pull-right">
                                                        <li><a href="form_basic.html#">选项1</a>
                                                        </li>
                                                        <li><a href="form_basic.html#">选项2</a>
                                                        </li>
                                                        <li><a href="form_basic.html#">选项3</a>
                                                        </li>
                                                        <li class="divider"></li>
                                                        <li><a href="form_basic.html#">选项4</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">分段</label>

                                        <div class="col-sm-10">
                                            <div class="input-group m-b">
                                                <div class="input-group-btn">
                                                    <button tabindex="-1" class="btn btn-white" type="button">操作</button>
                                                    <button data-toggle="dropdown" class="btn btn-white dropdown-toggle" type="button"><span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="form_basic.html#">选项1</a>
                                                        </li>
                                                        <li><a href="form_basic.html#">选项2</a>
                                                        </li>
                                                        <li><a href="form_basic.html#">选项3</a>
                                                        </li>
                                                        <li class="divider"></li>
                                                        <li><a href="form_basic.html#">选项4</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <input type="text" class="form-control">
                                            </div>
                                            <div class="input-group">
                                                <input type="text" class="form-control">

                                                <div class="input-group-btn">
                                                    <button tabindex="-1" class="btn btn-white" type="button">操作</button>
                                                    <button data-toggle="dropdown" class="btn btn-white dropdown-toggle" type="button"><span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu pull-right">
                                                        分段
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <div class="col-sm-4 col-sm-offset-2">
                                            <button class="btn btn-primary" type="submit">保存内容</button>
                                            <button class="btn btn-white" type="submit">取消</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
               

                </div>
               
</body></html>