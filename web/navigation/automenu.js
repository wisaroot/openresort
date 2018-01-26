  /*
    Adds CSS class names to the LI elements of a nested UL list.
    leafes get the menu_leaf_class
    open nodes get the menu_open_class
    closed nodes get the menu_closed_class
    the current node gets the menu_active_class
    
    written 2004 by Ortwin Glueck
  */

  //config
  var menu_active_class = "active";
  var menu_leaf_class = "leaf";
  var menu_open_class = "open";
  var menu_closed_class = "closed";
  
  //the default page that is displayed if URL ends in /
  var menu_default_page = "index.php";
  var menu_url;
  
  //main function
  //menu_id : id of the element containing the navigation
  function menu_main(menu_id) {
     var url = location.href;
     if (url.lastIndexOf("/") == (url.length-1)) {
       url = url+menu_default_page;
     }
     if (url.lastIndexOf("?") >= 0) {
       url = url.substring(0, url.lastIndexOf("?"));
     }
     if (url.lastIndexOf("#") >= 0) {
       url = url.substring(0, url.lastIndexOf("#"));
     }
     menu_url = url;
     
     var main = document.getElementById(menu_id);
     if (!main) alert("No element with id '"+ menu_id +"' found");
     menu_traverse(main);
  }
  
  /* Walks down the subtree and on the way back
     sets properties.
     returns bit set
             1: set = element is a node, unset = element is a leaf
             2: set = element contains the active node
             4: set = element is the active A node
  */
  function menu_traverse(element) {
    var props  = 0;
    
    // walk down
    for (var i=0; i<element.childNodes.length; i++) {
      var child = element.childNodes[i];
      props |= menu_traverse(child); // aggregate bits
    }
    
    // on the way back now
    switch (element.tagName) {
      case "UL":
        props |= 1;
        break;
        
      case "LI":
        var c1 = (props & 1) ? 
                   ((props & (2|4)) ? menu_open_class : menu_closed_class)
                 : menu_leaf_class; 
        element.className = element.className ? element.className+" "+c1 : c1;
        if (props & 4) {
          if (!(props & 2)) element.className += " "+menu_active_class;
          props |= 2;
          props &= 1 | 2; // reset bit 4
        }
        break;
        
      case "A":
        if (props & 2) break; // once is enough
        var href = element.getAttribute("href");
        if (menu_isSameUrl(menu_url, href)) props |= 4;
        break;
    }
    
    return props;
  }
  
  //matches two URIs when href is the last part of url
  //.. and . are correctly resolved
  function menu_isSameUrl(url, href) {
    var a = url.split(/[?\/]/i);
    var b = href.split(/[?\/]/i);
    var i = a.length - 1;
    var j = b.length - 1;
    while ((i >= 0) && (j >= 0)) {
      if (b[j] == "..") { j-=2; continue; }
      if (a[i] == "..") { i-=2; continue; }
      if ((b[j] == ".") || (b[j] == "")) { j--; continue; }
      if ((a[i] == ".") || (a[i] == "")) { i--; continue; }
      if (! (a[i] == b[j])) return false;
      i--;
      j--;
    }
    return true;
  }