// make gi first edit with all text selected
// gj make first edit with cursor at the end

// surfingkeys:
// ============
  
  
  
  
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

unmap('f');
map('fm','cf');
//map('F', 'af'); 
mapkey('F', '#1Open a link in non-active new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false})');
//mapkey('fj', '#1Open a link in non-active new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false})');
//mapkey('fk', '#1Open a link in new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true})');
mapkey('cf', '#1Open multiple links in a new tab', 'Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false, multipleHits: true})');


// f and a delay triggers f ie. open here
//mapkey('ff', '#1Open a link, press SHIFT to flip hints if they are overlapped.', 'Hints.create("", Hints.dispatchMouseClick)');

mapkey('gj', 'google first result', function() {

	links = document.evaluate("//h3[@class='r']/a", document, null, XPathResult.ORDERED_NODE_ITERATOR_TYPE, null);
	link = links.iterateNext();
	var win = window.open(link.href, '_blank');
	win.blur();
	//win.focus();


	/*
	while (link){
		alert(link.textContent);
		link = link.iterateNext();
	}
	*/
	// Front.showPopup('a wre (Escape to close).');
});
mapkey('gk', 'google second result', function() {
	links = document.evaluate("//h3[@class='r']/a", document, null, XPathResult.ORDERED_NODE_ITERATOR_TYPE, null);
	link = links.iterateNext().iterateNext();
	var win = window.open(link.href, '_blank');
});


Hints.characters = 'asdghklmnj' ;
// todo scrollKeys change
Hints.scrollKeys='0jkhlG$';	//The keys that can be used to scroll page in hints mode. You need not change it unless that you have changed Hints.characters.
// f to turn it off again

mapkey(';', '#9Find in current page', 'Front.openFinder()');




  //storage sync
var answersToSet = {};
answersToSet.answerA = 'foo';
answersToSet.answerB = 'bar';
chrome.storage.sync.set(answersToSet, function(){
    if (chrome.runtime.lastError) {
        //alert('Error setting answers:\n\n'+chrome.runtime.lastError);
    } else {
        //alert('Answers saved.');
    }
}); 
  