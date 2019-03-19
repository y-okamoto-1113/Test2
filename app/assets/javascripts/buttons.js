
// このコメントないと、「const」使う度にwarnning出してくる
/*jshint esversion: 6 */

//名前確認 「required:""」で代用
// 続柄チェック 「required:""」で代用
//性別チェック 「required:""」で代用
// JSONデータ読み込み。 「required:""」で代用
// 学歴チェック 「required:""」で代用


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
    if( !mail_value.match(new RegExp(/^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z_.-]{1,}\.[A-Za-z]{1,}$/))){
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
    if(  ((year_value%4==0 && year_value%100!=0) || year_value%400==0) && month_value== 2 ){                   //29
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



var y = $(".bbb").get(0);     // 「removeAddedFR」でもこれ使うからグローバル変数にしてる。

// 入社日チェック
const joinedCheck = function(){
    var jycheck = $("#joined_year").get(0).value;
    var jmcheck = $("#joined_month").get(0).value;
    var jdcheck = $("#joined_day").get(0).value;
    if ( (jycheck==0) ||  (jmcheck==0) || (jdcheck==0) ){
        $("#joinedError").show();
        return false;
    }else{
        $("#joinedError").fadeOut();
        return true;
    }
};

document.addEventListener("turbolinks:load", function(){
    $("#joined_day").blur(function(){
        joinedCheck();
    });
});



// 最終チェックのモーダルウィンドウ
function valueCheck() {
    //初期状態からいきなり登録した場合にエラーを出す為に、まずは必須項目の内容チェック関数を呼び出す
    telCheck();
    mailCheck();
    joinedCheck();

    //すべての必須項目でエラーなしならモーダルウィンドウを表示
    if( mailCheck()==true && telCheck()==true && joinedCheck()==true ) {
        // ３つのチェック通ったらOKにする
    }
}

document.addEventListener("turbolinks:load", function(){
    $('#finalCheck').click(function(){
        valueCheck();
    });
});


//  続柄の記入欄を追加
var countNumber = 0;
document.addEventListener("turbolinks:load", function(){
  $("#addFamilyRelation").click(function(){
       if (countNumber==1){
        $(".fr3").show();
       }else{
        $(".fr2").show();
        countNumber=1;
       }
  });
});





// 入力フォームで、Enterキー押されたら、勝手に送信されるから。Enterキー無効化
// document.onkeypress = enter;
// function enter(){
//   if( window.event.keyCode == 13 ){
//     return false;
//   }
// }



// flashボタン消す
const closeBtn = function(){
    console.log('aaa');
    $(".notice").get(0).style.display = "none";
    console.log('bbb');
};




// 入社日チェック.
$(document).on('turbolinks:load', function() {
    var time = new Date();
    var joinedEndYear = time.getFullYear();
    for(var i =1900; i<=joinedEndYear; i++){
        $("#joined_year").get(0).add(new Option(i.toString() +"年", i.toString() ));
    }
});

const joinedMonthCheck = function(){
    var joined_year_value = $("#joined_year").get(0).value;
    var joined_month_value = $("#joined_month").get(0).value;
    joined_year_value = parseInt(joined_year_value);
    joined_month_value = parseInt(joined_month_value);


    // .option「s」じゃないとアカン。select要素内の選択肢（option要素）のコレクションを指す。lengthで長さ測るには、リストと見なさなアカンから、コレクションじゃないとアカン。
    if(  ((joined_year_value%4==0 && joined_year_value%100!=0) || joined_year_value%400==0) && joined_month_value== 2 ){                   //29
            for(var i=1; i<30; i++){
                $("#joined_day").get(0).options[i] = new Option(i+"日", i);
                //「new Option(text,value,defaultSelected,selected)」の順番で、optionタグを追加。
                // .option「s」じゃないとアカン。select要素内の選択肢（option要素）のコレクションを指す。[]でリスト番号指定しているから、コレクションじゃないとアカン。
            }
    }else if(joined_month_value == 1||                                   //31
            joined_month_value == 3 ||
            joined_month_value == 5 ||
            joined_month_value == 7 ||
            joined_month_value == 8 ||
            joined_month_value == 10||
            joined_month_value == 12 ){  // 「month_value == (1||3||5||7||8||10||12)」はアカン！！！！！
        for(var i=1; i<32; i++){
            $("#joined_day").get(0).options[i] = new Option(i+"日", i);
        }
    }else if(joined_month_value == 2 ){                              //28
        for(var i=1; i<29; i++){
            $("#joined_day").get(0).options[i] = new Option(i+"日", i);
        }
    }else{                                                    //30
        for(var i=1; i<31; i++){
            $("#joined_day").get(0).options[i] = new Option(i+"日", i);
        }
    }
};

document.addEventListener("turbolinks:load", function(){
    $("#joined_year,#joined_month").change(function(){
        joinedMonthCheck();
    });
});

// renderしてきたときに、selectタグの値が既存値以外、選択できへん
// これで解決。
document.addEventListener("turbolinks:load", function(){
    var jycheck = $("#joined_year").get(0).value;
    var jmcheck = $("#joined_month").get(0).value;
    if ( !(jycheck==0) &&  !(jmcheck==0)){
        joinedMonthCheck();
    }
});

