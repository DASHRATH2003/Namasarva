// This file is only used on Web
import 'dart:html' as html;

bool isMobileWeb() {
  return html.window.navigator.userAgent.contains("Mobi");
}
