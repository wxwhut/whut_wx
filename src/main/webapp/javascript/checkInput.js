function checkLength( o, n, min, max ) {
    if ( o.val().length > max || o.val().length < min ) {
        if(min!=max) {
            showMessage(n + "的长度应该在" + min + "和" + max + "之间", o);
        }else {
            showMessage(n + "的长度应该为" + min + "位", o);
        }
        return false;
    } else {
        return true;
    }
}
function checkRegexp(o, regexp, tip ) {
    if (!(regexp.test(o.val()))) {
        showMessage(tip,o);
        return false;
    } else {
        return true;
    }
}
function showMessage(msg, domObj) {
    layer.tips(msg, domObj,{tips:[3,'#000000']});//弹出框加回调函数
}
