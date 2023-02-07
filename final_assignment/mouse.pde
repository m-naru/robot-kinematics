class mouse {

  float mouse_point;
  float size;
  float angle;
  float mousedif;

  mouse(float c_mouse_point, float c_size, float c_angle, float c_mousedif) {
    mouse_point = c_mouse_point;
    size = c_size;
    angle = c_angle;
    mousedif = c_mousedif;
  }

  float move() {
    if (mouse_point < size/2) { // X軸方向を逆回転
      angle = angle - mousedif * (size/2 - mouse_point);
    } else if (mouse_point > size/2) { // X軸方向を正回転
      angle = angle + mousedif * (mouse_point - size/2);
    }
    return angle;
  }
}
