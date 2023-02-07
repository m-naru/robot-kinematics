float baseW = 30;
float baseD = 30;
float baseH = 50;
float baseDeg = 0;
float arm1W = 25;
float arm1D = 20;
float arm1H = 60;
float arm1Deg = 0;
float arm2W = 15;
float arm2D = 10;
float arm2H = 55;
float arm2Deg = 0;
float angleX = 0;
float angleY = 0;
float dif = 1;
float mousedif = 0.001;
int mode = 0;
void setup() {
  size(1000, 750, P3D);
  camera(200, 200, 200, 0, 0, 0, 0, 0, -1);
  noStroke();
}

void keyPressed() {
  if (key == 'q' || key == 'Q') { //モード切替
    if (mode != 2) {
      mode += 1;
    } else {
      mode = 0;
    }
  }
}

void draw() {
  background(255);

  text("mode="+mode, 20, 20);//現在のモードを表示

  if (keyPressed) {
    if (key == 'a' || key == 'A') { // 逆回転
      if (mode == 0) {
        baseDeg -= dif;
      } else if (mode == 1) {
        arm1Deg -= dif;
      } else if (mode == 2) {
        arm2Deg -= dif;
      }
    }
    if (key == 'd' || key == 'D') { // 正回転
      if (mode == 0) {
        baseDeg += dif;
      } else if (mode == 1) {
        arm1Deg += dif;
      } else if (mode == 2) {
        arm2Deg += dif;
      }
    }
    if (key == 'r' || key == 'R') { // リセット
      if (baseDeg != 0) {
        if (baseDeg > 0) {
          baseDeg -= dif;
        } else if (baseDeg < 0) {
          baseDeg += dif;
        }
      }
      if (arm1Deg != 0) {
        if (arm1Deg > 0) {
          arm1Deg -= dif;
        } else if (arm1Deg < 0) {
          arm1Deg += dif;
        }
      }
      if (arm2Deg != 0) {
        if (arm2Deg > 0) {
          arm2Deg -= dif;
        } else if (arm2Deg < 0) {
          arm2Deg += dif;
        }
      }
      if (angleX != 0) {
        if (angleX > 0) {
          if (angleX > 1) {
            angleX -= dif;
          } else if (angleX > 0.01) { //ブレ防止のために最後はゆっくりと戻す
            angleX -= dif/100;
          } else { //最終的にほぼ0に等しくなったら0とする
            angleX = 0;
          }
        } else if (angleX < 0) {
          if (angleX < -1) {
            angleX += dif;
          } else if (angleX < -0.01) {
            angleX += dif/100;
          } else {
            angleX = 0;
          }
        }
      }
      if (angleY != 0) {
        if (angleY > 0) {
          if (angleY > 1) {
            angleY -= dif;
          } else if (angleY > 0.01) {
            angleY -= dif/100;
          } else {
            angleY = 0;
          }
        } else if (angleY < 0) {
          if (angleY < -1) {
            angleY += dif;
          } else if (angleY < -0.01) {
            angleY += dif/100;
          } else {
            angleY = 0;
          }
        }
      }
    }
  }


  if (mousePressed) {
    if (mouseX < width/2) { // X軸方向を逆回転
      angleX = angleX - mousedif * (width/2 - mouseX);
    }
    if (mouseX > width/2) { // X軸方向を正回転
      angleX = angleX + mousedif * (mouseX - width/2);
    }
    if (mouseY < height/2) { // Y軸方向を逆回転
      angleY = angleY - mousedif * (height/2 - mouseY);
    }
    if (mouseY > height/2) { // Y軸方向を正回転
      angleY = angleY + mousedif * (mouseY - height/2);
    }
  }

  //180を超えた時の処理（リセット時の効率化）
  if (baseDeg > 180) {
    baseDeg = -180;
  } else if (baseDeg < -180) {
    baseDeg = 180;
  }
  if (arm1Deg > 180) {
    arm1Deg = -180;
  } else if (arm1Deg < -180) {
    arm1Deg = 180;
  }
  if (arm2Deg > 180) {
    arm2Deg = -180;
  } else if (arm2Deg < -180) {
    arm2Deg = 180;
  }
  if (angleX > 180) {
    angleX = -180;
  } else if (angleX < -180) {
    angleX = 180;
  }
  if (angleY > 180) {
    angleY = -180;
  } else if (angleY < -180) {
    angleY = 180;
  }

  //baseの回転
  rotateZ(radians(baseDeg));
  translate(0, 0, baseH/2);
  fill(255, 0, 0);
  box(baseW, baseD, baseH);
  // link1の回転
  translate(0, 0, baseH/2);
  rotateZ(radians(arm1Deg));
  rotateX(radians(angleX));
  rotateY(radians(angleY));
  // link1
  translate(0, 0, arm1H/2);
  fill(0, 255, 0);
  box(arm1W, arm1D, arm1H);
  // link2の回転
  translate(0, 0, arm1H/2);
  rotateZ(radians(arm2Deg));
  rotateX(radians(angleX));
  rotateY(radians(angleY));
  //link2
  translate(0, 0, arm1H/2);
  fill(0, 0, 255);
  box(arm2W, arm2D, arm2H);
}
