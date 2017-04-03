
  
  goToInput: function(repeats) {
    this.inputElements = [];
    var allInput = document.
      querySelectorAll('input,textarea,*[contenteditable]');
    for (var i = 0, l = allInput.length; i < l; i++) {
      if (DOM.isEditable(allInput[i]) &&
          DOM.isVisible(allInput[i]) &&
          allInput[i].id !== 'cVim-command-bar-input') {
        this.inputElements.push(allInput[i]);
      }
    }
    if (this.inputElements.length === 0) {
      return false;
    }
    this.inputElementsIndex = repeats % this.inputElements.length - 1;
    if (this.inputElementsIndex < 0) {
      this.inputElementsIndex = 0;
    }
    for (i = 0, l = this.inputElements.length; i < l; i++) {
      var br = this.inputElements[i].getBoundingClientRect();
      if (br.top + br.height >= 0 &&
          br.left + br.width >= 0 &&
          br.right - br.width <= window.innerWidth &&
          br.top < window.innerHeight) {
        this.inputElementsIndex = i;
        break;
      }
    }
    this.inputFocused = true;
    this.inputElements[this.inputElementsIndex].focus();
    if (document.activeElement.select) {
      document.activeElement.select();
    }
    if (!document.activeElement.hasAttribute('readonly')) {
      document.getSelection().collapseToEnd();
    }
  }
  
  

  
=====================================
=====================================
===========	DOCUMENTANTION	=========
=====================================
=====================================


// use f to cancel key combos
unmap('gf');
unmap('sf');


// history F and S
J K= up/down
hjkl
HL
// Buffers
mapkey('b', '#3Choose a tab', 'Front.chooseTab()');


map('gl','g$');
//ssg
//ssog
map('sg','sG'); 	// google interactive search
map('sog','soG'); 	// google interactive site search

map(';','/');
map('[','[[');

mapkey('/', '#1Click on the next link 
// map('gj';j']]');//                    Close Downloads Shelf
// map('y','<Esc>');

ff
fj
fk
fm
mapkey('gj', 'google first result'
mapkey('gk', 'google second result',
// f to turn it off again
; search



o=open
og google
on new tab
ox recently closed
oh', '#8Open URL from history'
'af', '#1Open a link in new tab'
gf open in new inactive tab
todo:
" remap del tab to ss, sj as something else 
" r


mf multi links
gd downloads
gh history
gt translate selected
ge extensions
ya copy all urls
g+/- decrement the first number in the URL path (e.g www.example.com/5 => www.example.com/4)

=========================================
=======  Documentation ends here ========
=============================================

" cVim config
" E,R is same as H,L in cVim. make it  same for others too

" see selected text copy in this link  http://eisabainyo.net/weblog/2010/11/15/10-most-useful-javascript-snippets-from-snipplr/

" https://brookhong.github.io/2015/09/15/surfingkeys.html

" ===========
" https://github.com/1995eaton/chromium-vim


set noautofocus " The opposite of autofocus; this setting stops
                " sites from focusing on an input box when they load
set showtabindices				
let scrollstep = 150	
let barposition = "top"			
let hintcharacters = "fdsla;ghienmkj"				
let mapleader = ","
map <C-u> rootFrame
map <M-h> previousTab

" Mappings

map <Leader>r reloadTabUncached
map <Leader>x :restore<Space>
" Displays your public IP address in the status bar
getIP() -> {{
	httpRequest({url: 'http://api.ipify.org/?format=json', json: true},
            function(res) { Status.setMessage('IP: ' + res.ip); });
}}
" Displays your public IP address in the status bar
map ci :call getIP<CR>


googleSiteSearch() -> {{

	//<input id="textbox" type="text" placeholder="Search on Google..." onkeydown="if (event.keyCode == 13 || event.which == 13) { 
	var input_term = prompt(window.location.hostname, "default");
    if (input_term != null) {
		location='http://www.google.com/search?q=site:'+window.location.hostname+ '%20' + encodeURIComponent(input_term);
		window.open(location).focus();
}
return false;
}}

map gss :call googleSiteSearch<CR>
" Script hints
echo(link) -> {{
  alert(link.href);
}}

map b :buffer<Space>
" map B b
map ss x
map u X
map ; nextMatchPattern
map ' previousMatchPattern
map gf lastUsedTab

toggle the focus between the last used tabs	laslastUsedTab
cVim builtins:
cvim gj close download shelf

E,R is same as H,L in cVim

<C-S-h>, gh open the last URL in |� current tab窶冱 history in a new tab openLastLinkInTab
<C-S-l>, gl open the next 

yy 	copy the URL of the current page to the clipboard 	yankDocumentUrl
<N>% 	switch to tab <N>
more in the online documentation
]] 	click the "next" link on the page (see nextmatchpattern above) 	nextMatchPattern
[[ 	click the "back" link on the page (see previousmatchpattern above)
gd 	alias to :chrome://downloads<CR> 	:chrome://downloads<CR>
ge 	alias to :chrome://extensions<CR>
gu 	go up one path in the URL 	goUpUrl
gU 	go to to the base URL
I	search through browser history	:history
X	open the last closed tab	lastClosedTab

" common settings

map ga g0
map gl g$
map a gg

map l gt
map h gT

map J h
map K l

map w k


			
" vrome & vimperator config (for vimperator use nnoremap & noremap)


map j 5j
map k 5k
map d <C-f>
map e <C-b>
map s d



vimperator only
===========
map yy y
" Ctrl-a
"inoremap <C-a> <C-Home><C-S-End>
inoremap <C-a> <Ins><C-a><Ins>
"inoremap <C-a> 
"cnoremap <C-a>

cmap <Up> <S-Tab>
cmap <Down> <Tab>
set tabnumbers

" https://gist.github.com/igal/329662
" Load configuration file into current browser, useful for updating after editing this file.
command! sourcerc :source ~/_vimperatorrc

" source! "C:\\Users\\cibin\\_vimperatorrc.local"
" vim: set ft=vimperator:
" prevent d on the last tab from closing the window?
:set! browser.tabs.closeWindowWithLastTab=false

" http://superuser.com/questions/521062/how-to-change-characters-used-for-link-hints-in-firefox-vimperator#comment648908_536450
:set hintchars=fjdksla;gh

" http://superuser.com/questions/230741/how-to-make-vimperators-numbered-links-bigger-hints
":highlight Hint font-size:100%;color:black;background-color:#cccc00;padding:1px;padding-left:3px;padding-right:3px;

" http://5digits.org/pentadactyl/faq#faq-fork
" How can I display my hints in upper case but type them in lower case?   
" If you use alphabetic characters for your 'hintkeys' and would like to
" be able to type them in lower case but still have the hints displayed
"in upper case, use:
:highlight -a Hint text-transform: uppercase;

"How can I hide the hint text for input and image hints?
"If you'd only like to show the numbered portion of hints, you can do so with:
":highlight Hint::after content: attr(number) !important;
:set cpt=l

" Make bar yellow when focused.
" From: http://www.reddit.com/r/linux/comments/99d55/i_could_use_a_little_vimperator_help_also/
javascript <<EOF
    (function() {
        var inputElement = document.getElementById('liberator-commandline-command');
        function swapBGColor(event) {
            inputElement.style.backgroundColor = event.type == "focus" ? "yellow" : "";
        }
        inputElement.addEventListener('focus', swapBGColor, false);
        inputElement.addEventListener('blur', swapBGColor, false);
    })();
EOF

"var inputElement = document.getElementById('liberator-commandline-command').innerHTML;
"javascript <<EOF
"    (function() {
"        var inputElement = document.getElementById('liberator-commandline-command');
"		
 "       function swapBGColor(event) {
  "          inputElement.style.backgroundColor = event.type == "focus" ? "yellow" : "";
   "     }
    "   inputElement.addEventListener('focus', swapBGColor, false);
     "   inputElement.addEventListener('blur', swapBGColor, false);
"    })();
" EOF

" copy page title to the clipboard (with ALT+y)
" http://www.mozdev.org/pipermail/vimperator/2008-October/002546.html
:map <silent> <A-y> :js util.copyToClipboard(content.document.title, true)<cr>
