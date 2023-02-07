class mouse {

  float mouse;
  float Length;
  float angle;
  float mousedif;

  mouse(float c_mouse, float c_Length, float c_angle, float c_mousedif) {
    mouse = c_mouse;
    Length = c_Length;
    angle = c_angle;
    mousedif = c_mousedif;
  }

  float move() {
    if (mouse < Length/2) { // X軸方向を逆回転
      angle = angle - mousedif * (Length/2 - mouse);
    } else if (mouse > Length/2) { // X軸方向を正回転
      angle = angle + mousedif * (mouse - Length/2);
    }
    return angle;
  }
}
