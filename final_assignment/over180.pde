class over180 {
  float angle;

  over180(float c_angle) {
    angle = c_angle;
  }

  float reversal() {
    if (angle > 180) {
      angle = -180;
    } else if (angle < -180) {
      angle = 180;
    }
    return angle;
  }
}
