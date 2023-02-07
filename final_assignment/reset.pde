class Reset {
  float angle;
  float dif;

  Reset(float c_angle, float set_dif) {
    angle = c_angle;
    dif = set_dif;
  }

  float move() {
    if (angle != 0) {
      if (angle > 0) {
        if (angle > 1) {
          angle -= dif;
        } else if (angle > 0.01) { //ブレ防止のために最後はゆっくりと戻す
          angle -= dif/100;
        } else { //最終的にほぼ0に等しくなったら0とする
          angle = 0;
        }
      } else if (angle < 0) {
        if (angle < -1) {
          angle += dif;
        } else if (angle < -0.01) {
          angle += dif/100;
        } else {
          angle = 0;
        }
      }
    }
    return angle;
  }
}
