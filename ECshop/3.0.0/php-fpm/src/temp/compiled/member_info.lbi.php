<div id="append_parent"></div>
<?php if ($this->_var['user_info']): ?> <font > <?php echo $this->_var['lang']['hello']; ?>，<font class="f4_b"><?php echo $this->_var['user_info']['username']; ?></font>, <?php echo $this->_var['lang']['welcome_return']; ?>！ <a href="user.php"><?php echo $this->_var['lang']['user_center']; ?></a>| <a href="user.php?act=logout"><?php echo $this->_var['lang']['user_logout']; ?></a> </font> <?php else: ?>
 <?php echo $this->_var['lang']['welcome']; ?><a href="user.php">请登录 <strong></strong></a>&nbsp;|&nbsp;&nbsp;<a href="user.php?act=register">免费注册</a> <?php endif; ?>