void setup() {
  size(1000, 750, P3D);
  camera(200, 200, 200, 0, 0, 0, 0, 0, -1);
  noStroke();
}

void keyPressed() {
  if (key == 'q' || key == 'Q') { //モード切替
    if (Zmode != 2) {
      Zmode += 1;
    } else {
      Zmode = 0;
    }
  }
  if (key == 'p' || key == 'P') { //モード切替
    if (XYmode != 2) {
      XYmode += 1;
    } else {
      XYmode = 0;
    }
  }
}

void draw() {
  background(255);

  text("XY axis rotation mode ="+XYmode+"\nZ-axis rotation mode ="+Zmode, 20, 0);//現在のモードを表示


  if (keyPressed) {
    if (key == 'a' || key == 'A') { // 逆回転
      if (Zmode == 0) {
        baseDeg -= dif;
      } else if (Zmode == 1) {
        arm1Deg -= dif;
      } else if (Zmode == 2) {
        arm2Deg -= dif;
      }
    }
    if (key == 'd' || key == 'D') { // 正回転
      if (Zmode == 0) {
        baseDeg += dif;
      } else if (Zmode == 1) {
        arm1Deg += dif;
      } else if (Zmode == 2) {
        arm2Deg += dif;
      }
    }
    if (key == 'r' || key == 'R') { // リセット
      baseDeg = r_baseDeg.reset();
      arm1Deg = r_arm1Deg.reset();
      angleX1 = r_angleX1.reset();
      angleY1 = r_angleY1.reset();
      arm2Deg = r_arm2Deg.reset();
      angleX2 = r_angleX2.reset();
      angleY2 = r_angleY2.reset();
    }
  }


  if (mousePressed) {
    if (XYmode != 2) {
      angleX1 = m_angleX1.move();
      angleY1 = m_angleY1.move();
    }
    if (XYmode != 1) {
      angleX2 = m_angleX2.move();
      angleY2 = m_angleY2.move();
    }
  }

  o_baseDeg = new over180(baseDeg);
  o_arm1Deg = new over180(arm1Deg);
  o_angleX1 = new over180(angleX1);
  o_angleY1 = new over180(angleY1);
  o_arm2Deg = new over180(arm2Deg);
  o_angleX2 = new over180(angleX2);
  o_angleY2 = new over180(angleY2);

  //180を超えた時の処理（リセット時の効率化）
  baseDeg = o_baseDeg.reversal();
  arm1Deg = o_arm1Deg.reversal();
  angleX1 = o_angleX1.reversal();
  angleY1 = o_angleY1.reversal();
  arm2Deg = o_arm2Deg.reversal();
  angleX2 = o_angleX2.reversal();
  angleY2 = o_angleY2.reversal();

  r_baseDeg = new Reset(baseDeg, dif, 0);
  r_arm1Deg = new Reset(arm1Deg, dif, 0);
  r_angleX1 = new Reset(angleX1, dif, 1);
  r_angleY1 = new Reset(angleY1, dif, 1);
  r_arm2Deg = new Reset(arm2Deg, dif, 0);
  r_angleX2 = new Reset(angleX2, dif, 1);
  r_angleY2 = new Reset(angleY2, dif, 1);

  m_angleX1 = new mouse(mouseX, width, angleX1, mousedif);
  m_angleY1 = new mouse(mouseY, height, angleY1, mousedif);
  m_angleX2 = new mouse(mouseX, width, angleX2, mousedif);
  m_angleY2 = new mouse(mouseY, height, angleY2, mousedif);


  // baseの回転
  rotateZ(radians(baseDeg));
  // base
  translate(0, 0, baseH/2);
  fill(255, 0, 0);
  box(baseW, baseD, baseH);
  // link1の回転
  translate(0, 0, baseH/2);
  rotateZ(radians(arm1Deg));
  rotateX(radians(angleX1));
  rotateY(radians(angleY1));
  // link1
  translate(0, 0, arm1H/2);
  fill(0, 255, 0);
  box(arm1W, arm1D, arm1H);
  // link2の回転
  translate(0, 0, arm1H/2);
  rotateZ(radians(arm2Deg));
  rotateX(radians(angleX2));
  rotateY(radians(angleY2));
  // link2
  translate(0, 0, arm1H/2);
  fill(0, 0, 255);
  box(arm2W, arm2D, arm2H);

  // デバッグ用
  println("baseDeg="+baseDeg+", arm1Deg="+arm1Deg+", arm2Deg="+arm2Deg+", angleX1="+angleX1+
    ", angleY1="+angleY1+", angleX2="+angleX2+", angleY2="+angleY2);
}
