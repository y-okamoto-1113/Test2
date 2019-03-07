
// このコメントないと、「const」使う度にwarnning出してくる 
/*jshint esversion: 6 */

//名前確認
let nameCheck = function(){
    const name_value = $("#name").get(0).value;
    const name_value2 = name_value.trim();
    if(name_value2 === ""){
        $("#nameError").show();
        return false;                             //「nameCheck()」という関数に、true, falseをリターンする。
    }else{
        $("#nameError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#name").blur(function(){
        nameCheck();
    });
});



//電話番号チェック
const telCheck = function(){
    var tel_value = $("#tel").get(0).value;
    if( !tel_value.match(/^(\d{3}-\d{4}-\d{4}|\d{11})$/)){  //正規表現にスペースはアカン。
        //matchやと、正規表現の文字が含まれているかどうかしかチェックしない。正規表現の文字さえ含まれていたら文字数が大きくても問題ない。
        //  だから今回は１１文字以上でもエラー文が出てくれなかった。
        // matchやと、文字列が検索に引っかからないとnull値を返す。
        // ^()で先頭一致、()$で後方一致。  両方使うことで完全一致にできる！！！！！！！！！！！
        $("#telError").show();
        return false;
    }else{
        $("#telError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#tel").blur(function(){
        telCheck();
    });
});



// メールアドレスのチェック
const mailCheck = function(){
    const mail_value = $("#mail").get(0).value;
    if( !mail_value.match(new RegExp(/^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}\.[A-Za-z0-9]{1,}$/))){
        $("#mailError").show();
        return false;
    }else{
        $("#mailError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#mail").blur(function(){
        mailCheck();
    });
});



//性別チェック
const sexCheck = function(){
    if( ($("#man").get(0).checked == false) && ($("#woman").get(0).checked==false ) ){
        $("#sexError").show();
        return false;
    }else{
        $("#sexError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $(".sex").blur(function(){
        sexCheck();
    });
});



// 西暦楽々生産機
$(function(){
    var time = new Date();
    var endYear = time.getFullYear();
    for(var i =1900; i<=endYear; i++){
        $("#year").get(0).add(new Option(i.toString() +"年", i.toString() ));
    }
});


// 閏年チェック.       １００年で割れる年は、閏年ちゃう。でも、400年で割れる年は、閏年。
const monthCheck = function(){
    var year_value = $("#year").get(0).value;
    var month_value = $("#month").get(0).value;
    year_value = parseInt(year_value);
    month_value = parseInt(month_value);

    // まずは日数を初期化
    /// firstChildやったら「-日-」から削除される。lastから削除して最後一個だけ残るようにすればOK。
    var x = $("#day").get(0);
    if (x.hasChildNodes()) {
        while (x.childNodes.length > 2) {
            x.removeChild(x.lastChild);
        }
    }

    // .option「s」じゃないとアカン。select要素内の選択肢（option要素）のコレクションを指す。lengthで長さ測るには、リストと見なさなアカンから、コレクションじゃないとアカン。
    if(  ((year_value%4==0 && year_value%100!=0) || year_value%400==0) && month_value　== 2 ){                   //29
            for(var i=1; i<30; i++){
                $("#day").get(0).options[i] = new Option(i+"日", i);
                //「new Option(text,value,defaultSelected,selected)」の順番で、optionタグを追加。
                // .option「s」じゃないとアカン。select要素内の選択肢（option要素）のコレクションを指す。[]でリスト番号指定しているから、コレクションじゃないとアカン。
            }
    }else if(month_value == 1||                                   //31
            month_value == 3 ||
            month_value == 5 ||
            month_value == 7 ||
            month_value == 8 ||
            month_value == 10||
            month_value == 12 ){  // 「month_value == (1||3||5||7||8||10||12)」はアカン！！！！！
        for(var i=1; i<32; i++){
            $("#day").get(0).options[i] = new Option(i+"日", i);
        }
    }else if(month_value == 2 ){                              //28
        for(var i=1; i<29; i++){
            $("#day").get(0).options[i] = new Option(i+"日", i);
        }
    }else{                                                    //30
        for(var i=1; i<31; i++){
            $("#day").get(0).options[i] = new Option(i+"日", i);
        }
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#year,#month").change(function(){
        monthCheck();
    });
});




// JSONデータ読み込み。    選択した最終学歴によって学校リストを変更
function schoolSelect(value) {

    arrayNum = $("#school").get(0).options.length;
    //セレクトボックスの初期化
    for(var i=1; i<arrayNum; i++) {
      $("#school").get(0).options[1] = null;
    }

    // ラジオボタンのvalueで条件分岐
    switch(value) {      // inputタグで選択式の場合、設定したvalueが代入されてる。
        case "中卒": //中学
            $.getJSON("school.json",{name:"school_name"} , function(data) {
                // {name:"chara"}       入力提出さえたデータは相手側のデータサーバーに送られる。データを検索しやすくする為のタグ付をしている！！！
                // $.getJSONで、データを読み込んだら、その後の処理を、「function」で決められる。
                var list = data.juniorhighschool;
                $.each(list, function(i) {       //////// なんでここで「i」を宣言できてんの？？？
                    // 「$.each」は「for」の書き換え。　　　「list」すべてのデータにfunctionを適応。
                    $("#school").get(0).options[i] = new Option(list[i], list[i]);
                });
            });
            break;

            //  オブジェクトを配列のように使うには、「Object.values(オブジェクトデータ)」か「for i in オブジェクトデータ」
        case "高卒": //高校
            $.getJSON("school.json", {name: "school_name"}, function(data) {
                var list = data.highschool;
                var values = Object.values(list);       //  jsonのデータは配列ではなくオブジェクト！！！！！
                for(var i=1; i< values.length; i++ ) {
                    $("#school").get(0).options[i] = new Option(list[i], list[i]);
                }
            });
            //     $.each(list, function(i) {
            //         $.school.options[i] = new Option(list[i], list[i]);
            //     });
            // });

            break;

            //  オブジェクトを配列のように使うには、「Object.values(オブジェクトデータ)」か「for i in オブジェクトデータ」
        case "大卒": //大学
            $.getJSON("school.json", {name: "school_name"}, function(data) {
                var list = data.university;
                for(var i in data.university){  //  「for in」もオブジェクトを配列のように使える。
                    $("#school").get(0).options[i] = new Option(list[i], list[i]);
                }

                // $.each(list, function(i) {       //  https://q-az.net/without-jquery-each/
                //     $.school.options[i] = new Option(list[i], list[i]);
                // });
            });
            break;


        case "学歴無し": //
        // これ入れな、「Expected a 'break' statement before 'default'. (W086)」ってwarnning出る。
        /* falls through */
        default: break;
    }
}
// これも、turbolinkのせいで、ready動かんかったから書き換えた
document.addEventListener("turbolinks:load", function() {
    $(".career").change(function(){
        var careerNum = $('input[class="career"]:checked').val();      // class=careerのラジオボタンの中から、チェックされてるボタンのvalueを取得！！！
        schoolSelect(careerNum);
    });
});




// 学歴チェック
const careerCheck = function(){
    var school_value = $("#school").get(0).value;
    if( ($("#junior").get(0).checked==false) && ($("#high-school").get(0).checked==false) &&
        ($("#university").get(0).checked==false) && ($("#no-career").get(0).checked==false ) ){
            $("#careerError").show();
            return false;
    }else if(($("#junior").get(0).checked==true ||
              $("#high-school").get(0).checked==true ||
              $("#university").get(0).checked==true) &&
              school_value==0 ){
                $("#careerError").show();
                return false;
    }else{
            $("#careerError").fadeOut();
            return true;
        }
};
document.addEventListener("turbolinks:load", function(){
    $("#school").blur(function(){
        careerCheck();
    });
});



//  追加された続柄の値を取得
//  値は入ってなくてもOK。もし両方セットで記入されていたら使うけど、片方だけだったら無視
//  登録ボタンを押した時に、最終確認モーダルでのみ出現すべき
//  2個目以降の入力値が変更されても更新されない！！！！！！！
var zoku;
var zokuname;
var y = $(".bbb").get(0);     // 「removeAddedFR」でもこれ使うからグローバル変数にしてる。

// const checkChildFR = function(){
//   var k = 0;
//   var fff = $(".bbb").children('family');
//   for(var i=2; i<fff.length; i=i+2){
//     var j = i+1;
//     zoku = fff.get(i).value.trim();
//     zokuname = fff.get(j).value.trim();
//     if(zoku=="" || zokuname==""){
//       // 何もしない   「return false」としてしまうとそこで関数が終了してしまう。forループも止まる。
//     }else{
//       // 最初はget()の中が0じゃないとあかん
//       $(".multipleFR").get(k).innerHTML = "　　　　　続柄:" + zoku + "　名前:" + zokuname +
//       "<br>"+ "<span class='multipleFR' ></span>" ;
//       k++;
//     }
//   }
// };





// 最終チェックのモーダルウィンドウ
function valueCheck() {

    //初期状態からいきなり登録した場合にエラーを出す為に、まずは必須項目の内容チェック関数を呼び出す
    nameCheck();
    mailCheck();
    sexCheck();
    careerCheck();
    frCheck();
    telCheck();

    // モーダルに表示するために、入力値を変数に代入しとく。
    var name = $("#name").get(0).value;
    var furigana = $("#furigana").get(0).value;
    var tel = $("#tel").get(0).value;
    var mail = $("#mail").get(0).value;
    var sex;
    if($("#man").get(0).checked == true) {
        sex = "男性";
    } else if($("#woman").get(0).checked == true) {
        sex = "女性";
    }
    var year = $("#year").get(0).value;
    var month = $("#month").get(0).value;
    var day = $("#day").get(0).value;
    var school;
    if($("#no-career").get(0).checked == true) {
        school = "なし";
    } else {
        school = $("#school").get(0).value; // プルダウンで選択された学校名が、文字列データとして代入されている。
    }

    // 1つ目の家族構成
    var fr = $("#family_relation").get(0).value;
    var fn = $("#family_name").get(0).value;

    // 2つ目の家族構成
    var fr2 = $("#family_relation2").get(0).value;
    var fn2 = $("#family_name2").get(0).value;

    // 3つ目の家族構成
    var fr3 = $("#family_relation3").get(0).value;
    var fn3 = $("#family_name3").get(0).value;

    // 入力値を代入したさっきの変数を使って、モーダルウィンドウに表示する
    $("#check_name").get(0).innerHTML = '名前<span style="color: #FF0000;">*</span>：' + name + "<br>";
    $("#check_furigana").get(0).innerHTML = "ふりがな：" + furigana + "<br>";
    $("#check_tel").get(0).innerHTML = "電話番号<span style='color: #FF0000;'>*</span>：" + tel + "<br>";
    $("#check_mail").get(0).innerHTML = 'メールアドレス<span style="color: #FF0000;">*</span>：' +mail+ "<br>";
    $("#check_sex").get(0).innerHTML = '性別<span style="color: #FF0000;">*</span>：' + sex + "<br>";
    $("#check_birthday").get(0).innerHTML = "生年月日：" + year + "年" + month + "月" + day + "日" + "<br>";
    $("#check_school").get(0).innerHTML = '最終学歴<span style="color: #FF0000;">*</span>：' + school + "<br>";
    $("#check_fr").get(0).innerHTML = '家族構成1<span style="color: #FF0000;">*</span>：' +'続柄:'+ fr + '　名前:' +fn+ "<br>";
    
    // 家族構成2、3人目を記入していた場合
    // 「&&」やと続柄・名前の片方が記入されてるだけで保存されるから「||」を否定（!）する形にしてる。
    // このままやと、最終確認モーダルに表示されないだけで、データベースには保存される。
    if ( !(fr2=="" || fn2=="") ){
        $("#check_fr2").get(0).innerHTML = '家族構成2： ' +'続柄:'+ fr2 + '　名前:' +fn2+ "<br>";
        $("#check_fr2").show();
    }else{
        $("#check_fr2").get(0).style.display = "none";
    }
    if ( !(fr3=="" || fn3=="") ){
        $("#check_fr3").get(0).innerHTML = '家族構成3： ' +'続柄:'+ fr3 + '　名前:' +fn3+ "<br>";
        $("#check_fr3").show();
    }else{
        $("#check_fr3").get(0).style.display = "none";
    }

    // spanタグはデフォルトがinlineやからいらん
    // $("#check_name").get(0).style.display = "inline";
    // $("#check_furigana").get(0).style.display = "inline";
    // $("#check_tel").get(0).style.display = "inline";
    // $("#check_mail").get(0).style.display = "inline";
    // $("#check_sex").get(0).style.display = "inline";
    // $("#check_birthday").get(0).style.display = "inline";
    // $("#check_school").get(0).style.display = "inline";
    // $("#check_fr").get(0).style.display = "inline";
    // $("#check_fr2").get(0).style.display = "inline";
    // $("#check_fr3").get(0).style.display = "inline";
    // $(".multipleFR").get(0).style.display = "inline";     // get(0)やと5個全部でーへんかも。get(i)のようにしたい。

    // 必須項目じゃない入力フォームに、誤りのある入力値or未記入なら、モーダルウィンドウの最終確認画面には出さない。
    if(furigana == "") {
        $("#check_furigana").get(0).style.display = "none";
    }
    // if(!tel.match(/^(\d{3}-\d{4}-\d{4}|\d{11})$/)) {
    //     $("#check_tel").get(0).style.display = "none";
    // }
    if((year == "0") || (month == "0") || (day == "0") || (day == "" )) {
        // dayはremoveChild()使ってるからvalueが「""」にもなる。
        $("#check_birthday").get(0).style.display = "none";
    }

    //すべての必須項目でエラーなしならモーダルウィンドウを表示
    if(nameCheck()==true && mailCheck()==true && sexCheck()==true &&
      careerCheck()==true && frCheck() == true && telCheck()==true ) {
        var baseLayer    = $('#modalBaseLayer').get(0); //モーダルウィンドウ
        var submitButton       = $('#submitButton').get(0); //はい
        var closeTrigger = $('#closeModal').get(0); //いいえ

        // モーダルを表示
        baseLayer.style.visibility = 'visible';

        // id=submitButtonは、モーダルウィンドウの「はい」のボタン
        submitButton.addEventListener('click', function() {
            // このボタンを押した時（"click"した時）にモーダルを非表示にする。
            // 「addEventListener(イベントのタイプ,function(){},false)」で、クリックした時に起こる動作を作れる。
            baseLayer.style.visibility = 'hidden';
        }, false);             ////////// なんでfalseあんの？？？？？？？？？？？？？

        //いいえを押したとき
        closeTrigger.addEventListener('click', function(event) {
            // モーダルを非表示
            baseLayer.style.visibility = 'hidden';
        }, false);             ////////// なんでfalseあんの？？？？？？？？？？？？？
    }



}
document.addEventListener("turbolinks:load", function(){
    $("#finalCheck").click(function(){
    //   checkChildFR();     //  この関数をValueCheck()より先に実行して、zoku,zokunameに値を代入しとく。
      valueCheck();
    });
});



//  モーダルウィンドウのYESを押した時に入力値をリセットする処理
// turbolinkがあると、ready使えなから、以下の様に書く
// document.addEventListener("turbolinks:load", function() {
//     $("#submitButton").on('click',function(){
//         // window.location.href = "/";  // resetボタンがバグってるから、画面更新にする。
//         // $('form').find("textarea, input, select ").val("").end().find(":checked").prop("checked", false);
//         // $('form').find("")
//         // $('.form-signin')[0].reset();   これ動かん。何でか分からん。
//         // removeAddedFR();
//         // $("#telError").fadeOut();
//     });
// });






//  1つ目の続柄を記入しているかのチェック
const frCheck = function(){
  const fr_value = $("#family_relation").get(0).value;    //　「続柄」の入力値
  const fr_name_value = $("#family_name").get(0).value;   //  「名前」の入力値

  const fr_value2 = fr_value.trim();                      //  trimして空白削除
  const fr_name_value2 =fr_name_value.trim();

  if(fr_value2=="" || fr_name_value2==""){
    $("#frError").show();
    return false;
  }else{
    $("#frError").fadeOut();
    return true;
  }

};
document.addEventListener("turbolinks:load", function(){
  $("#family_name").blur(function(){
    frCheck();
  });
});



//  続柄の記入欄を追加
// children()は、注目しているタグやクラスの1つ下の階層に、子要素が何個あるかを教えてくれる。
// append()は、注目しているタグやクラスに、（）内の要素を、子要素として追加
var countNumber = 0;
document.addEventListener("turbolinks:load", function(){
  $("#addFamilyRelation").click(function(){
       if (countNumber==1){
        $(".fr3").show();
       }else{
        $(".fr2").show();
        countNumber=1;
       }

    // if ($('.bbb').children().length < 10 ) {
    //   // 今回は「td」に2個inputが入ってるから、子要素は２個単位で追加される。4つ付け足したいなら、既存の２個＋8個で、10を上限にする。
    //   // クリックできる回数は子要素が１０個未満の時のみ。４回追加すると、子要素が１０個になるのでOK。
    //   $('.bbb').append("<br>続柄：<input type='text' name='familyRelation2' placeholder='例）父' class='family family2 zokugara input' > ");
    //   $(".bbb").append('<br>名前：<input type="text" name="familyRelationName2" placeholder="例）岡本　太郎" class="family family2 name_zoku input" > ');
    // }
  });
});







// 「redirect_to()」で戻るからいらんくなった！！！
// //  追加された家族構成を、最終確認モーダルのYESをクリックした時に、reset()と同時に発動。最初の二つ以外削除。
// const removeAddedFR = function(){
//   var y = $(".bbb").get(0); 
//   if (y.hasChildNodes()) {
//     while (y.childNodes.length > 4) {            //なぜ４かは分からん。
//         y.removeChild(y.lastChild);
//     }
//   }
// };




// 入力フォームで、Enterキー押されたら、勝手に送信されるから。Enterキー無効化
document.onkeypress = enter;
function enter(){
  if( window.event.keyCode == 13 ){
    return false;
  }
}
// でも「登録ボタン」押した時だけ有効にして、valueCheckを走らせたい
// function enter(){
//         if( window.event.keyCode == 13 ){
//           valueCheck();
//         }
//       }


// flashボタン消す
document.addEventListener("turbolinks:load", function(){
  $(".close").click(function(){
    $(".alert").get(0).style.display = "none";
  });
});






// $(function(){
//     if ($("#year") == "0"){
//         monthCheck();   
//     }
// });




// このコメントないと、「const」使う度にwarnning出してくる
/*jshint esversion: 6 */

//名前確認
const nameCheck = function(){
    const name_value = $("#name").get(0).value;
    const name_value2 = name_value.trim();
    if(name_value2 === ""){
        $("#nameError").show();
        return false;                             //「nameCheck()」という関数に、true, falseをリターンする。
    }else{
        $("#nameError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#name").blur(function(){
        nameCheck();
    });
});



//電話番号チェック
const telCheck = function(){
    var tel_value = $("#tel").get(0).value;
    if( !tel_value.match(/^(\d{3}-\d{4}-\d{4}|\d{11})$/)){  //正規表現にスペースはアカン。
        //matchやと、正規表現の文字が含まれているかどうかしかチェックしない。正規表現の文字さえ含まれていたら文字数が大きくても問題ない。
        //  だから今回は１１文字以上でもエラー文が出てくれなかった。
        // matchやと、文字列が検索に引っかからないとnull値を返す。
        // ^()で先頭一致、()$で後方一致。  両方使うことで完全一致にできる！！！！！！！！！！！
        $("#telError").show();
        return false;
    }else{
        $("#telError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#tel").blur(function(){
        telCheck();
    });
});



// メールアドレスのチェック
const mailCheck = function(){
    const mail_value = $("#mail").get(0).value;
    if( !mail_value.match(new RegExp(/^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}\.[A-Za-z0-9]{1,}$/))){
        $("#mailError").show();
        return false;
    }else{
        $("#mailError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#mail").blur(function(){
        mailCheck();
    });
});



//性別チェック
const sexCheck = function(){
    if( ($("#man").get(0).checked == false) && ($("#woman").get(0).checked==false ) ){
        $("#sexError").show();
        return false;
    }else{
        $("#sexError").fadeOut();
        return true;
    }
};
document.addEventListener("turbolinks:load", function(){
    $(".sex").blur(function(){
        sexCheck();
    });
});



// 西暦楽々生産機
$(document).on('turbolinks:load', function() {
  var time = new Date();
  var endYear = time.getFullYear();
  for(var i =1900; i<=endYear; i++){
      $("#year").get(0).add(new Option(i.toString() +"年", i.toString() ));
  }
 });



// 閏年チェック.       １００年で割れる年は、閏年ちゃう。でも、400年で割れる年は、閏年。
const monthCheck = function(){
    var year_value = $("#year").get(0).value;
    var month_value = $("#month").get(0).value;
    year_value = parseInt(year_value);
    month_value = parseInt(month_value);


    // .option「s」じゃないとアカン。select要素内の選択肢（option要素）のコレクションを指す。lengthで長さ測るには、リストと見なさなアカンから、コレクションじゃないとアカン。
    if(  ((year_value%4==0 && year_value%100!=0) || year_value%400==0) && month_value　== 2 ){                   //29
            for(var i=1; i<30; i++){
                $("#day").get(0).options[i] = new Option(i+"日", i);
                //「new Option(text,value,defaultSelected,selected)」の順番で、optionタグを追加。
                // .option「s」じゃないとアカン。select要素内の選択肢（option要素）のコレクションを指す。[]でリスト番号指定しているから、コレクションじゃないとアカン。
            }
    }else if(month_value == 1||                                   //31
            month_value == 3 ||
            month_value == 5 ||
            month_value == 7 ||
            month_value == 8 ||
            month_value == 10||
            month_value == 12 ){  // 「month_value == (1||3||5||7||8||10||12)」はアカン！！！！！
        for(var i=1; i<32; i++){
            $("#day").get(0).options[i] = new Option(i+"日", i);
        }
    }else if(month_value == 2 ){                              //28
        for(var i=1; i<29; i++){
            $("#day").get(0).options[i] = new Option(i+"日", i);
        }
    }else{                                                    //30
        for(var i=1; i<31; i++){
            $("#day").get(0).options[i] = new Option(i+"日", i);
        }
    }
};
document.addEventListener("turbolinks:load", function(){
    $("#year,#month").change(function(){
        monthCheck();
    });
});




// JSONデータ読み込み。    選択した最終学歴によって学校リストを変更
function schoolSelect(value) {

    arrayNum = $("#school").get(0).options.length;
    //セレクトボックスの初期化
    for(var i=1; i<arrayNum; i++) {
      $("#school").get(0).options[1] = null;
    }

    // ラジオボタンのvalueで条件分岐
    switch(value) {      // inputタグで選択式の場合、設定したvalueが代入されてる。
        case "中卒": //中学
            $.getJSON("/app/assets/javascripts/school.json",{name:"school_name"} , function(data) {
                // {name:"chara"}       入力提出さえたデータは相手側のデータサーバーに送られる。データを検索しやすくする為のタグ付をしている！！！
                // $.getJSONで、データを読み込んだら、その後の処理を、「function」で決められる。
                var list = data.juniorhighschool;
                $.each(list, function(i) {       //////// なんでここで「i」を宣言できてんの？？？
                    // 「$.each」は「for」の書き換え。　　　「list」すべてのデータにfunctionを適応。
                    $("#school").get(0).options[i] = new Option(list[i], list[i]);
                });
            });
            break;

            //  オブジェクトを配列のように使うには、「Object.values(オブジェクトデータ)」か「for i in オブジェクトデータ」
        case "高卒": //高校
            $.getJSON("school.json", {name: "school_name"}, function(data) {
                var list = data.highschool;
                var values = Object.values(list);       //  jsonのデータは配列ではなくオブジェクト！！！！！
                for(var i=1; i< values.length; i++ ) {
                    $("#school").get(0).options[i] = new Option(list[i], list[i]);
                }
            });
            //     $.each(list, function(i) {
            //         $.school.options[i] = new Option(list[i], list[i]);
            //     });
            // });

            break;

            //  オブジェクトを配列のように使うには、「Object.values(オブジェクトデータ)」か「for i in オブジェクトデータ」
        case "大卒": //大学
            $.getJSON("school.json", {name: "school_name"}, function(data) {
                var list = data.university;
                for(var i in data.university){  //  「for in」もオブジェクトを配列のように使える。
                    $("#school").get(0).options[i] = new Option(list[i], list[i]);
                }

                // $.each(list, function(i) {       //  https://q-az.net/without-jquery-each/
                //     $.school.options[i] = new Option(list[i], list[i]);
                // });
            });
            break;


        case "学歴無し": //
        // これ入れな、「Expected a 'break' statement before 'default'. (W086)」ってwarnning出る。
        /* falls through */
        default: break;
    }
}
// これも、turbolinkのせいで、ready動かんかったから書き換えた
document.addEventListener("turbolinks:load", function() {
    $(".career").change(function(){
        var careerNum = $('input[class="career"]:checked').val();      // class=careerのラジオボタンの中から、チェックされてるボタンのvalueを取得！！！
        schoolSelect(careerNum);
    });
});




// 学歴チェック
const careerCheck = function(){
    var school_value = $("#school").get(0).value;
    if( ($("#junior").get(0).checked==false) && ($("#high-school").get(0).checked==false) &&
        ($("#university").get(0).checked==false) && ($("#no-career").get(0).checked==false ) ){
            $("#careerError").show();
            return false;
    }else if(($("#junior").get(0).checked==true ||
              $("#high-school").get(0).checked==true ||
              $("#university").get(0).checked==true) &&
              school_value==0 ){
                $("#careerError").show();
                return false;
    }else{
            $("#careerError").fadeOut();
            return true;
        }
};
document.addEventListener("turbolinks:load", function(){
    $("#school").blur(function(){
        careerCheck();
    });
});



//  追加された続柄の値を取得
//  値は入ってなくてもOK。もし両方セットで記入されていたら使うけど、片方だけだったら無視
//  登録ボタンを押した時に、最終確認モーダルでのみ出現すべき
//  2個目以降の入力値が変更されても更新されない！！！！！！！
var zoku;
var zokuname;
var y = $(".bbb").get(0);     // 「removeAddedFR」でもこれ使うからグローバル変数にしてる。

// const checkChildFR = function(){
//   var k = 0;
//   var fff = $(".bbb").children('family');
//   for(var i=2; i<fff.length; i=i+2){
//     var j = i+1;
//     zoku = fff.get(i).value.trim();
//     zokuname = fff.get(j).value.trim();
//     if(zoku=="" || zokuname==""){
//       // 何もしない   「return false」としてしまうとそこで関数が終了してしまう。forループも止まる。
//     }else{
//       // 最初はget()の中が0じゃないとあかん
//       $(".multipleFR").get(k).innerHTML = "　　　　　続柄:" + zoku + "　名前:" + zokuname +
//       "<br>"+ "<span class='multipleFR' ></span>" ;
//       k++;
//     }
//   }
// };





// 最終チェックのモーダルウィンドウ
function valueCheck() {

    //初期状態からいきなり登録した場合にエラーを出す為に、まずは必須項目の内容チェック関数を呼び出す
    nameCheck();
    mailCheck();
    sexCheck();
    careerCheck();
    frCheck();
    telCheck();

    // モーダルに表示するために、入力値を変数に代入しとく。
    var name = $("#name").get(0).value;
    var furigana = $("#furigana").get(0).value;
    var tel = $("#tel").get(0).value;
    var mail = $("#mail").get(0).value;
    var sex;
    if($("#man").get(0).checked == true) {
        sex = "男性";
    } else if($("#woman").get(0).checked == true) {
        sex = "女性";
    }
    var year = $("#year").get(0).value;
    var month = $("#month").get(0).value;
    var day = $("#day").get(0).value;
    var school;
    if($("#no-career").get(0).checked == true) {
        school = "なし";
    } else {
        school = $("#school").get(0).value; // プルダウンで選択された学校名が、文字列データとして代入されている。
    }

    // 1つ目の家族構成
    var fr = $("#family_relation").get(0).value;
    var fn = $("#family_name").get(0).value;

    // 2つ目の家族構成
    var fr2 = $("#family_relation2").get(0).value;
    var fn2 = $("#family_name2").get(0).value;

    // 3つ目の家族構成
    var fr3 = $("#family_relation3").get(0).value;
    var fn3 = $("#family_name3").get(0).value;

    // 入力値を代入したさっきの変数を使って、モーダルウィンドウに表示する
    $("#check_name").get(0).innerHTML = '名前<span style="color: #FF0000;">*</span>：' + name + "<br>";
    $("#check_furigana").get(0).innerHTML = "ふりがな：" + furigana + "<br>";
    $("#check_tel").get(0).innerHTML = "電話番号<span style='color: #FF0000;'>*</span>：" + tel + "<br>";
    $("#check_mail").get(0).innerHTML = 'メールアドレス<span style="color: #FF0000;">*</span>：' +mail+ "<br>";
    $("#check_sex").get(0).innerHTML = '性別<span style="color: #FF0000;">*</span>：' + sex + "<br>";
    $("#check_birthday").get(0).innerHTML = "生年月日：" + year + "年" + month + "月" + day + "日" + "<br>";
    $("#check_school").get(0).innerHTML = '最終学歴<span style="color: #FF0000;">*</span>：' + school + "<br>";
    $("#check_fr").get(0).innerHTML = '家族構成1<span style="color: #FF0000;">*</span>：' +'続柄:'+ fr + '　名前:' +fn+ "<br>";

    // 家族構成2、3人目を記入していた場合
    // 「&&」やと続柄・名前の片方が記入されてるだけで保存されるから「||」を否定（!）する形にしてる。
    // このままやと、最終確認モーダルに表示されないだけで、データベースには保存される。
    if ( !(fr2=="" || fn2=="") ){
        $("#check_fr2").get(0).innerHTML = '家族構成2： ' +'続柄:'+ fr2 + '　名前:' +fn2+ "<br>";
        $("#check_fr2").show();
    }else{
        $("#check_fr2").get(0).style.display = "none";
    }
    if ( !(fr3=="" || fn3=="") ){
        $("#check_fr3").get(0).innerHTML = '家族構成3： ' +'続柄:'+ fr3 + '　名前:' +fn3+ "<br>";
        $("#check_fr3").show();
    }else{
        $("#check_fr3").get(0).style.display = "none";
    }

    // spanタグはデフォルトがinlineやからいらん
    // $("#check_name").get(0).style.display = "inline";
    // $("#check_furigana").get(0).style.display = "inline";
    // $("#check_tel").get(0).style.display = "inline";
    // $("#check_mail").get(0).style.display = "inline";
    // $("#check_sex").get(0).style.display = "inline";
    // $("#check_birthday").get(0).style.display = "inline";
    // $("#check_school").get(0).style.display = "inline";
    // $("#check_fr").get(0).style.display = "inline";
    // $("#check_fr2").get(0).style.display = "inline";
    // $("#check_fr3").get(0).style.display = "inline";
    // $(".multipleFR").get(0).style.display = "inline";     // get(0)やと5個全部でーへんかも。get(i)のようにしたい。

    // 必須項目じゃない入力フォームに、誤りのある入力値or未記入なら、モーダルウィンドウの最終確認画面には出さない。
    if(furigana == "") {
        $("#check_furigana").get(0).style.display = "none";
    }
    // if(!tel.match(/^(\d{3}-\d{4}-\d{4}|\d{11})$/)) {
    //     $("#check_tel").get(0).style.display = "none";
    // }
    if((year == "0") || (month == "0") || (day == "0") || (day == "" )) {
        // dayはremoveChild()使ってるからvalueが「""」にもなる。
        $("#check_birthday").get(0).style.display = "none";
    }

    //すべての必須項目でエラーなしならモーダルウィンドウを表示
    if(nameCheck()==true && mailCheck()==true && sexCheck()==true &&
      careerCheck()==true && frCheck() == true && telCheck()==true ) {
        var baseLayer    = $('#modalBaseLayer').get(0); //モーダルウィンドウ
        var submitButton       = $('#submitButton').get(0); //はい
        var closeTrigger = $('#closeModal').get(0); //いいえ

        // モーダルを表示
        baseLayer.style.visibility = 'visible';

        // id=submitButtonは、モーダルウィンドウの「はい」のボタン
        submitButton.addEventListener('click', function() {
            // このボタンを押した時（"click"した時）にモーダルを非表示にする。
            // 「addEventListener(イベントのタイプ,function(){},false)」で、クリックした時に起こる動作を作れる。
            baseLayer.style.visibility = 'hidden';
        }, false);             ////////// なんでfalseあんの？？？？？？？？？？？？？

        //いいえを押したとき
        closeTrigger.addEventListener('click', function(event) {
            // モーダルを非表示
            baseLayer.style.visibility = 'hidden';
        }, false);             ////////// なんでfalseあんの？？？？？？？？？？？？？
    }



}
document.addEventListener("turbolinks:load", function(){
    $("#finalCheck").click(function(){
    //   checkChildFR();     //  この関数をValueCheck()より先に実行して、zoku,zokunameに値を代入しとく。
      valueCheck();
    });
});



//  モーダルウィンドウのYESを押した時に入力値をリセットする処理
// turbolinkがあると、ready使えなから、以下の様に書く
// document.addEventListener("turbolinks:load", function() {
//     $("#submitButton").on('click',function(){
//         // window.location.href = "/";  // resetボタンがバグってるから、画面更新にする。
//         // $('form').find("textarea, input, select ").val("").end().find(":checked").prop("checked", false);
//         // $('form').find("")
//         // $('.form-signin')[0].reset();   これ動かん。何でか分からん。
//         // removeAddedFR();
//         // $("#telError").fadeOut();
//     });
// });






//  1つ目の続柄を記入しているかのチェック
const frCheck = function(){
  const fr_value = $("#family_relation").get(0).value;    //　「続柄」の入力値
  const fr_name_value = $("#family_name").get(0).value;   //  「名前」の入力値

  const fr_value2 = fr_value.trim();                      //  trimして空白削除
  const fr_name_value2 =fr_name_value.trim();

  if(fr_value2=="" || fr_name_value2==""){
    $("#frError").show();
    return false;
  }else{
    $("#frError").fadeOut();
    return true;
  }

};
document.addEventListener("turbolinks:load", function(){
  $("#family_name").blur(function(){
    frCheck();
  });
});



//  続柄の記入欄を追加
// children()は、注目しているタグやクラスの1つ下の階層に、子要素が何個あるかを教えてくれる。
// append()は、注目しているタグやクラスに、（）内の要素を、子要素として追加
var countNumber = 0;
document.addEventListener("turbolinks:load", function(){
  $("#addFamilyRelation").click(function(){
       if (countNumber==1){
        $(".fr3").show();
       }else{
        $(".fr2").show();
        countNumber=1;
       }

    // if ($('.bbb').children().length < 10 ) {
    //   // 今回は「td」に2個inputが入ってるから、子要素は２個単位で追加される。4つ付け足したいなら、既存の２個＋8個で、10を上限にする。
    //   // クリックできる回数は子要素が１０個未満の時のみ。４回追加すると、子要素が１０個になるのでOK。
    //   $('.bbb').append("<br>続柄：<input type='text' name='familyRelation2' placeholder='例）父' class='family family2 zokugara input' > ");
    //   $(".bbb").append('<br>名前：<input type="text" name="familyRelationName2" placeholder="例）岡本　太郎" class="family family2 name_zoku input" > ');
    // }
  });
});











// 入力フォームで、Enterキー押されたら、勝手に送信されるから。Enterキー無効化
document.onkeypress = enter;
function enter(){
  if( window.event.keyCode == 13 ){
    return false;
  }
}
// でも「登録ボタン」押した時だけ有効にして、valueCheckを走らせたい
// function enter(){
//         if( window.event.keyCode == 13 ){
//           valueCheck();
//         }
//       }


// flashボタン消す
document.addEventListener("turbolinks:load", function(){
  $(".close").click(function(){
    $(".alert").get(0).style.display = "none";
  });
});




