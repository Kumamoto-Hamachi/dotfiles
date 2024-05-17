#オリジナルの関数
function add(n, m){
    return n + m;
}

#呼び出してみる
add(1, 2) // 3

#フックしてみる
var origin = add;
add = function(){
    console.log(arguments);#//呼び出されたパラメータを出力

    #//オリジナルへ委譲
    var result = origin.apply(null, arguments);

    #//結果を2倍して返す
    return result * 2;
}

add(1, 2) #// 6

