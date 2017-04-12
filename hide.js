//
//  hide.js
//

var styleElement = document.createElement('style');
styleElement.textContent = '.yui-layout-unit .openRightPanel { display : none ; } ';
document.documentElement.appendChild(styleElement);
