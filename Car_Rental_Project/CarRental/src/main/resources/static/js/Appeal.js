//проверка анонимной отправки
function validate(){
    var remember = document.getElementById('anonymous');
    if (remember.checked){
        document.getElementById('chekAnonymous').value = "on";
    } else{
        document.getElementById('chekAnonymous').value = "of";
    }
}

//Блок с вопросами
function Show(BaseID, HideDIV, ShowDIV) {
    document.getElementById(HideDIV).setAttribute("style", "opacity:1; transition: 1s; height: 100%;");
    document.getElementById(BaseID).setAttribute("style", "display: none");
    document.getElementById(ShowDIV).setAttribute("style", "display: block");
}
function DisplayNone(BaseID, HideDIV, ShowDIV) {
    document.getElementById(HideDIV).setAttribute("style", "display: none");
    document.getElementById(ShowDIV).setAttribute("style", "display: none");
    document.getElementById(BaseID).setAttribute("style", "display: block");
}

