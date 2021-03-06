/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'Solar\'">' + entity + '</span>' + html;
	}
	var icons = {
			'icon-warning' : '&#xe000;',
			'icon-checkmark' : '&#xe001;',
			'icon-info' : '&#xe002;',
			'icon-help' : '&#xe003;',
			'icon-question' : '&#xe004;',
			'icon-info-2' : '&#xe005;',
			'icon-mail' : '&#xe006;',
			'icon-paperplane' : '&#xe007;',
			'icon-edit' : '&#xe008;',
			'icon-paperclip' : '&#xe009;',
			'icon-reply' : '&#xe00a;',
			'icon-reply-all' : '&#xe00b;',
			'icon-forward' : '&#xe00c;',
			'icon-user' : '&#xe00d;',
			'icon-user-add' : '&#xe00f;',
			'icon-vcard' : '&#xe010;',
			'icon-export' : '&#xe011;',
			'icon-location' : '&#xe013;',
			'icon-share' : '&#xe014;',
			'icon-heart' : '&#xe015;',
			'icon-heart-2' : '&#xe016;',
			'icon-star' : '&#xe017;',
			'icon-star-2' : '&#xe018;',
			'icon-thumbs-up' : '&#xe019;',
			'icon-thumbs-down' : '&#xe01a;',
			'icon-chat' : '&#xe01b;',
			'icon-comment' : '&#xe01c;',
			'icon-quote' : '&#xe01d;',
			'icon-house' : '&#xe01e;',
			'icon-popup' : '&#xe01f;',
			'icon-search' : '&#xe020;',
			'icon-printer' : '&#xe021;',
			'icon-bell' : '&#xe022;',
			'icon-link' : '&#xe023;',
			'icon-flag' : '&#xe024;',
			'icon-settings' : '&#xe025;',
			'icon-tools' : '&#xe026;',
			'icon-tag' : '&#xe027;',
			'icon-camera' : '&#xe028;',
			'icon-music' : '&#xe029;',
			'icon-music-2' : '&#xe02a;',
			'icon-book' : '&#xe02c;',
			'icon-lesson' : '&#xe02d;',
			'icon-lifebuoy' : '&#xe02e;',
			'icon-eye' : '&#xe02f;',
			'icon-clock' : '&#xe030;',
			'icon-microphone' : '&#xe031;',
			'icon-calendar' : '&#xe032;',
			'icon-briefcase' : '&#xe033;',
			'icon-hourglass' : '&#xe035;',
			'icon-language' : '&#xe036;',
			'icon-key' : '&#xe038;',
			'icon-suitcase' : '&#xe039;',
			'icon-earth' : '&#xe03a;',
			'icon-keyboard' : '&#xe03b;',
			'icon-browser' : '&#xe03c;',
			'icon-publish' : '&#xe03d;',
			'icon-adjust' : '&#xe03e;',
			'icon-sun' : '&#xe03f;',
			'icon-code' : '&#xe040;',
			'icon-screen' : '&#xe041;',
			'icon-credit-card' : '&#xe043;',
			'icon-database' : '&#xe044;',
			'icon-rss' : '&#xe045;',
			'icon-signal' : '&#xe046;',
			'icon-lock' : '&#xe04b;',
			'icon-lock-open' : '&#xe04c;',
			'icon-logout' : '&#xe04d;',
			'icon-login' : '&#xe04e;',
			'icon-cross' : '&#xe04f;',
			'icon-plus' : '&#xe050;',
			'icon-minus' : '&#xe051;',
			'icon-cross-2' : '&#xe052;',
			'icon-minus-2' : '&#xe053;',
			'icon-plus-2' : '&#xe054;',
			'icon-cross-3' : '&#xe055;',
			'icon-minus-3' : '&#xe056;',
			'icon-plus-3' : '&#xe057;',
			'icon-erase' : '&#xe058;',
			'icon-blocked' : '&#xe059;',
			'icon-cycle' : '&#xe05a;',
			'icon-shuffle' : '&#xe05b;',
			'icon-cw' : '&#xe05d;',
			'icon-arrow' : '&#xe05e;',
			'icon-arrow-2' : '&#xe05f;',
			'icon-retweet' : '&#xe060;',
			'icon-loop' : '&#xe061;',
			'icon-history' : '&#xe062;',
			'icon-back' : '&#xe063;',
			'icon-switch' : '&#xe064;',
			'icon-list' : '&#xe065;',
			'icon-add-to-list' : '&#xe066;',
			'icon-layout' : '&#xe067;',
			'icon-list-2' : '&#xe068;',
			'icon-text' : '&#xe069;',
			'icon-text-2' : '&#xe06a;',
			'icon-document' : '&#xe06b;',
			'icon-docs' : '&#xe06c;',
			'icon-landscape' : '&#xe06d;',
			'icon-folder' : '&#xe06e;',
			'icon-pictures' : '&#xe06f;',
			'icon-archive' : '&#xe070;',
			'icon-trash' : '&#xe071;',
			'icon-outbox' : '&#xe072;',
			'icon-inbox' : '&#xe073;',
			'icon-disk' : '&#xe074;',
			'icon-install' : '&#xe075;',
			'icon-cloud' : '&#xe076;',
			'icon-upload' : '&#xe077;',
			'icon-bookmark' : '&#xe078;',
			'icon-book-2' : '&#xe079;',
			'icon-bookmarks' : '&#xe07a;',
			'icon-pause' : '&#xe07c;',
			'icon-record' : '&#xe07d;',
			'icon-stop' : '&#xe07e;',
			'icon-next' : '&#xe07f;',
			'icon-previous' : '&#xe080;',
			'icon-first' : '&#xe081;',
			'icon-last' : '&#xe082;',
			'icon-resize-enlarge' : '&#xe083;',
			'icon-resize-shrink' : '&#xe084;',
			'icon-sound' : '&#xe085;',
			'icon-mute' : '&#xe086;',
			'icon-flow-cascade' : '&#xe087;',
			'icon-flow-branch' : '&#xe088;',
			'icon-flow-tree' : '&#xe089;',
			'icon-flow-line' : '&#xe08a;',
			'icon-flow-parallel' : '&#xe08b;',
			'icon-arrow-left' : '&#xe08c;',
			'icon-arrow-down' : '&#xe08d;',
			'icon-arrow-up--upload' : '&#xe08e;',
			'icon-arrow-right' : '&#xe08f;',
			'icon-arrow-left-2' : '&#xe090;',
			'icon-arrow-down-2' : '&#xe091;',
			'icon-arrow-up' : '&#xe092;',
			'icon-arrow-right-2' : '&#xe093;',
			'icon-arrow-left-3' : '&#xe094;',
			'icon-arrow-down-3' : '&#xe095;',
			'icon-arrow-up-2' : '&#xe096;',
			'icon-arrow-right-3' : '&#xe097;',
			'icon-arrow-left-4' : '&#xe098;',
			'icon-arrow-down-4' : '&#xe099;',
			'icon-arrow-up-3' : '&#xe09a;',
			'icon-arrow-right-4' : '&#xe09b;',
			'icon-arrow-left-5' : '&#xe09c;',
			'icon-arrow-down-5' : '&#xe09d;',
			'icon-arrow-up-4' : '&#xe09e;',
			'icon-untitled' : '&#xe09f;',
			'icon-arrow-right-5' : '&#xe0a0;',
			'icon-arrow-up-5' : '&#xe0a1;',
			'icon-arrow-down-6' : '&#xe0a2;',
			'icon-arrow-left-6' : '&#xe0a3;',
			'icon-twitter' : '&#xe0ab;',
			'icon-twitter-2' : '&#xe0ac;',
			'icon-facebook' : '&#xe0ad;',
			'icon-facebook-2' : '&#xe0ae;',
			'icon-facebook-3' : '&#xe0b0;',
			'icon-phone' : '&#xe0b8;',
			'icon-move' : '&#xe0ba;',
			'icon-clipboard' : '&#xe0bb;',
			'icon-box' : '&#xe0bc;',
			'icon-new' : '&#xe0bd;',
			'icon-calendar-week' : '&#xe0be;',
			'icon-calendar-list' : '&#xe0c1;',
			'icon-calendar-day' : '&#xe0c2;',
			'icon-write' : '&#xe0a9;',
			'icon-unzip-file' : '&#xe0bf;',
			'icon-map' : '&#xe012;',
			'icon-checkmark-2' : '&#xe0aa;',
			'icon-checkmark-outline' : '&#xe0b6;',
			'icon-mail-read' : '&#xe02b;',
			'icon-class' : '&#xe034;',
			'icon-exam' : '&#xe037;',
			'icon-homework' : '&#xe042;',
			'icon-play' : '&#xe047;',
			'icon-people' : '&#xe00e;',
			'icon-rotate' : '&#xe05c;',
			'icon-restore' : '&#xe048;',
			'icon-video-conference' : '&#xe049;',
			'icon-checkbox-checked' : '&#xe04a;',
			'icon-checkbox-unchecked' : '&#xe07b;',
			'icon-ellipsis' : '&#xe0a4;'
		},
		els = document.getElementsByTagName('*'),
		i, attr, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		attr = el.getAttribute('data-icon');
		if (attr) {
			addIcon(el, attr);
		}
		c = el.className;
		c = c.match(/icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
};