/**
 * @typedef {function(x: number, y: number, prevColor: number): number} Widget
 */

const TWO_PI = Math.PI * 2;
const PI = Math.PI;
const HALF_PI = Math.PI * 0.5;

/**
 * @param {number} centerX
 * @param {number} centerY
 * @param {number} radius
 * @return {Widget}
 */
export function testWidget(centerX, centerY, radius, color) {
  return (x, y, prevColor) => {
    const currentAngle = ((Date.now() / 3000) % 1) * TWO_PI - PI;
    const deltaX = x - centerX;
    const deltaY = y - centerY;
    const angle = Math.atan2(-deltaY, deltaX);
    const dist = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
    return dist <= radius &&
      (dist === 0 ||
        Math.abs(angle - currentAngle) < HALF_PI ||
        Math.abs(angle - currentAngle + TWO_PI) < HALF_PI ||
        Math.abs(angle - currentAngle - TWO_PI) < HALF_PI)
      ? color
      : prevColor;
  };
}
