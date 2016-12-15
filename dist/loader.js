'use strict';

chrome.storage.local.get('list', function (res) {
    var list = res.list || [];
    list = list.map(function (item) {
        return item.rule;
    });
    console.log(list);
    chrome.webRequest.onBeforeRequest.addListener(function (detials) {
        return {
            redirectUrl: 'data:text/plain,'
        };
    }, {
        urls: list
    }, ['blocking']);
});
;

var _temp = function () {
    if (typeof __REACT_HOT_LOADER__ === 'undefined') {
        return;
    }
}();

;