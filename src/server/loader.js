chrome.storage.local.get('list', res => {
    let list = res.list;
    if (!list)
        return;
    list = list.map(item => item.rule);
    console.log(list);
    chrome.webRequest.onBeforeRequest.addListener(detials => {
        return {
            redirectUrl : 'data:text/plain,'
        };
    }, {
        urls : list
    }, ['blocking']);
});
