// https://www.davrous.com/2016/12/07/creating-an-extension-for-all-browsers-edge-chrome-firefox-opera-brave/

browser = (function ()  {   
     return window.msBrowser || chrome ||   
 browser; 
     // TODO msBrowser
 })(); 
 
 
window.browser = (function () {
  return window.msBrowser ||
    window.browser ||
    window.chrome;
})();


//  in google.com; s open first google result, sj next
// todo; b=search buffer as you type
// space
// t=
// single hk for google/open in current, next, buffer
// DONE go= open in current
//oo=open here
// w=open google
// todo ((?!last)(prev(ious)?|newer|back|«|less|<|‹| )+)
//nextmatchpattern
//((?!first)(next|older|more|>|›|»|forward| )+)


var icon = "wSChqmKxEKCDAYFDFj4OmwbY7bDGdBhtrnTQYOigeChUmc1K3QTnAUfEgGFgAWt88hKA6aCRIXhxnQ1yg3BCayK44EWdkUQcBByEQChFXfCB776aQsG0BIlQgQgE8qO26X1h8cEUep8ngRBnOy74E9QgRgEAC8SvOfQkh7FDBDmS43PmGoIiKUUEGkMEC";

//
browser.storage.local.set({ "phasersTo": "awesome" }, function(){
    //  Data's been saved boys and girls, go on home
});
  browser.storage.local.get(/* String or Array */["phasersTo"], function(items){
    //  items = [ { "phasersTo": "awesome" } ]
  //  alert(items["phasersTo"]);
});

// localStorage["link"] = JSON.stringify(link);
// var links = JSON.parse(localStorage["link"]);
//LOCALstoRAGE
//  http://stackoverflow.com/questions/5364062/how-can-i-save-information-locally-in-my-chrome-extension
//===



// make gi first edit with all text selected
// gj make first edit with cursor at the end



// surfingkeys:
// ============


// mapkey('<Space>', 'Choose a tab with omnibar', function() {Front.openOmnibar({type: "Tabs"}) });















//surfingkeys:
settings.hintAlign = "left";

//emoji suggestions popup as soon as you input colon, use below:
settings.startToShowEmoji = 0;
// Unmap dangerous 'reset settings' shortcut
unmap('sr');

// use f to cancel key combos
unmap('gf');
unmap('sf');


addSearchAliasX('y', 'Youtube', 'https://www.youtube.com/results?search_query=');
// create a key to search in git gist stack


// styles
Hints.style('border: solid 3px #3a5f82; color:#fff; background: initial; background-color: #3a5f82; font-size: 10pt;');
Visual.style('marks', 'background-color: #89a1e2;');
Visual.style('cursor', 'background-color: #6590b7;');


map('gn',']]'); // next link
map('gp','[['); // prev link
map('a','gg');
map('gz','g$');

// history F and S
mapkey('H', '#4Go back in history', function() {history.go(-1), {repeatIgnore: true}});
// mapkey('H', '#4Go back in history', 'history.go(-1)', {repeatIgnore: true});
// mapkey('L', '#4Go one tab history forward', 'RUNTIME("historyTab", {backward: false})', {repeatIgnore: true});
mapkey('L', '#4Go one tab history forward', function() { RUNTIME("historyTab", {backward: false}), {repeatIgnore: true}});

map('k','e');
map('j','d');
mapkey('J', '#2Scroll down', function() {Normal.scroll("down"), {repeatIgnore: true}});
mapkey('K', '#2Scroll up', function() {Normal.scroll("up"), {repeatIgnore: true}});

map('<Ctrl-o>','E');

map('<Ctrl-l>','R');

map('h','E');
map('l','R');
mapkey('d', 'close and Previous', function() {RUNTIME("closeTab"); RUNTIME("previousTab")});
map('u','X');

mapkey('ggi', 'test', function() {
        var inputs = document.getElementsByTagName('input');
        var input = null;
        for(var i=0; i<inputs.length; i++) {
            if(inputs[i].type=='text') {
                input = inputs[i];
                break;
            }
        }
        if(input) {
            input.click();
            input.focus();
        }
    }
);

// Buffers
mapkey('b', '#3Choose a tab', function() {Front.chooseTab()});


map('gl','G');
map('Gl','g$');
//ssg
//ssog
map('sg','sG'); 	// google interactive search
map('sog','soG'); 	// google interactive site search

map('ga','g0');
map(';','/');
map('[','[[');

//map('/',']]');
mapkey('/', '#1Click on the next link on current page', function() {
    var nextLinks = $('a').regex(/((>>|next)+)/i);
    if (nextLinks.length) {
        clickOn(nextLinks);
    } else {
        walkPageUrl(1);
    }
});

// map('gj';j']]');//                    Close Downloads Shelf
// map('y','<Esc>');

unmap('<Ctrl-f>');

//unmap('f');
map('fm','cf');
//map('F', 'af');
mapkey('F', '#1Open a link in non-active new tab', function() {Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false})});
//mapkey('fj', '#1Open a link in non-active new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false})');
//mapkey('fk', '#1Open a link in new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true})');
mapkey('cf', '#1Open multiple links in a new tab', function() {Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false, multipleHits: true})});


// f and a delay triggers f ie. open here
//mapkey('ff', '#1Open a link, press SHIFT to flip hints if they are overlapped.', function() {Hints.create("", Hints.dispatchMouseClick)});



Hints.characters = 'hgaslmnkdj' ;
// todo scrollKeys change
Hints.scrollKeys='0jkhlG$';	//The keys that can be used to scroll page in hints mode. You need not change it unless that you have changed Hints.characters.
// f to turn it off again

mapkey(';', '#9Find in current page', function() {Front.openFinder()});


mapkey('f', 'Choose a tab', 'Front.chooseTab()', {domain: /github\.com/i});

function google_first_result() {
//alert("frst");
links = document.evaluate("//h3[@class='r']/a", document, null, XPathResult.ORDERED_NODE_ITERATOR_TYPE, null);
var link = new Array(5);
//links.iterateNext();
//var win = window.open(links.iterateNext().href, '_blank');
	//win.blur();
	//win.focus();
	//alrt(link.href, '_blank');
link[0] = links.iterateNext().href;
link[1] =  links.iterateNext().href;
link[2] =  links.iterateNext().href;
link[3] =  links.iterateNext().href;
link[4] =  links.iterateNext().href;
link[5] =  links.iterateNext().href;
link[6] =  links.iterateNext().href;
browser.storage.local.set({"visited_url": 0 });
var json_data = { "all_links" :  JSON.stringify(link) };
browser.storage.local.set(json_data, function(){    /*  Data's been saved boys and girls, go on home*/  });
}

 function google_next_result(window_loc) {

	var links = new Array(5);
	var count = 1;
	browser.storage.local.get(/* String or Array */["all_links"], function(items){
		links = JSON.parse(items["all_links"]);
	});
	browser.storage.local.get(/* String or Array */["visited_url"], function(items){
		count = JSON.parse(items["visited_url"]);
		//count = parseInt(count)+1;
		var win;
     //alert(window);
		if (window_loc==0){
		    win = window.open(links[count],"_self");
	}
		else{
		    win = window.open(links[count],"_blank");
		}
//alert(count);
		count = count + 1;
		browser.storage.local.set({"visited_url":  count });
		});
}


mapkey('e', '#8Open Search with google',
     function() {Front.openOmnibar({type: "SearchEngine", extra: "g",tabbed: false})});


mapkey('oo', '#8Open a URL in current tab',
      function() {Front.openOmnibar({type: "URLs", extra: "getAllSites", tabbed: false})});


// todo sj open next 3 tabs and focus first
//mapkey('sj', 'google next result', google_next_result);
mapkey('s', 'google next result', function(){
  google_next_result(0);
});
mapkey('s', 'google first result',function(){

google_first_result();
google_next_result(0);
}, {domain: /google\.(co\.in|com|in)/i});

// w kill and open

mapkey('w', 'google open next result',function(){
  //
google_next_result(1);
//RUNTIME("closeTab");
});


mapkey('w', 'google first result',function(){

google_first_result();
google_next_result(1);
}, {domain: /google\.(co\.in|com|in)/i});

//mapkey('gk', 'google open next result',google_next_result(0));
//n in google takes to next page

// todo
//map('n',']]', {domain: /google\.(co\.in|com|in)/i});
mapkey('n','next page',function(){
    Normal.scroll("bottom");
    nextPage();
   },{domain: /google\.(co\.in|com|in)/i});

mapkey('p','previous Page',function(){
    Normal.scroll("bottom");
    previousPage();
   },{domain: /google\.(co\.in|com|in)/i});



mapkey('oy', 'only this year', function() {   open_in_date("y"); });
mapkey('om', 'only this month', function() {   open_in_date("m"); });

function open_in_date(date){
    window.location.href = window.location.href + "&tbs=qdr:" + date;
}




















//https://github.com/b0o/surfingkeys-conf/blob/master/conf.js



//---- Mapkeys ----//
let ri = { repeatIgnore: true };
mapkey('=w',  "Lookup whois information for domain", whois,           ri);
mapkey('=d',  "Lookup dns information for domain",   dns,             ri);
mapkey('=D',  "Lookup all information for domain",   dnsVerbose,      ri);
mapkey(';se', "#11Edit Settings",                    editSettings,    ri);
mapkey(';pd', "Toggle PDF viewer from SurfingKeys",  togglePdfViewer, ri);
mapkey('gi',  "Edit current URL with vim editor",    vimEditURL,      ri);


function mapsitekey(domainRegex, key, desc, f, opts) {
    opts = opts || {};
    mapkey(`\\${key}`, desc,  f, Object.assign({}, opts, { domain: domainRegex }));
}

function mapsitekeys(domainRegex, maps) {
    maps.forEach(function(map) {
        mapsitekey(domainRegex, map[0], map[1], map[2]);
    });
}

mapsitekeys(/(youtube\.com)/i, [
    ['F',  "Toggle fullscreen", ytFullscreen],
]);

mapsitekeys(/(vimeo\.com)/i, [
    ['F', "Toggle fullscreen",  vimeoFullscreen],
]);

mapsitekeys(/(github\.com)/i, [
    ['s',  "Toggle Star", ghToggleStar],
]);


function ytFullscreen() {
    $('.ytp-fullscreen-button.ytp-button').click();
}

function vimeoFullscreen() {
    $('.fullscreen-icon').click();
}

function ghToggleStar() {
  var repo = window.location.pathname.slice(1).split("/").slice(0,2).join("/");
  var cur = $('div.starring-container > form').filter(function() {
    return $(this).css("display") === "block";
  });

  var action = "starred";
  var star = "★";
  if ($(cur).attr("class").indexOf("unstarred") === -1) {
    action = "un" + action;
    star = "☆";
  }

  $(cur).find("button").click();
  Front.showBanner(star + " Repository " + repo + " " + action);
}

function whois() {
    var url = "http://centralops.net/co/DomainDossier.aspx?dom_whois=true&addr=" + window.location.hostname;
    window.open(url, '_blank').focus();
}

function dns() {
    var url = "http://centralops.net/co/DomainDossier.aspx?dom_dns=true&addr=" + window.location.hostname;
    window.open(url, '_blank').focus();
}

function dnsVerbose() {
    var url = "http://centralops.net/co/DomainDossier.aspx?dom_whois=true&dom_dns=true&traceroute=true&net_whois=true&svc_scan=true&addr=" + window.location.hostname;
    window.open(url, '_blank').focus();
}

function togglePdfViewer() {
    chrome.storage.local.get("noPdfViewer", function(resp) {
        if(!resp.noPdfViewer) {
            chrome.storage.local.set({"noPdfViewer": 1}, function() {
                Front.showBanner("PDF viewer disabled.");
            });
        } else {
            chrome.storage.local.remove("noPdfViewer", function() {
                Front.showBanner("PDF viewer enabled.");
            });
        }
    });
}

















function vimEditURL() {
    Front.showEditor(window.location.href, function(data) {
        window.location.href = data;
    }, 'url');
}


function editSettings() {
    tabOpenLink("/pages/options.html");
}

