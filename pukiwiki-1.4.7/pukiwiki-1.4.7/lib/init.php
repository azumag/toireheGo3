<?php
// PukiWiki - Yet another WikiWikiWeb clone.
// $Id: init.php,v 1.46 2006/06/11 15:04:27 henoheno Exp $
// Copyright (C)
//   2002-2006 PukiWiki Developers Team
//   2001-2002 Originally written by yu-ji
// License: GPL v2 or (at your option) any later version
//
// Init PukiWiki here

// PukiWiki version / Copyright / Licence

define('S_VERSION', '1.4.7');
define('S_COPYRIGHT',
	'<strong>PukiWiki ' . S_VERSION . '</strong>' .
	' Copyright &copy; 2001-2006' .
	' <a href="http://pukiwiki.sourceforge.jp/">PukiWiki Developers Team</a>.' .
	' License is <a href="http://www.gnu.org/licenses/gpl.html">GPL</a>.<br />' .
	' Based on "PukiWiki" 1.3 by <a href="http://factage.com/yu-ji/">yu-ji</a>'
);

/////////////////////////////////////////////////
// Init server variables

foreach (array('SCRIPT_NAME', 'SERVER_ADMIN', 'SERVER_NAME',
	'SERVER_PORT', 'SERVER_SOFTWARE') as $key) {
	define($key, isset($_SERVER[$key]) ? $_SERVER[$key] : '');
	unset(${$key}, $_SERVER[$key], $HTTP_SERVER_VARS[$key]);
}

/////////////////////////////////////////////////
// Init grobal variables

$foot_explain = array();	// Footnotes
$related      = array();	// Related pages
$head_tags    = array();	// XHTML tags in <head></head>

/////////////////////////////////////////////////
// Time settings

define('LOCALZONE', date('Z'));
define('UTIME', time() - LOCALZONE);
define('MUTIME', getmicrotime());

/////////////////////////////////////////////////
// Require INI_FILE

define('INI_FILE',  DATA_HOME . 'pukiwiki.ini.php');
$die = '';
if (! file_exists(INI_FILE) || ! is_readable(INI_FILE)) {
	$die .= 'File is not found. (INI_FILE)' . "\n";
} else {
	require(INI_FILE);
}
if ($die) die_message(nl2br("\n\n" . $die));

/////////////////////////////////////////////////
// INI_FILE: LANG �˴�Ť����󥳡��ǥ�������

// MB_LANGUAGE: mb_language (for mbstring extension)
//   'uni'(means UTF-8), 'English', or 'Japanese'
// SOURCE_ENCODING: Internal content encoding (for mbstring extension)
//   'UTF-8', 'ASCII', or 'EUC-JP'
// CONTENT_CHARSET: Internal content encoding = Output content charset (for skin)
//   'UTF-8', 'iso-8859-1', 'EUC-JP' or ...

switch (LANG){
case 'en': define('MB_LANGUAGE', 'English' ); break;
case 'ja': define('MB_LANGUAGE', 'Japanese'); break;
//UTF-8:case 'ko': define('MB_LANGUAGE', 'Korean'  ); break;
//UTF-8:	// See BugTrack2/13 for all hack about Korean support,
//UTF-8:	// and give us your report!
default: die_message('No such language "' . LANG . '"'); break;
}

//UTF-8:define('PKWK_UTF8_ENABLE', 1);
if (defined('PKWK_UTF8_ENABLE')) {
	define('SOURCE_ENCODING', 'UTF-8');
	define('CONTENT_CHARSET', 'UTF-8');
} else {
	switch (LANG){
	case 'en':
		define('SOURCE_ENCODING', 'ASCII');
		define('CONTENT_CHARSET', 'iso-8859-1');
		break;
	case 'ja':
		define('SOURCE_ENCODING', 'EUC-JP');
		define('CONTENT_CHARSET', 'EUC-JP');
		break;
	}
}

mb_language(MB_LANGUAGE);
mb_internal_encoding(SOURCE_ENCODING);
ini_set('mbstring.http_input', 'pass');
mb_http_output('pass');
mb_detect_order('auto');

/////////////////////////////////////////////////
// INI_FILE: Require LANG_FILE

define('LANG_FILE_HINT', DATA_HOME . LANG . '.lng.php');	// For encoding hint
define('LANG_FILE',      DATA_HOME . UI_LANG . '.lng.php');	// For UI resource
$die = '';
foreach (array('LANG_FILE_HINT', 'LANG_FILE') as $langfile) {
	if (! file_exists(constant($langfile)) || ! is_readable(constant($langfile))) {
		$die .= 'File is not found or not readable. (' . $langfile . ')' . "\n";
	} else {
		require_once(constant($langfile));
	}
}
if ($die) die_message(nl2br("\n\n" . $die));

/////////////////////////////////////////////////
// LANG_FILE: Init encoding hint

define('PKWK_ENCODING_HINT', isset($_LANG['encode_hint'][LANG]) ? $_LANG['encode_hint'][LANG] : '');
unset($_LANG['encode_hint']);

/////////////////////////////////////////////////
// LANG_FILE: Init severn days of the week

$weeklabels = $_msg_week;

/////////////////////////////////////////////////
// INI_FILE: Init $script

if (isset($script)) {
	get_script_uri($script); // Init manually
} else {
	$script = get_script_uri(); // Init automatically
}

/////////////////////////////////////////////////
// INI_FILE: $agents:  UserAgent�μ���

$ua = 'HTTP_USER_AGENT';
$user_agent = $matches = array();

$user_agent['agent'] = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '';
unset(${$ua}, $_SERVER[$ua], $HTTP_SERVER_VARS[$ua], $ua);	// safety

foreach ($agents as $agent) {
	if (preg_match($agent['pattern'], $user_agent['agent'], $matches)) {
		$user_agent['profile'] = isset($agent['profile']) ? $agent['profile'] : '';
		$user_agent['name']    = isset($matches[1]) ? $matches[1] : '';	// device or browser name
		$user_agent['vers']    = isset($matches[2]) ? $matches[2] : ''; // 's version
		break;
	}
}
unset($agents, $matches);

// Profile-related init and setting
define('UA_PROFILE', isset($user_agent['profile']) ? $user_agent['profile'] : '');

define('UA_INI_FILE', DATA_HOME . UA_PROFILE . '.ini.php');
if (! file_exists(UA_INI_FILE) || ! is_readable(UA_INI_FILE)) {
	die_message('UA_INI_FILE for "' . UA_PROFILE . '" not found.');
} else {
	require(UA_INI_FILE); // Also manually
}

define('UA_NAME', isset($user_agent['name']) ? $user_agent['name'] : '');
define('UA_VERS', isset($user_agent['vers']) ? $user_agent['vers'] : '');
unset($user_agent);	// Unset after reading UA_INI_FILE

/////////////////////////////////////////////////
// �ǥ��쥯�ȥ�Υ����å�

$die = '';
foreach(array('DATA_DIR', 'DIFF_DIR', 'BACKUP_DIR', 'CACHE_DIR') as $dir){
	if (! is_writable(constant($dir)))
		$die .= 'Directory is not found or not writable (' . $dir . ')' . "\n";
}

// ����ե�������ѿ������å�
$temp = '';
foreach(array('rss_max', 'page_title', 'note_hr', 'related_link', 'show_passage',
	'rule_related_str', 'load_template_func') as $var){
	if (! isset(${$var})) $temp .= '$' . $var . "\n";
}
if ($temp) {
	if ($die) $die .= "\n";	// A breath
	$die .= 'Variable(s) not found: (Maybe the old *.ini.php?)' . "\n" . $temp;
}

$temp = '';
foreach(array('LANG', 'PLUGIN_DIR') as $def){
	if (! defined($def)) $temp .= $def . "\n";
}
if ($temp) {
	if ($die) $die .= "\n";	// A breath
	$die .= 'Define(s) not found: (Maybe the old *.ini.php?)' . "\n" . $temp;
}

if($die) die_message(nl2br("\n\n" . $die));
unset($die, $temp);

/////////////////////////////////////////////////
// ɬ�ܤΥڡ�����¸�ߤ��ʤ���С����Υե�������������

foreach(array($defaultpage, $whatsnew, $interwiki) as $page){
	if (! is_page($page)) touch(get_filename($page));
}

/////////////////////////////////////////////////
// �������餯���ѿ��Υ����å�

// Prohibit $_GET attack
foreach (array('msg', 'pass') as $key) {
	if (isset($_GET[$key])) die_message('Sorry, already reserved: ' . $key . '=');
}

// Expire risk
unset($HTTP_GET_VARS, $HTTP_POST_VARS);	//, 'SERVER', 'ENV', 'SESSION', ...
unset($_REQUEST);	// Considered harmful

// Remove null character etc.
$_GET    = input_filter($_GET);
$_POST   = input_filter($_POST);
$_COOKIE = input_filter($_COOKIE);

// ʸ���������Ѵ� ($_POST)
// <form> ���������줿ʸ�� (�֥饦�������󥳡��ɤ����ǡ���) �Υ����ɤ��Ѵ�
// POST method �Ͼ�� form ��ͳ�ʤΤǡ�ɬ���Ѵ�����
//
if (isset($_POST['encode_hint']) && $_POST['encode_hint'] != '') {
	// do_plugin_xxx() ����ǡ�<form> �� encode_hint ��Ź���Ǥ���Τǡ�
	// encode_hint ���Ѥ��ƥ����ɸ��Ф��롣
	// ���Τ򸫤ƥ����ɸ��Ф���ȡ������¸ʸ���䡢̯�ʥХ��ʥ�
	// �����ɤ������������ˡ������ɸ��Ф˼��Ԥ��붲�줬���롣
	$encode = mb_detect_encoding($_POST['encode_hint']);
	mb_convert_variables(SOURCE_ENCODING, $encode, $_POST);

} else if (isset($_POST['charset']) && $_POST['charset'] != '') {
	// TrackBack Ping �ǻ��ꤵ��Ƥ��뤳�Ȥ�����
	// ���ޤ������ʤ����ϼ�ư���Ф��ڤ��ؤ�
	if (mb_convert_variables(SOURCE_ENCODING,
	    $_POST['charset'], $_POST) !== $_POST['charset']) {
		mb_convert_variables(SOURCE_ENCODING, 'auto', $_POST);
	}

} else if (! empty($_POST)) {
	// �����ޤȤ�ơ���ư���С��Ѵ�
	mb_convert_variables(SOURCE_ENCODING, 'auto', $_POST);
}

// ʸ���������Ѵ� ($_GET)
// GET method �� form ����ξ��ȡ�<a href="http://script/?key=value> �ξ�礬����
// <a href...> �ξ��ϡ������С��� rawurlencode ���Ƥ���Τǡ��������Ѵ�������
if (isset($_GET['encode_hint']) && $_GET['encode_hint'] != '')
{
	// form ��ͳ�ξ��ϡ��֥饦�������󥳡��ɤ��Ƥ���Τǡ������ɸ��С��Ѵ���ɬ�ס�
	// encode_hint ���ޤޤ�Ƥ���Ϥ��ʤΤǡ�����򸫤ơ������ɸ��Ф����塢�Ѵ����롣
	// ��ͳ�ϡ�post ��Ʊ��
	$encode = mb_detect_encoding($_GET['encode_hint']);
	mb_convert_variables(SOURCE_ENCODING, $encode, $_GET);
}


/////////////////////////////////////////////////
// QUERY_STRING�����

// cmd��plugin����ꤵ��Ƥ��ʤ����ϡ�QUERY_STRING��
// �ڡ���̾��InterWikiName�Ǥ���Ȥߤʤ�
$arg = '';
if (isset($_SERVER['QUERY_STRING']) && $_SERVER['QUERY_STRING']) {
	$arg = & $_SERVER['QUERY_STRING'];
} else if (isset($_SERVER['argv']) && ! empty($_SERVER['argv'])) {
	$arg = & $_SERVER['argv'][0];
}
if (PKWK_QUERY_STRING_MAX && strlen($arg) > PKWK_QUERY_STRING_MAX) {
	// Something nasty attack?
	pkwk_common_headers();
	sleep(1);	// Fake processing, and/or process other threads
	echo('Query string too long');
	exit;
}
$arg = input_filter($arg); // \0 ����

// unset QUERY_STRINGs
foreach (array('QUERY_STRING', 'argv', 'argc') as $key) {
	unset(${$key}, $_SERVER[$key], $HTTP_SERVER_VARS[$key]);
}
// $_SERVER['REQUEST_URI'] is used at func.php NOW
unset($REQUEST_URI, $HTTP_SERVER_VARS['REQUEST_URI']);

// mb_convert_variables�ΥХ�(?)�к�: ������Ϥ��ʤ��������
$arg = array($arg);
mb_convert_variables(SOURCE_ENCODING, 'auto', $arg);
$arg = $arg[0];

/////////////////////////////////////////////////
// QUERY_STRING��ʬ�򤷤ƥ������Ѵ�����$_GET �˾��

// URI �� urlencode ���������Ϥ��������н褹��
$matches = array();
foreach (explode('&', $arg) as $key_and_value) {
	if (preg_match('/^([^=]+)=(.+)/', $key_and_value, $matches) &&
	    mb_detect_encoding($matches[2]) != 'ASCII') {
		$_GET[$matches[1]] = $matches[2];
	}
}
unset($matches);

/////////////////////////////////////////////////
// GET, POST, COOKIE

$get    = & $_GET;
$post   = & $_POST;
$cookie = & $_COOKIE;

// GET + POST = $vars
if (empty($_POST)) {
	$vars = & $_GET;  // Major pattern: Read-only access via GET
} else if (empty($_GET)) {
	$vars = & $_POST; // Minor pattern: Write access via POST etc.
} else {
	$vars = array_merge($_GET, $_POST); // Considered reliable than $_REQUEST
}

// ���ϥ����å�: 'cmd=' and 'plugin=' can't live together
if (isset($vars['cmd']) && isset($vars['plugin']))
	die('Using both cmd= and plugin= is not allowed');

// ���ϥ����å�: cmd, plugin ��ʸ����ϱѿ����ʳ����ꤨ�ʤ�
foreach(array('cmd', 'plugin') as $var) {
	if (isset($vars[$var]) && ! preg_match('/^[a-zA-Z][a-zA-Z0-9_]*$/', $vars[$var]))
		unset($get[$var], $post[$var], $vars[$var]);
}

// ����: page, strip_bracket()
if (isset($vars['page'])) {
	$get['page'] = $post['page'] = $vars['page']  = strip_bracket($vars['page']);
} else {
	$get['page'] = $post['page'] = $vars['page'] = '';
}

// ����: msg, ���Ԥ������
if (isset($vars['msg'])) {
	$get['msg'] = $post['msg'] = $vars['msg'] = str_replace("\r", '', $vars['msg']);
}

// �����ߴ��� (?md5=...)
if (isset($get['md5']) && $get['md5'] != '' &&
    ! isset($vars['cmd']) && ! isset($vars['plugin'])) {
	$get['cmd'] = $post['cmd'] = $vars['cmd'] = 'md5';
}

// TrackBack Ping
if (isset($vars['tb_id']) && $vars['tb_id'] != '') {
	$get['cmd'] = $post['cmd'] = $vars['cmd'] = 'tb';
}

// cmd��plugin����ꤵ��Ƥ��ʤ����ϡ�QUERY_STRING��ڡ���̾��InterWikiName�Ǥ���Ȥߤʤ�
if (! isset($vars['cmd']) && ! isset($vars['plugin'])) {

	$get['cmd']  = $post['cmd']  = $vars['cmd']  = 'read';

	if ($arg == '') $arg = $defaultpage;
	$arg = rawurldecode($arg);
	$arg = strip_bracket($arg);
	$arg = input_filter($arg);
	$get['page'] = $post['page'] = $vars['page'] = $arg;
}

/////////////////////////////////////////////////
// �������($WikiName,$BracketName�ʤ�)
// $WikiName = '[A-Z][a-z]+(?:[A-Z][a-z]+)+';
// $WikiName = '\b[A-Z][a-z]+(?:[A-Z][a-z]+)+\b';
// $WikiName = '(?<![[:alnum:]])(?:[[:upper:]][[:lower:]]+){2,}(?![[:alnum:]])';
// $WikiName = '(?<!\w)(?:[A-Z][a-z]+){2,}(?!\w)';

// BugTrack/304�����н�
$WikiName = '(?:[A-Z][a-z]+){2,}(?!\w)';

// $BracketName = ':?[^\s\]#&<>":]+:?';
$BracketName = '(?!\s):?[^\r\n\t\f\[\]<>#&":]+:?(?<!\s)';

// InterWiki
$InterWikiName = '(\[\[)?((?:(?!\s|:|\]\]).)+):(.+)(?(1)\]\])';

// ����
$NotePattern = '/\(\(((?:(?>(?:(?!\(\()(?!\)\)(?:[^\)]|$)).)+)|(?R))*)\)\)/ex';

/////////////////////////////////////////////////
// �������(�桼������롼���ɤ߹���)
require(DATA_HOME . 'rules.ini.php');

/////////////////////////////////////////////////
// �������(����¾�Υ������Х��ѿ�)

// ���߻���
$now = format_date(UTIME);

// �����ִ��롼���$line_rules�˲ä���
if ($usedatetime) $line_rules += $datetime_rules;
unset($datetime_rules);

// �ե������ޡ�����$line_rules�˲ä���
if ($usefacemark) $line_rules += $facemark_rules;
unset($facemark_rules);

// ���λ��ȥѥ����󤪤�ӥ����ƥ�ǻ��Ѥ���ѥ������$line_rules�˲ä���
//$entity_pattern = '[a-zA-Z0-9]{2,8}';
$entity_pattern = trim(join('', file(CACHE_DIR . 'entities.dat')));

$line_rules = array_merge(array(
	'&amp;(#[0-9]+|#x[0-9a-f]+|' . $entity_pattern . ');' => '&$1;',
	"\r"          => '<br />' . "\n",	/* �����˥�����ϲ��� */
), $line_rules);

?>