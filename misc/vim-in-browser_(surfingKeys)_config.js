var icon = "wSChqmKxEKCDAYFDFj4OmwbY7bDGdBhtrnTQYOigeChUmc1K3QTnAUfEgGFgAWt88hKA6aCRIXhxnQ1yg3BCayK44EWdkUQcBByEQChFXfCB776aQsG0BIlQgQgE8qO26X1h8cEUep8ngRBnOy74E9QgRgEAC8SvOfQkh7FDBDmS43PmGoIiKUUEGkMEC";

//
chrome.storage.local.set({ "phasersTo": "awesome" }, function(){
    //  Data's been saved boys and girls, go on home
});
  chrome.storage.local.get(/* String or Array */["phasersTo"], function(items){
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
  mapkey('gj', 'google first result', function() {

links = document.evaluate("//h3[@class='r']/a", document, null, XPathResult.ORDERED_NODE_ITERATOR_TYPE, null);
var link = new Array(5);

var win = window.open(links.iterateNext().href, '_blank');
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
chrome.storage.local.set({"visited_url": 0 });
var json_data = { "all_links" :  JSON.stringify(link) };
chrome.storage.local.set(json_data, function(){    /*  Data's been saved boys and girls, go on home*/  });
});
  
mapkey('gk', 'google open all result', function() {

	var links = new Array(5);
	var count = 1;	
	chrome.storage.local.get(/* String or Array */["all_links"], function(items){
		links = JSON.parse(items["all_links"]);
	});
	chrome.storage.local.get(/* String or Array */["visited_url"], function(items){
		count = JSON.parse(items["visited_url"]);    
		//count = parseInt(count)+1;
		var win = window.open(links[count], '_blank');
		count = count + 1;
		chrome.storage.local.set({"visited_url":  count });
		});
});
  
  
  
  
  
  
  











  
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
mapkey('H', '#4Go back in history', 'history.go(-1)', {repeatIgnore: true});
mapkey('L', '#4Go one tab history forward', 'RUNTIME("historyTab", {backward: false})', {repeatIgnore: true});

map('k','e');
map('j','d');
mapkey('J', '#2Scroll down', 'Normal.scroll("down")', {repeatIgnore: true});
mapkey('K', '#2Scroll up', 'Normal.scroll("up")', {repeatIgnore: true});

map('h','E');
map('l','R');
mapkey('d', 'close and Previous', 'RUNTIME("closeTab"); RUNTIME("previousTab")');
map('u','X');

mapkey('gi', 'test', function() {
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
mapkey('b', '#3Choose a tab', 'Front.chooseTab()');


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
mapkey('F', '#1Open a link in non-active new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false})');
//mapkey('fj', '#1Open a link in non-active new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false})');
//mapkey('fk', '#1Open a link in new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true})');
mapkey('cf', '#1Open multiple links in a new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false, multipleHits: true})');


// f and a delay triggers f ie. open here
//mapkey('ff', '#1Open a link, press SHIFT to flip hints if they are overlapped.', 'Hints.create("", Hints.dispatchMouseClick)');



Hints.characters = 'asdghklmnj' ;
// todo scrollKeys change
Hints.scrollKeys='0jkhlG$';	//The keys that can be used to scroll page in hints mode. You need not change it unless that you have changed Hints.characters.
// f to turn it off again

mapkey(';', '#9Find in current page', 'Front.openFinder()');




  