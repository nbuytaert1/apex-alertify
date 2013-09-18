var beCtbAlertify = {};

beCtbAlertify.util = {
  replaceItems: function (pMsg) {
    var item;
    var itemOnPage;
    var items = new RegExp("#\\w+#", "g");
    var replacedMsg = pMsg;

    while (item = items.exec(pMsg)) {
        itemOnPage = $x(item[0].replace(/#/g, ""));
        if (itemOnPage) {
            replacedMsg = replacedMsg.replace(item[0], $v(itemOnPage));
        }
    }
    return replacedMsg;
  }
};

beCtbAlertify.dialog = {
  util: beCtbAlertify.util,

  alert: function (pThis) {
    alertify.alert(this.util.replaceItems(pThis.action.attribute04), function (e) {
      apex.da.resume(pThis.resumeCallback, false);
    });
  },
  confirm: function (pThis) {
    alertify.confirm(this.util.replaceItems(pThis.action.attribute04), function (e) {
      if (e) {
        if (pThis.action.waitForResult) {
          apex.da.resume(pThis.resumeCallback, false);
        }
      } else {
        ;
      }
    });
  },
  prompt: function (pThis) {
    alertify.prompt(this.util.replaceItems(pThis.action.attribute04), function (e, str) {
      if (e) {
        if (pThis.action.waitForResult) {
          $s(pThis.action.attribute06, str);
          apex.da.resume(pThis.resumeCallback, false);
        }
      } else {
        ;
      }
    }, this.util.replaceItems(pThis.action.attribute05));
  }
};

beCtbAlertify.notification = {
  util: beCtbAlertify.util,

  log: function (pThis) {
    alertify.log(this.util.replaceItems(pThis.action.attribute04), pThis.action.attribute03.toLowerCase(), Number(pThis.action.attribute11));
    apex.da.resume(pThis.resumeCallback, false);
  }
};