# SWIGの使い方

SWIGは魔法。C/C++のコードを、なんだか良く判らないけれど、すてきな感じに他のプログラミング言語から使えるようにしてくれる魔法。だけど、魔法にも限界がある。カボチャを馬車に変えたとして、ボクたちが望んだのは馬車ではなくモールトンだったかもしれない。そもそもC++がカボチャであると誰に断ずることができるだろう。

SWIGのドキュメントは、「スクリプト言語からC/C++プログラムへのインタフェースを構築するためのソフトウェア開発ツールである」と説明している [[1][1.1 Introduction]] 。この短い文章は含蓄に富んでいる。

+ もちろん、本当にはスクリプト言語だけではない。コンパイルされるプログラミング言語にも対応している。おおかたのプログラミング言語はCプログラムを利用するなんらかの機構を備えているけれど、その方式はさまざま、玉石混淆だ。
+ C/C++プログラムへのインタフェースを構築するためのものであるということ。逆、つまり、C/C++プログラムからスクリプト言語へのインタフェース──たとえば、スクリプト言語の関数をC/C++から呼びだす──は、SWIGのスコープに含まれない。
+ C/C++ソースコードではなく、C/C++プログラムであるということ。スクリプト言語がインタフェースを利用するのは、ほとんど自明なことだけれど、コンパイルの後だ。つまり、テンプレートが具現化された後だ。

SWIGの魔法の根源は、ヒューリスティックな知識の積み重ねにあると言えなくもない。たとえば、糞みたいなCの関数の例を見てみよう[[2][9.1 The typemaps.i library]]。

    void add(double a, double b, double* OUTPUT) {
      *OUTPUT = a + b;
    }

たとえば、Luaでは、

    local bridge = require("bridge_lua")
    local result = add(42, 43)

のように呼びだすことができる[[3][26.4 Typemaps]]。ワォ！

だけど、魔法にも限界がある。SWIGはC/C++のヘッダからインタフェースコードを生成する。「SWIGはほとんどのC/C++の宣言を解析できるけれど、完全なC/C++の解析器の実装を提供しているわけではない。これらの制限のほとんどは、とても複雑な型宣言やいくつかの高度なC++の機能に関連している」とある[[4][5.1.6 Parser Limitations]]。

残念がるのはまだ早い。SWIG 3.0はC++11の構文をサポートする[[5][SWIG and C++11]]。たしかに、それでも、本当のメタプログラミングをSWIGに解釈させるのは難しいかもしれない。既に書いたように、だけど、スクリプト言語がインタフェースを利用するのは、コンパイルの後だ。すべてのメタプログラミングが既に終わった後だ。

この文章と、付属するサンプルコードは、ほとんどこの問題について論じるために書かれた。

* [Boost.Optional][]
* [Boost.Any][]
* [Boost.Variant][]

のインタフェースを構築し、LuaとJavaから利用できることを示す。

## 開発環境

* CMake 2.8.12
* SWIG 2.0.11
* GCC 4.8.2
* Boost 1.55.0
* Lua 5.2.2
* Java 1.6.0

## ビルド例

最新のGCCがパスの通った場所にある。また、`${CMAKE_INSTALL_PREFIX}/include`以下にBoostがインストールされているとする。`-fno-strict-aliasing`はSWIGが生成するコードでエリアシング警告が出る場合があるため。

    mkdir build
    cd build
    env CC=gcc CXX=g++ \
      cmake \
        -DCMAKE_CXX_FLAGS="-fno-strict-aliasing -Wall -W -Wno-unused-local-typedefs -Wno-missing-field-initializers -Wno-unused-parameter -std=c++11" \
        -DCMAKE_BUILD_TYPE=release \
        -DCMAKE_INSTALL_PREFIX=/opt/vaporoid/package/prefix ..
    make
    make test

## 言い訳

サンプルコード、なかんずくCMakeLists.txtは、プロダクションのために書かれたわけではない。参考程度ならばともあれ、実際に利用するには細心の注意を払う必要がある。たとえば、

* Luaのためにインタフェースを生成するには、SWIGに-nomoduleglobalオプションを付けるべきだろう（CMakeのSWIG対応は、複数のプログラミング言語や複数のインタフェースを扱おうとする場合に、意図した動作をさせることが難しい。たとえば、SWIGに渡すオプションを細かく制御できない）。
* インタフェース定義の依存関係が定義されていないので、ビルドの際に手動で更新時刻を変更する必要があるかもしれない。
* C++の例外をまともに扱っていない。これはSWIG 3.0で再考するべき課題。

## Boost.Optional

Boost.Optional用のインタフェース定義を[optional.i][]のように与えた。解説する前に、SWIGを使う際の重要な戦略について議論する必要があるだろう。すなわち、`-includeall`（と`-importall`）を使うかどうか[[6][7 Preprocessing]]。Boostのどれかのヘッダをインクルードしようと思っているんだったら、利用はおすすめできない。SWIGが解析できないような高度すぎるメタプログラミングを行っているヘッダを、どこでインクルードしているか判ったものじゃない。

次に、インタフェース定義の代わりに、Boostヘッダを直接使うべきかどうかという選択肢がある。いくつかの実験の結果、インタフェース定義を書きくだすほうが効率的であるという結論を得た。BoostヘッダをSWIGに解析してもらうためには、SWIGが述べたてる不平をひとつずつつぶしていかなければならなかった。一方、Boostの良く整備されたドキュメントをコピー＆ペーストすれば、インタフェース定義を書きくだすのは簡単だった。

[optional.i][]に解説するべき点は少ない。演算子で提供されるようになった機能をdeprecatedな関数名で置き換えた。演算子オーバーロードに対応していないプログラミング言語のことを考えたら、結局、なんらか名づける必要はあるわけだから。そして、重要な欠点がある。これらに比べれば、非constのアクセス関数がないとか、`operator->`がないとかはちいさな問題である。

+ TがCopyConstructibleであることを強制する
+ InPlaceFactoryに対応していない

良い実装方法が思い浮かばなかったというのが正直なところだ。

さて、テンプレートを具現化してあげる必要がある。

    %template(optional_int)    boost::optional<int>;
    %template(optional_string) boost::optional<std::string>;
    %template(optional_sample) boost::optional<sample>;

`%template`の説明は難しく長い。とても大雑把に言うと、テンプレートを具現化して、新しい名前を導入する。名づけられた名前でアクセスできるようになる。たとえば、Luaでは、

    local bridge = require("bridge_lua")
    local v = bridge.optional(42)
    if v:is_initialized() then
      print(v:get_value_or(69))
    end

のように書くことができる。

### %templateの効用

SWIGはマングリング規則に従って、適当に名前を決めてくれる。だけど、引数がたくさんあるテンプレートから名前を生成すると、とても長い名前になってしまうことがある。ところで、SWIGでJavaのインタフェースを生成すると、プロキシクラスと呼ばれるクラスも生成してくれる。そう、場合によっては、とても長い名前のクラスを。

ひるがえって、Javaのクラス名は現実的に何文字まで許されるか。バイトコードの仕様よりも、ファイルシステムとオペレーションシステムの制約が先に立つのが現実だ。つまり、ファイル名の制約だ。こうして、名づけることは否応無しの現実となる。

## Boost.Any

Boost.Any用のインタフェース定義を[any.i][]のように与えた。（続く）

## Boost.Variant

Boost.Variant用のインタフェース定義を[variant.i][]のように与えた。（続く）


[1.1 Introduction]:           http://www.swig.org/Doc2.0/Preface.html#Preface_nn2
[5.1.6 Parser Limitations]:   http://www.swig.org/Doc2.0/SWIG.html#SWIG_nn8
[6.18 Templates]:             http://www.swig.org/Doc2.0/SWIGPlus.html#SWIGPlus_nn30
[7 Preprocessing]:            http://www.swig.org/Doc2.0/Preprocessor.html#Preprocessor
[9.1 The typemaps.i library]: http://www.swig.org/Doc2.0/Arguments.html#Arguments_nn2
[26.4 Typemaps]:              http://www.swig.org/Doc2.0/Lua.html#Lua_nn24
[SWIG and C++11]:             https://github.com/swig/swig/blob/master/Doc/Manual/CPlusPlus11.html

[Boost.Optional]: http://www.boost.org/doc/libs/1_55_0/libs/optional/doc/html/index.html
[Boost.Any]:      http://www.boost.org/doc/libs/1_55_0/doc/html/any.html
[Boost.Variant]:  http://www.boost.org/doc/libs/1_55_0/doc/html/variant.html

[optional.i]: https://github.com/vaporoid/recipe_swig/blob/master/src/optional.i
[any.i]:      https://github.com/vaporoid/recipe_swig/blob/master/src/any.i
[blank.i]:    https://github.com/vaporoid/recipe_swig/blob/master/src/blank.i
[variant.i]:  https://github.com/vaporoid/recipe_swig/blob/master/src/variant.i
[bridge.i]:   https://github.com/vaporoid/recipe_swig/blob/master/src/bridge.i
