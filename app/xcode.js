/***

    xcode.js

***/

// js -> P5ViewController nativeAPI_sample (アラートを表示)
function nativeAPI_alert() {
  document.location = "native-api://alert(message)"
}

// js -> P5ViewController nativeAPI_sample (アラートを表示)
function nativeAPI_showSubView() {
  document.location = "native-api://showSubView()"
}

// P5ViewController -> js (円を描画)
function p5jsAPI_ellipse(r, g, b) {
  var p5 = getProcessingInstance();
  p5.pushStyle();
  p5.fill(r, g, b);
  p5.ellipse(p5.width/2, p5.height/2, 200, 200);
  p5.popStyle();
}