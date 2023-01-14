#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform vec2 texOffset;

void main(void) {
  vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
  vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
  vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
  vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
  vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
  vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
  vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
  vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
  vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);
  
  vec4 col0 = texture2D(texture, tc0);
  vec4 col1 = texture2D(texture, tc1);
  vec4 col2 = texture2D(texture, tc2);
  vec4 col3 = texture2D(texture, tc3);
  vec4 col4 = texture2D(texture, tc4);
  vec4 col5 = texture2D(texture, tc5);
  vec4 col6 = texture2D(texture, tc6);
  vec4 col7 = texture2D(texture, tc7);
  vec4 col8 = texture2D(texture, tc8);

  // counting the number of live cells
  int cellsR = 0;
  cellsR += (col0.r > 0.5) ? 1 : 0;
  cellsR += (col1.r > 0.5) ? 1 : 0;
  cellsR += (col2.r > 0.5) ? 1 : 0;
  cellsR += (col3.r > 0.5) ? 1 : 0;
  cellsR += (col5.r > 0.5) ? 1 : 0;
  cellsR += (col6.r > 0.5) ? 1 : 0;
  cellsR += (col7.r > 0.5) ? 1 : 0;
  cellsR += (col8.r > 0.5) ? 1 : 0;
  
  /* uncomment for RGB-mode
  int cellsG = 0;
  cellsG += (col0.g > 0.5) ? 1 : 0;
  cellsG += (col1.g > 0.5) ? 1 : 0;
  cellsG += (col2.g > 0.5) ? 1 : 0;
  cellsG += (col3.g > 0.5) ? 1 : 0;
  cellsG += (col5.g > 0.5) ? 1 : 0;
  cellsG += (col6.g > 0.5) ? 1 : 0;
  cellsG += (col7.g > 0.5) ? 1 : 0;
  cellsG += (col8.g > 0.5) ? 1 : 0;
  
  int cellsB = 0;
  cellsB += (col0.b > 0.5) ? 1 : 0;
  cellsB += (col1.b > 0.5) ? 1 : 0;
  cellsB += (col2.b > 0.5) ? 1 : 0;
  cellsB += (col3.b > 0.5) ? 1 : 0;
  cellsB += (col5.b > 0.5) ? 1 : 0;
  cellsB += (col6.b > 0.5) ? 1 : 0;
  cellsB += (col7.b > 0.5) ? 1 : 0;
  cellsB += (col8.b > 0.5) ? 1 : 0;
  */
  
  // one color mode
  col4 = (cellsR == 3) ? vec4(1, 1, 1, 1) : col4 ;
  col4 = (cellsR < 2) || (cellsR > 3)  ? vec4(0, 0, 0, 0) : col4 ;
  
  /* uncomment for RGB-mode
  col4.r = (cellsR == 3) ? 1 : col4.r ;
  col4.r = (cellsR < 2) || (cellsR > 3)  ? 0 : col4.r ;
  col4.g = (cellsG == 3) ? 1 : col4.g ;
  col4.g = (cellsG < 2) || (cellsG > 3)  ? 0 : col4.g ;
  col4.b = (cellsB == 3) ? 1 : col4.b ;
  col4.b = (cellsB < 2) || (cellsB > 3)  ? 0 : col4.b ;
  */
  
  gl_FragColor = vec4(col4) ;
}
